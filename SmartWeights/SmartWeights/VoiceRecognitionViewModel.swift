import Foundation
import Speech
import AVFoundation
class VoiceRecognitionViewModel: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechSynthesizer = AVSpeechSynthesizer()
    @Published var isListening = false
    
    override init() {
        super.init()
        speechRecognizer.delegate = self
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
                        // Detected "start workout" command, initiate workout
                        self.stopWorkout()
                        // Cancel the recognition task before stopping the audio engine
                        self.recognitionTask?.cancel()
                        self.recognitionTask = nil
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.audioEngine.stop()
                            inputNode.removeTap(onBus: 0)
                            recognitionRequest.endAudio()
                            print("Stopped listening")
                            self.isListening = false
                        }
                        return
                    } else if bestString.contains("start workout") {
                        // Detected "finish workout" command, stop workout
                        self.startWorkout()
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
        print("Workout started!")
        
        // Synthesize speech
        //               let speechUtterance = AVSpeechUtterance(string: "Workout started")
        //               speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
        //               speechSynthesizer.speak(speechUtterance)
        
    }
    private func stopWorkout(){
        print("Workout Stopped!")
    }
}
