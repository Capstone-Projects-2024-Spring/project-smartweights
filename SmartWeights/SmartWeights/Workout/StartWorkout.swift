import SwiftUI
import Combine
import Speech
import AVFoundation

///view model to handle the workout data
// Define ViewModel
class WorkoutViewModel: ObservableObject {
    @Published var progress: Double = 0
    
    //for user input
    @Published var inputtedSets = ""
    @Published var inputtedReps = ""
    @Published var inputtedWeights = ""
    @Published var currentSets: Int = 0
    
    //timer
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    @Published var timer: Timer? = nil
    @Published var progressInterval = 2.0
    @Published var timerIsActive = true
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechSynthesizer = AVSpeechSynthesizer()
    @Published var isListening = false
    @Published var workoutInProgress = false
    
    
    private var workoutInProgressSubject = PassthroughSubject<Bool, Never>()
    var workoutInProgressPublisher: AnyPublisher<Bool, Never> {
        return workoutInProgressSubject.eraseToAnyPublisher()
    }
    
    //    override init() {
    //        super.init()
    //        speechRecognizer.delegate = self
    //    }
    
    func startListening() {
        guard !isListening else { return }
        isListening = true
        
        let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        do {
            print("listening started")
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.record)
            try AVAudioSession.sharedInstance().setMode(AVAudioSession.Mode.measurement)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            let inputNode = audioEngine.inputNode
            recognitionRequest.shouldReportPartialResults = true
            
            recognitionRequest.taskHint = .dictation
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                recognitionRequest.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            print("still listening")
            let recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] (result, error) in
                guard let self = self else { return }
                
                var isFinal = false
                
                if let result = result {
                    let bestString = result.bestTranscription.formattedString.lowercased()
                    if bestString.contains("finish workout") {
                        // Detected "start workout" command, initiate workout
                        //                        self.stopWorkout()
                        stopTimer()
                        
                        // self.workoutInProgress = false
                        
                        print("Workout stopped. workoutInProgress: \(self.workoutInProgress)")
                        // Cancel the recognition task before stopping the audio engine
                        //                        self.recognitionTask?.cancel()
                        self.recognitionTask = nil
                        
                        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.audioEngine.stop()
                        inputNode.removeTap(onBus: 0)
                        recognitionRequest.endAudio()
                        print("Stopped listening")
                        self.isListening = false
                        // }
                        return
                    } else if bestString.contains("start workout") {
                        // Detected "finish workout" command, stop workout
                        //                        self.startWorkout()
                        startTimer()
                        // self.workoutInProgress = true
                        
                    }
                    print("bestString: \(bestString)")
                    
                    isFinal = result.isFinal
                }
                
                if error != nil || isFinal {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    recognitionRequest.endAudio()
                    print("Stopped listening")
                    self.isListening = false
                }
            }
            
            self.recognitionTask = recognitionTask
        } catch {
            print("Error starting audio engine: \(error.localizedDescription)")
            isListening = false
        }
    }
    
    private func startWorkout() {
        // Call your ViewModel or Model function to start the workout
        if !workoutInProgress {
            workoutInProgress = true
            print("Workout started!")
            workoutInProgressSubject.send(true)
            startTimer()
        }
        
        // Synthesize speech
        //               let speechUtterance = AVSpeechUtterance(string: "Workout started")
        //               speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
        //               speechSynthesizer.speak(speechUtterance)
        
    }
    private func stopWorkout(){
        if workoutInProgress {
            workoutInProgress = false
            print("Workout stopped!")
            workoutInProgressSubject.send(false) // Notify subscribers that the workout has stopped
            stopTimer()
        }
        
    }
    
    /// Function to reset progress
    func resetProgress() {
        progress = 0
    }
    
    /// Function to add progress
    /// - Parameters:
    ///   - data: double
    
    func addProgress(data: Double) {
        progress = data
    }
    
    /// Function to start timer
    
    func startTimer() {
        if let existingTimer = timer {
            existingTimer.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] tempTimer in
            guard let self = self else { return }
            if !self.timerIsActive {
                return
            }
            self.seconds += 1
            if self.seconds == 60 {
                self.seconds = 0
                self.minutes += 1
                if self.minutes == 60 {
                    self.minutes = 0
                    self.hours += 1
                }
            }
        }
    }

    
    /// Function to restart timer
    func restartTimer(){
        hours = 0
        minutes = 0
        seconds = 0
    }
    
    /// Function to stop timer
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    func pauseTimer() {
            timerIsActive = false // Stop updating time without invalidating the timer
        }
    func resumeTimer() {
            timerIsActive = true // Resume updating time
        }
    
    func resetWorkoutState() {
        // Reset progress
        progress = 0
        inputtedSets = ""
        inputtedReps = ""
        inputtedWeights = ""
        currentSets = 0
        
        // Reset timer
        resetTimer()
    }
    
    func resetTimer() {
        stopTimer() // Ensure the current timer is stopped
        hours = 0
        minutes = 0
        seconds = 0
        timerIsActive = false // Ensure timer is not active
    }
    
    
    
    /// Function to generate random number for the progress bar
    /// - Returns: random number between 0 and 1
    ///
    //generate a random number for the progress bar
    //will be removed once we get data
    func generateRandomNumber() -> Double {
        return Double.random(in: 0..<1)
    }
}


#Preview{
    WorkoutMainPage(viewModel: WorkoutViewModel(), bleManager: BLEManager())
}
