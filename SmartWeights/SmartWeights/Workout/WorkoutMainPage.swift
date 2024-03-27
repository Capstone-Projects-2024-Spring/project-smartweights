import SwiftUI
import Combine
///structure to display the main workout page
struct WorkoutMainPage: View {
    ///created an instance of the view model
    @StateObject var viewModel = WorkoutViewModel()
    //    @StateObject var voiceVM = VoiceRecognitionViewModel()
    @StateObject var bleManager = BLEManager()
    
    @State private var workoutSubscription: AnyCancellable?
    
    //workout/feedback nav on top of app
    @State private var selectedTab = 0
    
    @State private var isExpanded = false
    
    var body: some View {
        ZStack{
            
            
            VStack {
                ZStack { //Title
                    
                    Text("Workout")
                        .font(.title)
                        .bold()
                    
                    
                    if selectedTab == 0 {
                        VStack{
                            Button(action: {
                                
                                // Start workout button action
                                //                                isExpanded.toggle()
                                viewModel.startListening()
                                
                                // DispatchQueue.global().async {
                                //     while true {
                                //         if voiceVM.workoutInProgress {
                                //             DispatchQueue.main.async {
                                //                 viewModel.startTimer()
                                //             }
                                //         } else {
                                //             DispatchQueue.main.async {
                                //                 viewModel.stopTimer()
                                //             }
                                //         }
                                //         sleep(1) // Wait for 1 second before checking again
                                //     }
                                // }
                                
                                
                            }) {
                                Image(systemName: "mic.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            .accessibilityLabel("micWorkoutButton")
                            .padding(.trailing, 42)
                            //                            .onAppear {
                            //                                workoutSubscription = voiceVM.$workoutInProgress.sink { inProgress in
                            //                                    print("Workout in progress changed: \(inProgress)")
                            //                                    if inProgress {
                            //                                        viewModel.startTimer()
                            //                                        print("startTimer called")
                            //                                    } else {
                            //                                        viewModel.stopTimer()
                            //                                        print("stopTimer Called")
                            //                                    }
                            //                                }
                            //                            }
                            //                            .onReceive(voiceVM.workoutInProgressPublisher
                            //                                .debounce(for: .milliseconds(200), scheduler: RunLoop.main)) { inProgress in
                            //                                    if inProgress {
                            //                                        viewModel.startTimer()
                            //                                        print("startTimer called")
                            //                                    } else {
                            //                                        viewModel.stopTimer()
                            //                                        print("stopTimer Called")
                            //                                    }
                            //                                }
                        }
                        
                        .padding(.leading,300)
                    }
                }
                
                //Selecting the workout tab or the feedback tab
                Picker(selection: $selectedTab, label: Text("Select a tab")) {
                    Text("Exercise").tag(0)
                    Text("Feedback").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(.white)
                .background(Color.gray)
                .accessibilityLabel("WorkoutSelectTab")
                
                
                
                if(selectedTab == 0){
                    // Pass the view model instance to StartWorkout view
                    StartWorkout(viewModel: viewModel, bleManager: bleManager)
                    
                    
                    Spacer()
                }
                //Passing the view model instance to the FeedBack
                else if (selectedTab == 1){
                    
                    WorkoutFeedback(viewModel: viewModel)
                    Spacer()
                }
                
                
            }
            
        }
        .background(Color.black)
        .foregroundColor(.gray)
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
                .trim(from: 0, to: progress / 100) // Adjust this line if `progress` is a percentage
                .stroke(
                    Color.blue,
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
    @State private var hasWorkoutStarted = false
    
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
                        // Time rectangel box
                        RoundedRectangle(cornerRadius:  25)
                            .frame(width: 150, height: 150)
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
                }
                ZStack{
                    // Remaining set box
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 150, height: 150)
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
            
            VStack{
                ZStack{
                    // Form Rectangle box
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                    Text("Form")
                        .font(.system(size: 14))
                        .bold()
                        .foregroundColor(.white)
                    CircularProgressView(progress: viewModel.progress)
                    
                }
                ZStack{
                    // Accel Rectange box
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                    Text("Accel")
                        .font(.system(size: 14))
                        .bold()
                        .foregroundColor(.white)
                    CircularProgressView(progress: viewModel.progress)
                }
            }
        }
        
        
        // Button to Start or Reset Workout
        Button(action: {
            if hasWorkoutStarted {
                // Reset for a new workout
                viewModel.resetProgress()
                viewModel.restartTimer()
                viewModel.stopTimer()
                // Any additional reset logic here
            } else {
                // Start the workout
                viewModel.startListening() // Start listening or any initial setup
                viewModel.startTimer() // Start the workout timer
                // Include any other actions to initialize the workout
            }
            hasWorkoutStarted.toggle() // Toggle the workout state
        }) {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 300, height: 80)
                .foregroundColor(.gray)
                .overlay(
                    Text(hasWorkoutStarted ? "New Workout" : "Start Workout")
                        .bold()
                        .foregroundColor(.white)
                )
        }
        .accessibilityLabel(hasWorkoutStarted ? "NewWorkoutButton" : "StartWorkoutButton")
        
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

#Preview {
    WorkoutMainPage()
}
