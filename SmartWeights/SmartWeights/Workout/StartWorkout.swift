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
    let petpageModel = PetPageFunction()
    
    init(ble: BLEcentral, formCriteria: FormCriteria, coreDataManager: CoreDataManager) {
        self.ble = ble
        self.formCriteria = formCriteria
        self.coreDataManager = coreDataManager
    }
    
    let storeModel = storeViewModel()
    let workoutPageViewModel = WorkoutPageViewModel()
    
    
    var feedback: (String, String, String, String) = ("", "", "", "")
    var feedbackDataForSets: [(String, String, String, String)] = []
    var workoutAnalysis: [String:Double] = [:]
    var workoutAnalysisForSets:[[String:Double]] = []
    var totalSets:Int = 0
    //TODO: IMPLEMENT THE DANGEROUS ASPECT
    var dangerousCalled = false
    var dangerous: Bool {
        formCriteria.dangerousForm(dumbbellArray: ble.MPU6050_1Gyros, elbowArray: ble.MPU6050_2Gyros)
    }
    
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
            print(showGraphPopover,"pop up is showing up")
            if showGraphPopover {
                self.feedback = formCriteria.giveFeedback(dumbbellArray: ble.MPU6050_1Gyros,elbowArray: ble.MPU6050_2Gyros)
                print(formCriteria.giveFeedback(dumbbellArray: ble.MPU6050_1Gyros,elbowArray: ble.MPU6050_2Gyros))
                print(feedback,"this is the feedback")
                self.feedbackDataForSets.append(feedback)
                self.workoutAnalysis = formCriteria.UpdateWorkoutAnalysis(totalSets: totalSets, dumbbellArray: ble.MPU6050_1Gyros, elbowArray: ble.MPU6050_2Gyros)
                print(self.workoutAnalysis)
                self.workoutAnalysisForSets.append(self.workoutAnalysis)
                print(totalSets,"THIS IS THE TOTAL SETS")
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
                    print(self.currentWorkoutSession as Any)
                    print("THE CREATE WORKOUT WORK?")
                }
                
                print("WE ARE ABOUT TO CREATE A SET WOOOOAHAHAHAH")
                if let newExerciseSet = coreDataManager.createExerciseSet(workoutSession: self.currentWorkoutSession!, setNum: currentSets, avgCurlAcceleration: 0.0, avgElbowFlareLR: 0.0, avgElbowFlareUD: 0.0, avgElbowSwing: 0.0, avgWristStabilityLR: 0.0, avgWristStabilityUD: 0.0){
                    self.currentWorkoutSet = newExerciseSet
                    print("newExerciseSet:")
                    print(newExerciseSet as Any)
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
    
    
    enum WorkoutState {
        case idle
        case started
        case paused
        case finished
        case final
    }
    
    
    func startListening() {
        guard !isListening else { return }
        isListening = true
        
        let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        do {
            print("Listening started")
            try AVAudioSession.sharedInstance().setCategory(.record)
            try AVAudioSession.sharedInstance().setMode(.measurement)
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
            print("Audio engine started")
            
            
            var WorkoutState = WorkoutState.idle
            
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
                            if WorkoutState == .final{
                                self.finishWorkout()
                                print("Workout stopped. workoutInProgress: \(self.workoutInProgress)")
                                // Cancel the recognition task before stopping the audio engine
                                self.recognitionTask?.cancel()
                                self.recognitionTask = nil
                                
                                // DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.audioEngine.stop()
                                inputNode.removeTap(onBus: 0)
                                recognitionRequest.endAudio()
                                print("Stopped listening")
                                self.isListening = false
                                // }
                                return
                            }
                        case "start":
                            if WorkoutState == .idle{
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
                            if WorkoutState == .started {
                                self.finishSet()
                                WorkoutState = .paused
                                print("Workout paused")
                            }
                        case "next":
                            if WorkoutState == .paused {
                                if let sets = stringToInt(inputtedSets), self.currentSets == sets - 1 {
                                    self.finalset()
                                    WorkoutState = .final
                                } else {
                                    self.nextset()
                                    WorkoutState = .started
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
        currentSets += 1
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
        resumeTimer()
        showGraphPopover = false
        isWorkoutPaused = false
        ble.MPU6050_1Gyros.removeAll() //clears the data for the current set
        ble.collectDataToggle = true //Stars collecting data again
        currentMotivationalPhrase = "You're doing great!"
    }
    
    
    func startWorkout() {
        validateAndStartCountdown(sets: inputtedSets, reps: inputtedReps, weights: inputtedWeights)
    }
    
    func finishWorkout(){
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
            
            print("hello test, looking for bad form hehehe")
            print(currentFeedback.2)
            // Logic for completing the workout
            storeModel.addFundtoUser(price: 50)
//            workoutPageViewModel.AddXP(value: 25)
            petpageModel.addXP(value: 25)
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
        }
    }
    
    func finalset(){
        currentSets += 1 // This will push the state to "Finish Workout"
        showGraphPopover = false
        resumeTimer()
        ble.MPU6050_1Gyros.removeAll()
        ble.MPU6050_2Gyros.removeAll()
        ble.collectDataToggle = true
        currentMotivationalPhrase = "Last Set! Push through!"
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
    WorkoutMainPage()
}
