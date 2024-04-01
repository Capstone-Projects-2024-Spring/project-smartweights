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
    
    //timer
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    @Published var timer: Timer? = nil
    @Published var progressInterval = 2.0
    
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
    
    func startTimer(){
         // Stop any existing timer before starting a new one
    if let existingTimer = timer {
        existingTimer.invalidate()
    }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if self.seconds == 59 {
                self.seconds = 0
                if self.minutes == 59 {
                    self.minutes = 0
                    self.hours += 1
                } else {
                    self.minutes += 1
                }
            } else {
                self.seconds += 1
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
    /// Function to generate random number for the progress bar
    /// - Returns: random number between 0 and 1
    ///
    //generate a random number for the progress bar
    //will be removed once we get data
    func generateRandomNumber() -> Double {
        return Double.random(in: 0..<1)
    }
    
    
    
}
///view to show the progress bar
struct CircularProgressView: View {
    
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.pink.opacity(0.5),
                    lineWidth: 10
                )
                .frame(width: 80)
            Circle()
        
                .trim(from: 0, to: progress)
                .stroke(
                    Color.pink,
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
                .frame(width: 80)
                
        }
    }
}

///view to show the start workout page
struct StartWorkout: View {
    /// Create an instance of the shared view model
    // Create an instance of the shared view model
    @ObservedObject var viewModel: WorkoutViewModel
    @ObservedObject var bleManager: BLEManager
    
    var body: some View {
        //user inputting their desired weights, reps and sets
        Text((viewModel.inputtedReps.isEmpty || viewModel.inputtedSets.isEmpty) ? "BenchPress:" : "BenchPress: \(viewModel.inputtedSets) x \(viewModel.inputtedReps)")
            .bold()
        
        Text(viewModel.inputtedWeights.isEmpty ? "Dumbell Weights: 0 lbs":"Dumbell Weights: \(viewModel.inputtedWeights) lbs")
            .bold()
        
        HStack{
            VStack{
                TextField("Sets", text: $viewModel.inputtedSets)
                    .keyboardType(.default)
                    .onReceive(Just(viewModel.inputtedSets)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            viewModel.inputtedSets = filtered
                        }
                    }
                    .bold()
                    .textFieldStyle(.roundedBorder)
                    .frame(width:80)
                    .font(.system(size: 14))
                
            }
            
            VStack{
                TextField("Reps", text: $viewModel.inputtedReps)
                    .keyboardType(.default)
                    .onReceive(Just(viewModel.inputtedReps)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            viewModel.inputtedReps = filtered
                        }
                    }
                    .bold()
                    .textFieldStyle(.roundedBorder)
                    .frame(width:80)
                    .font(.system(size: 14))
                
            }
            VStack{
                TextField("lbs", text: $viewModel.inputtedWeights)
                    .keyboardType(.default)
                    .onReceive(Just(viewModel.inputtedWeights)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            viewModel.inputtedWeights = filtered
                        }
                    }
                    .bold()
                    .textFieldStyle(.roundedBorder)
                    .frame(width:80)
                    .font(.system(size: 14))
                    
                
            }
        }
        .padding(.top)
        .padding(.bottom,45)
       
        Spacer()
        
        //to create the four boxes
        HStack{
            VStack{
                ZStack{
                    ZStack{
                        RoundedRectangle(cornerRadius:  25)
                            .frame(width: 100, height: 100)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("Time")
                            .font(.system(size: 14))
                            .bold()
                            .padding(.bottom,70)
                            .foregroundColor(.white)
                        
                    }
                    Text("\(viewModel.hours):\(viewModel.minutes):\(viewModel.seconds)")
                        .bold()
                        .monospaced()
                        .foregroundStyle(.green)
                    
                Spacer()
                }
                ZStack{
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 100, height: 100)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                   
                    
                        Text("Remaining\n      Sets")
                            .font(.system(size: 14))
                            .bold()
                            .padding(.bottom, 50)
                            .foregroundColor(.white)
                            
                        Text("\(viewModel.inputtedSets)")
                        .padding(.top, 20)
                        .bold()
                        .foregroundColor(.white)
                    
                }
               
                
            }
            Spacer()
            ZStack {
                Image("dog")
                    .resizable()
                .frame(width: 140, height: 140)
                /*
                Image("jetpack")
                    .resizable()
                .frame(width: 140, height: 140)
                
                Image("dog")
                    .resizable()
                .frame(width: 140, height: 140)
                
                Image("glasses")
                    .resizable()
                .frame(width: 140, height: 140)
                */
                
            }
            Spacer()
            
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    Text("Form")
                        .font(.system(size: 14))
                        .bold()
                        .foregroundColor(.white)
                    CircularProgressView(progress: viewModel.progress)
                        .frame(width: 100, height: 100)
                    
                }
                ZStack{
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    Text("Accel")
                        .font(.system(size: 14))
                        .bold()
                        .foregroundColor(.white)
                    CircularProgressView(progress: viewModel.progress)
                        .frame(width: 100, height: 100)
                }
                
            }
        }
        .padding(.leading,10)
        .padding(.trailing, 10)
        .padding(.bottom,10)
        
        //new workout button to reset everything
        ZStack{
            ZStack{
                Button(action: { // Back Arrow
                    print("Button tapped (temp)")
                    viewModel.resetProgress()
                    viewModel.restartTimer()
                    viewModel.stopTimer()
                    
                })
                {
                    ZStack{
                        RoundedRectangle(cornerRadius:  25)
                            .frame(width: 300, height: 80)
                            .foregroundColor(.gray)
                        Text("New workout")
                            .bold()
                            .foregroundStyle(.white)
                    }
                }
                .accessibilityLabel("NewWorkoutButton")
                
            }
            
        }
        
        if bleManager.isConnected{
            Text("Sensor connected")
        }
        else{
            Text("Sensor disconnected")
        }
        Text("Acceleration - X: \(bleManager.accelerations[0]) Y: \(bleManager.accelerations[1]) Z: \(bleManager.accelerations[2])") // Display the last temperature in the array
            .padding()
        Spacer()
        
    }
    
}


#Preview{
    StartWorkout(viewModel: WorkoutViewModel(), bleManager: BLEManager())
}
