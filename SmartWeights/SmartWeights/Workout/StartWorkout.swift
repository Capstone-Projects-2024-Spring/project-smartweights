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
    
    @Published var showGraphPopover = false
    @Published var isWorkoutPaused = false
    @Published var hasWorkoutStarted = false
    @Published var showingWorkoutSheet = false
    @Published var countdown = 5
    @Published var countdownActive = false
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var currentMotivationalPhrase = "Let's get started!"

    private var countdownTimer: AnyCancellable?
    
    
    let ble  = BLEcentral()
    let storeModel = storeViewModel()
    let workoutPageViewModel = WorkoutPageViewModel()
    
    func startCountdown() {
        countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            guard let self = self else { return }
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                self.countdownTimer?.cancel()
                self.startTimer()
                self.hasWorkoutStarted = true
                self.showingWorkoutSheet = false
            }
        }
    }
    
    func validateAndStartCountdown(sets: String, reps: String, weights: String) {
        if isValidInput(sets) && isValidInput(reps) && isValidInput(weights) {
            countdownActive = true
            startCountdown()
        } else {
            alertMessage = "Please enter valid numbers for sets, reps, and weights."
            showingAlert = true
        }
    }
    
    private func isValidInput(_ input: String) -> Bool {
        guard !input.isEmpty, let _ = Int(input) else { return false }
        return true
    }
    
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
                        // Logic for completing the workout
                        //generateRandomData(for: .overallWorkout) // Generate overall workout data
                        storeModel.addFundtoUser(price: 50)
                        workoutPageViewModel.AddXP(value: 25)
                        resetWorkoutState()
                        hasWorkoutStarted = false
                        isWorkoutPaused = false
                        ble.collectDataToggle = false //stops collecting data
                        print("hello")
                        //ble.MPU6050_1Gyros.removeAll()
                        //need to add this data to another array to store for workout history
                        ble.MPU6050_1_All_Gyros.removeAll()//remove all data from current workout (after storing the data)
                        showGraphPopover = true
                        currentMotivationalPhrase = "Let's get started with a New Workout!"
                        
                        print("Workout stopped. workoutInProgress: \(self.workoutInProgress)")
                        
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
                        self.startWorkout()
                        //startCountdown()
                    }
                    
                    if bestString.contains("finish set") {
                        ble.collectDataToggle = false// continue the data collection
                        pauseTimer()
                        //generateRandomData(for: .perSet) // Generate per-set data
                        showGraphPopover = true
                        isWorkoutPaused = true
                        currentMotivationalPhrase = "Take a breather, then keep going!"
                        if let totalSets = Int(inputtedSets), currentSets < totalSets {
                        currentSets += 1
                        }
                    } else if bestString.contains("final set") {
                        currentSets += 1 // This will push the state to "Finish Workout"
                        showGraphPopover = false
                        resumeTimer()
                        ble.MPU6050_1Gyros.removeAll()
                        ble.collectDataToggle = true
                        currentMotivationalPhrase = "Last Set! Push through!"
                    } else if bestString.contains("next set"){
                        resumeTimer()
                        showGraphPopover = false
                        isWorkoutPaused = false
                        ble.MPU6050_1Gyros.removeAll() //clears the data for the current set
                        ble.collectDataToggle = true //Stars collecting data again
                        currentMotivationalPhrase = "You're doing great!"
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
    
    
    
    
    func startWorkout() {
        validateAndStartCountdown(sets: inputtedSets, reps: inputtedReps, weights: inputtedWeights)
    }
    /*
    func finishset(){
        ble.collectDataToggle = false// continue the data collection
        pauseTimer()
        //generateRandomData(for: .perSet) // Generate per-set data
        showGraphPopover = true
        isWorkoutPaused = true
        currentMotivationalPhrase = "Take a breather, then keep going!"
        if let totalSets = Int(inputtedSets),
            currentSets < totalSets {
            currentSets += 1
        }
    }
    
    func nextset(){
        resumeTimer()
        showGraphPopover = false
        isWorkoutPaused = false
        ble.MPU6050_1Gyros.removeAll() //clears the data for the current set
        ble.collectDataToggle = true //Stars collecting data again
        currentMotivationalPhrase = "You're doing great!"
    }
    
    func finalset(){
        // Logic for transitioning from the final set to finishing the workout
        currentSets += 1 // This will push the state to "Finish Workout"
        showGraphPopover = false
        resumeTimer()
        ble.MPU6050_1Gyros.removeAll()
        ble.collectDataToggle = true
        currentMotivationalPhrase = "Last Set! Push through!"
    }
    
    func finishworkout(){
        // Logic for completing the workout
        //generateRandomData(for: .overallWorkout) // Generate overall workout data
        storeModel.addFundtoUser(price: 50)
        workoutPageViewModel.AddXP(value: 25)
        resetWorkoutState()
        hasWorkoutStarted = false
        isWorkoutPaused = false
        ble.collectDataToggle = false //stops collecting data
        print("hello")
        //ble.MPU6050_1Gyros.removeAll()
        //need to add this data to another array to store for workout history
        ble.MPU6050_1_All_Gyros.removeAll()//remove all data from current workout (after storing the data)
        showGraphPopover = true
        currentMotivationalPhrase = "Let's get started with a New Workout!"

    }
    
    private func stopWorkout(){
        if workoutInProgress {
            workoutInProgress = false
            print("Workout stopped!")
            workoutInProgressSubject.send(false) // Notify subscribers that the workout has stopped
            stopTimer()
        }
        
    }
     */
    
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
        countdownActive = false
        countdown = 5 // Reset to your initial countdown value
        
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
    WorkoutMainPage(viewModel: WorkoutViewModel())
}
