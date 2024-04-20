import SwiftUI
import Combine
import Speech
import AVFoundation

///view model to handle the workout data
// Define ViewModel
class WorkoutViewModel: ObservableObject {
    //inherited view models from the parent view
    @ObservedObject var coreDataManager: CoreDataManager
    @ObservedObject var ble: BLEcentral
    @ObservedObject var formCriteria: FormCriteria
    
    init(ble: BLEcentral, formCriteria: FormCriteria, coreDataManager: CoreDataManager) {
        self.ble = ble
        self.formCriteria = formCriteria
        self.coreDataManager = coreDataManager
    }
    
    let storeModel = storeViewModel()
    let workoutPageViewModel = WorkoutPageViewModel()
    
    var player: AVAudioPlayer!
    
    
    var feedback: (String, String, String, String) = ("", "", "", "")
    var feedbackDataForSets: [(String, String, String, String)] = []
    var workoutAnalysis: [String:Double] = [:]
    var workoutAnalysisForSets:[[String:Double]] = []
    var totalSets:Int = 0
    var isWorkingOut = false
    
    
    @Published private var currentWorkoutSession: WorkoutSession?
    @Published private var currentWorkoutSet: ExerciseSet?
    @Published var workoutNum: Int64 = 0
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
    
    @Published var showGraphPopover = false {
        didSet {
            if showGraphPopover {
                self.feedback = formCriteria.giveFeedback(dumbbellArray: ble.MPU6050_1Gyros,elbowArray: ble.MPU6050_2Gyros)
                self.feedbackDataForSets.append(feedback)
                self.workoutAnalysis = formCriteria.UpdateWorkoutAnalysis(totalSets: totalSets, dumbbellArray: ble.MPU6050_1Gyros, elbowArray: ble.MPU6050_2Gyros)
                print(self.workoutAnalysis)
                self.workoutAnalysisForSets.append(self.workoutAnalysis)
                print("hello i am showing that graph popup is working and that the functions are being called")
            }
        }
    }
    @Published var isWorkoutPaused = false
    @Published var hasWorkoutStarted = false
    @Published var showingWorkoutSheet = false
    @Published var countdown = 5
    @Published var countdownActive = false
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var currentMotivationalPhrase = "Let's get started!"
    
    private var countdownTimer: AnyCancellable?
    
    
    
    
    
    
    func startCountdown() {
        countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            guard let self = self else { return }
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                self.countdownTimer?.cancel()
                self.restartTimer()
                self.startTimer()
                self.hasWorkoutStarted = true
                self.showingWorkoutSheet = false
                ble.MPU6050_1Gyros.removeAll() //Clear the collected Data for previous set
                ble.MPU6050_2Gyros.removeAll()
                ble.collectDataToggle = true //Start collecting data for the current workout
                print("reset data has been reset hello")
                let workoutNum = coreDataManager.getNextWorkoutNumber()
                print("workoutNum: \(workoutNum)")
                print("currentSets: \(currentSets)")
                
                if let newWorkoutSession = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: workoutNum, overallCurlAcceleration: 0.0, overallElbowFlareLR: 0.0, overallElbowFlareUD: 0.0, overallElbowSwing: 0.0, overallWristStabilityLR: 0.0, overallWristStabilityUD: 0.0){
                    self.currentWorkoutSession = newWorkoutSession
                    //print(self.currentWorkoutSession as Any)
                    print("THE CREATE WORKOUT WORK?")
                }
                
                print("WE ARE ABOUT TO CREATE A SET WOOOOAHAHAHAH")
                if let newExerciseSet = coreDataManager.createExerciseSet(workoutSession: self.currentWorkoutSession!, setNum: currentSets, avgCurlAcceleration: 0.0, avgElbowFlareLR: 0.0, avgElbowFlareUD: 0.0, avgElbowSwing: 0.0, avgWristStabilityLR: 0.0, avgWristStabilityUD: 0.0){
                    self.currentWorkoutSet = newExerciseSet
                    print("newExerciseSet:")
                    //print(newExerciseSet as Any)
                }
                print("THE CREATE SET WORK?")
            }
        }
    }
    
    func validateAndStartCountdown(sets: String, reps: String, weights: String) {
        if isValidInput(sets) && isValidInput(reps) && isValidInput(weights) {
            countdownActive = true
            startCountdown()
            feedbackDataForSets.removeAll()
            workoutAnalysisForSets.removeAll()
            formCriteria.resetListofData()
            totalSets = Int(sets) ?? 0
            isWorkingOut = true
            self.checkDangerousFormWhileWorkingOut()
        } else {
            alertMessage = "Please enter valid numbers for sets, reps, and weights."
            showingAlert = true
        }
    }
    
    private func isValidInput(_ input: String) -> Bool {
        guard !input.isEmpty, let _ = Int(input) else { return false }
        return true
    }
    
    
    private func stringToInt(_ string: String) -> Int? {
        return Int(string)
    }
    
    
    enum WorkoutStateEnum {
        case idle
        case started
        case paused
        case finished
        case final
    }
    
    //initialize the workout state
    var WorkoutState: WorkoutStateEnum = .idle
    
    var inputNode: AVAudioInputNode!
    var recordingFormat: AVAudioFormat!
    
    func startListening() {
        self.WorkoutState = .idle
        guard !isListening else { return }
        isListening = true
    
        
        let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        do {
            print("Listening started")
            try AVAudioSession.sharedInstance().setCategory(.record)
            try AVAudioSession.sharedInstance().setMode(.measurement)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            self.inputNode = audioEngine.inputNode
            recognitionRequest.shouldReportPartialResults = true
            recognitionRequest.taskHint = .dictation
            
            self.recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                recognitionRequest.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            print("Audio engine started")
            
            
            
            
            let recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] (result, error) in
                guard let self = self else { return }
                
                var isFinal = false
                
                if let result = result {
                    let bestString = result.bestTranscription.formattedString.lowercased()
                    print("Recognized string: \(bestString)")
                    
                    // Use last recognized phrase for command detection to avoid overlapping commands
                    let commands = bestString.components(separatedBy: " ")
                    if let lastCommand = commands.last {
                        switch lastCommand {
                        case "finish":
                            if self.WorkoutState == .final{
                                self.finishWorkout()
                                print("Workout stopped. workoutInProgress: \(self.workoutInProgress)")
                                // Cancel the recognition task before stopping the audio engine
                                // self.recognitionTask?.cancel()
                                // self.recognitionTask = nil
                                
                                // // DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                // self.audioEngine.stop()
                                // inputNode.removeTap(onBus: 0)
                                // recognitionRequest.endAudio()
                                // print("Stopped listening")
                                // self.isListening = false
                                // }
                                return
                            }
                        case "start":
                            if self.WorkoutState == .idle{
                                self.startWorkout()
                                // Check if the inputtedSets equals "1"
                                if self.inputtedSets == "1" {
                                    WorkoutState = .final
                                } else {
                                    WorkoutState = .started
                                }
                                print("Workout started with state: \(WorkoutState)")
                            }
                            
                        case "pause":
                            if self.WorkoutState == .started {
                                self.finishSet()
                                self.WorkoutState = .paused
                                print("Workout paused")
                                
                            }
                        case "next":
                            if self.WorkoutState == .paused {
                                if let sets = stringToInt(inputtedSets), self.currentSets == sets - 1 {
                                    self.finalset()
                                    self.WorkoutState = .final
                                } else {
                                    self.nextset()
                                    self.WorkoutState = .started
                                }
                                
                            }
                        default:
                            break
                        }
                    }
                    
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
    
    
    
    
    func finishSet(){
        WorkoutState = .paused
        currentSets += 1
        isWorkingOut = false
        print("currentSets: \(currentSets)")
        print("IM ABOUT TO CHECK THE CONDITIONAL AAAAAAAAAAAAAHHHHHHH FOR FINISH SET")
        if self.currentWorkoutSet != nil{
            print("THE CONDITIONAL FOR FINISH SET WORKED YEAAAAAAA")
            ble.collectDataToggle = false// continue the data collection
            pauseTimer()
            //generateRandomData(for: .perSet) // Generate per-set data
            print("creating workoutAnalysis")
            showGraphPopover = true
            isWorkoutPaused = true
            print("WE ARE ABOUT TO UPDATE A SET WOOOOAHAHAHAH")
            coreDataManager.updateExerciseSet(self.currentWorkoutSet!, setNum: currentSets, avgCurlAcceleration: workoutAnalysis["averageUpDownAcceleration"], avgElbowFlareLR: workoutAnalysis["averageElbowFlareForwardBackward"], avgElbowFlareUD: workoutAnalysis["averageElbowFlareUpDown"], avgElbowSwing: workoutAnalysis["averageElbowSwing"], avgWristStabilityLR: workoutAnalysis["averageWristLeftRightRotation"], avgWristStabilityUD: workoutAnalysis["averageWristUpDownRotation"])
            print("fetchExerciseSets(for: currentWorkoutSession!):")
            print(coreDataManager.fetchExerciseSets(for: currentWorkoutSession!))
            print("hello i just printed out the coreDataManager.fetchExerciseSets()")
            currentMotivationalPhrase = "Take a breather, then keep going!"
        }
    }
    
    func nextset(){
        WorkoutState = .started
        resumeTimer()
        showGraphPopover = false
        isWorkoutPaused = false
        ble.MPU6050_1Gyros.removeAll() //clears the data for the current set
        ble.MPU6050_2Gyros.removeAll()
        ble.collectDataToggle = true //Stars collecting data again
        currentMotivationalPhrase = "You're doing great!"
        isWorkingOut = true
        self.checkDangerousFormWhileWorkingOut()
    }
    
    
    func startWorkout() {
        WorkoutState = .started
        validateAndStartCountdown(sets: inputtedSets, reps: inputtedReps, weights: inputtedWeights)
        
    }
    
    func finishWorkout(){
        self.WorkoutState = .final
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.audioEngine.stop()
        inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        print("Stopped listening")
        self.isListening = false
        
        print("IM ABOUT TO CHECK THE CONDITIONAL AAAAAAAAAAAAAHHHHHHH FOR FINISH WORKOUT AND FINISH SET")
        if self.currentWorkoutSession != nil && self.currentWorkoutSet != nil{
            print("THE CONDITIONAL FOR FINISH WORKOUT AND SET WORKED YEAAAAAAA")
            totalSets = Int(inputtedSets) ?? 0
            
            // Get feedback from formCriteria
            let currentFeedback = formCriteria.giveFeedback(dumbbellArray: ble.MPU6050_1Gyros, elbowArray: ble.MPU6050_2Gyros)
            
            // Check if feedback indicates poor form
            if currentFeedback.2 == "Whoa slow down!!" {
                // Call function to reduce HP
                workoutPageViewModel.lowerHP()
            }
            
            // Logic for completing the workout
            storeModel.addFundtoUser(price: 50)
            workoutPageViewModel.AddXP(value: 25)
            resetWorkoutState()
            hasWorkoutStarted = false
            isWorkoutPaused = false
            ble.collectDataToggle = false //stops collecting data
            print("creating workoutAnalysis")
            ble.MPU6050_1_All_Gyros.removeAll()//remove all data from current workout (after storing the data)
            ble.MPU6050_2_All_Gyros.removeAll()
            showGraphPopover = true
            print("updating workout session")
            coreDataManager.updateWorkoutSession(self.currentWorkoutSession!, dateTime: Date(), overallCurlAcceleration: workoutAnalysis["overallWorkoutUpDownAverage"] ?? 0.0, overallElbowFlareLR: workoutAnalysis["overallWorkoutElbowFlareForwardBackward"] ?? 0.0, overallElbowFlareUD: workoutAnalysis["overallWorkoutElbowFlareUpDown"] ?? 0.0, overallElbowSwing: workoutAnalysis["overallWorkoutElbowSwing"] ?? 0.0, overallWristStabilityLR: workoutAnalysis["overallDumbbellTwistingLeftRight"] ?? 0.0, overallWristStabilityUD: workoutAnalysis["overallDumbbellTwistingUpDown"] ?? 0.0)
            print("updating final exercise set")
            coreDataManager.updateExerciseSet(self.currentWorkoutSet!, setNum: totalSets, avgCurlAcceleration: workoutAnalysis["averageUpDownAcceleration"], avgElbowFlareLR: workoutAnalysis["averageElbowFlareForwardBackward"], avgElbowFlareUD: workoutAnalysis["averageElbowFlareUpDown"], avgElbowSwing: workoutAnalysis["averageElbowSwing"], avgWristStabilityLR: workoutAnalysis["averageWristLeftRightRotation"], avgWristStabilityUD: workoutAnalysis["averageWristUpDownRotation"])
            print("fetchExerciseSets(for: currentWorkoutSession!):")
            print(coreDataManager.fetchExerciseSets(for: currentWorkoutSession!))
            print("hello i just printed out the coreDataManager.fetchExerciseSets()")
            print("coreDataManager.fetchWorkoutSessions():")
            print(coreDataManager.fetchWorkoutSessions())
            print("hello i just printed out the fetchWorkoutSessions()")
            currentMotivationalPhrase = "Let's get started with a New Workout!"
            isWorkingOut = false
        }
        
        // Logic for completing the workout
        // storeModel.addFundtoUser(price: 50)
        // workoutPageViewModel.AddXP(value: 25)
        // resetWorkoutState()
        // hasWorkoutStarted = false
        // isWorkoutPaused = false
        // ble.collectDataToggle = false //stops collecting data
        // ble.MPU6050_1_All_Gyros.removeAll()//remove all data from current workout (after storing the data)
        // ble.MPU6050_2_All_Gyros.removeAll()
        // showGraphPopover = true
        // currentMotivationalPhrase = "Let's get started with a New Workout!"
        // isWorkingOut = false
        
    }
    
    func finalset(){
        WorkoutState = .final
        currentSets += 1 // This will push the state to "Finish Workout"
        showGraphPopover = false
        resumeTimer()
        ble.MPU6050_1Gyros.removeAll()
        ble.MPU6050_2Gyros.removeAll()
        ble.collectDataToggle = true
        currentMotivationalPhrase = "Last Set! Push through!"
        isWorkingOut = true
        self.checkDangerousFormWhileWorkingOut()
        
    }

    func checkDangerousFormWhileWorkingOut() {
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
        guard let self = self else { return }
        var soundPlayed = false
        while self.isWorkingOut {
            if self.formCriteria.dangerousForm(dumbbellData: self.ble.MPU6050_1_Gyro, elbowData: self.ble.MPU6050_2_Gyro) {
                DispatchQueue.main.async {
                    if !soundPlayed {
                        self.playSound()
                        print("Sound Played")
                        soundPlayed = true
                    }
                }
            } else {
                DispatchQueue.main.async {
                    if soundPlayed {
                        self.stopSound()
                        print("Sound Stopped")
                        soundPlayed = false
                    }
                }
            }
            Thread.sleep(forTimeInterval: 0.1) //to allow main thread to run
        }
        DispatchQueue.main.async {
            if soundPlayed {
                self.stopSound()
                print("Sound Stopped on exit")
            }
        }
    }
}


    
    func playSound() {
        do {
            // try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            // try AVAudioSession.sharedInstance().setActive(true, options: [])
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setMode(.measurement)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Failed to set audio session category: \(error)")
        }
        
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else {
            print("Unable to locate audio file")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print("Failed to initialize audio player: \(error)")
        }
    }
    
    
    func stopSound() {
        player?.stop()
    }
    
    /// Function to start timer
    func startTimer() {
        timerIsActive = true
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
        print("WE ARE ABOUT TO CREATE A SET WOOOOAHAHAHAH")
        if let newExerciseSet = coreDataManager.createExerciseSet(workoutSession: self.currentWorkoutSession!, setNum: currentSets, avgCurlAcceleration: 0.0, avgElbowFlareLR: 0.0, avgElbowFlareUD: 0.0, avgElbowSwing: 0.0, avgWristStabilityLR: 0.0, avgWristStabilityUD: 0.0){
            self.currentWorkoutSet = newExerciseSet
            print("newExerciseSet:")
            print(newExerciseSet as Any)
        }
        print("THE CREATE SET WORK?")
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
    WorkoutMainPage(coreDataManager: CoreDataManager())
}
