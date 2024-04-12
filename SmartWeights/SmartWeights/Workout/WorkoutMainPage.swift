import SwiftUI
import Combine

/// Main structure to display the workout page with integrated UI components
struct WorkoutMainPage: View {
    @StateObject var viewModel = WorkoutViewModel()
    @ObservedObject var ble = BLEcentral()
    @ObservedObject var formCriteria = FormCriteria()
    @StateObject var storeModel = storeViewModel()
    @ObservedObject var workoutPageViewModel = WorkoutPageViewModel()
    
    @State private var workoutSubscription: AnyCancellable?
    @State private var selectedTab = 0
    @State private var isExpanded = false
    @State private var hasWorkoutStarted = false
    @State private var showingWorkoutSheet = false
    @State private var isWorkoutPaused = false
    
    @State private var showGraphPopover = false
    @State private var graphData: [Double] = []
    var feedback: (String,String,String) {
        formCriteria.giveFeedback(dumbbellArray: ble.MPU6050_1Gyros,elbowArray: ble.MPU6050_2Gyros)
       }
    
    @State private var currentMotivationalPhrase = "Let's get started!"

    
    
    var body: some View {
        ZStack {
            
            VStack {
                // Title and microphone button for workout voice control
                workoutTitleView
                
                // Tab selection for workout or feedback
                workoutTabSelection
                
                // Content based on selected tab
                if selectedTab == 0 {
                    StartWorkoutView
                } else if selectedTab == 1 {
                    WorkoutFeedback(viewModel: viewModel)
                }
            }
            
            .popover(isPresented: $showGraphPopover) {
                VStack {
                    HStack {
                        Spacer() // Pushes the button to the right
                        Button(action: {
                            showGraphPopover = false // Close the popover
                        }) {
                            Image(systemName: "xmark.circle.fill") // Stylish X mark
                                .font(.title) // Increases the size a bit
                                .foregroundColor(.gray) // A neutral color
                        }
                        .padding(.trailing, 20) // Give some space from the edge
                        .accessibilityLabel("Close") // Accessibility label for better UX
                    }
                    .padding(.top, 10) // Give some space from the top edge
                
                    //Text("workout Progress Graph")
                    Text("Feedback")
                        .font(.headline)
                    
//                    LineGraph(data: graphData) // Use the dynamic data for the line graph
//                        .stroke(Color.green, lineWidth: 2)
//                        .frame(height: 200)
//                        .padding()
                    
                    VStack{
                        HStack {
                            ZStack {
                                Image("bubble")
                                    .resizable()
                                    .frame(width: 250, height: 150)
                                Text("\(feedback.1)")
                                    .foregroundStyle(Color.black)
                            }
                            .padding(.bottom, -40)
                        }
                        HStack{
                            
                            Image("Dog")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 175)
                        }
                        Text("\(feedback.0)") //gives overall acceleration
                            .font(.subheadline)
                    }
                    .padding(.bottom, 30)
                    
                }
                .frame(width: 400, height: 500)
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .shadow(radius: 10)
            }
        }
    }
    
    enum SetType {
        case perSet
        case overallWorkout
    }
    
    private func generateRandomData(for setType: SetType) {
        switch setType {
        case .perSet:
            graphData = (1...10).map { _ in Double.random(in: 5...15) } // Simulate repetitions or form consistency within a set
        case .overallWorkout:
            graphData = (1...5).map { _ in Double.random(in: 50...150) } // Simulate overall workout progress, e.g., total weight lifted
        }
    }
    
    
    private var workoutTitleView: some View {
        ZStack {
            Text("Workout")
                .font(.title)
                .bold()
        }
    }
    
    private var workoutTabSelection: some View {
        Picker(selection: $selectedTab, label: Text("Select a tab")) {
            Text("Exercise").tag(0)
            Text("Feedback").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .foregroundColor(.white)
        .background(Color.gray)
        .accessibilityLabel("WorkoutSelectTab")
    }
    
    // Compute the button text based on current and total sets
    private var buttonText: String {
        let totalSets = Int(viewModel.inputtedSets) ?? 0
        if hasWorkoutStarted {
            if viewModel.currentSets >= totalSets {
                return "Finish Workout" // When all sets are completed, regardless of the number of sets
            } else if totalSets == 1 {
                // If there is only 1 set, the button should immediately suggest finishing the workout
                // This case is handled upfront to ensure "Finish Workout" is shown for a single set scenario
                return "Finish Workout"
            } else if viewModel.currentSets == totalSets - 1 {
                // For more than one set, this becomes the "Final Set" before "Finish Workout"
                return "Final Set"
            } else {
                // Default case for any sets that are not the last or only set
                return isWorkoutPaused ? "Start Next Set" : "Finish Set"
            }
        } else {
            // Before the workout starts
            return "Start Workout"
        }
    }


    
    
    
    private var StartWorkoutView: some View {
        VStack {
            if !hasWorkoutStarted {
                Text("Prepare for your workout")
                    .bold()
            }
            
            
            ZStack{
                // Time rectangel box
                RoundedRectangle(cornerRadius:  25)
                    .frame(width: 250, height: 50)
                    .foregroundColor(.blue)
                HStack{
                    Text("Time: ")
                        .font(.system(size: 25))
                        .bold()
                        .foregroundStyle(.green)
                    Text("\(viewModel.hours):\(viewModel.minutes):\(viewModel.seconds)")
                        .font(.system(size: 25))
                        .bold()
                        .foregroundStyle(.green)
                }
            }
            .padding(.bottom, -15)
            
            
            
            HStack {
                ZStack {
                    Image("bubble")
                        .resizable()
                        .frame(width: 350, height: 150)
                    Text(currentMotivationalPhrase)
                        .foregroundStyle(Color.black)
                }
                .padding(.bottom, -50)
            }
            HStack{
                
                Image("Dog")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 375)
            }

            
            
            // Start/Reset workout button
            Button(action: {
                if hasWorkoutStarted {
                    if buttonText == "Finish Workout" {
                        // Logic for completing the workout
                        generateRandomData(for: .overallWorkout) // Generate overall workout data
                        storeModel.addFundtoUser(price: 50)
                        workoutPageViewModel.AddXP(value: 25)
                        viewModel.resetWorkoutState()
                        hasWorkoutStarted = false
                        isWorkoutPaused = false
                        ble.collectDataToggle = false //stops collecting data
                        print("hello")
                        //ble.MPU6050_1Gyros.removeAll()
                        //need to add this data to another array to store for workout history
                        ble.MPU6050_1_All_Gyros.removeAll()//remove all data from current workout (after storing the data)
                        showGraphPopover = true
                        currentMotivationalPhrase = "Let's get started with a New Workout!"

                        
                    } else if buttonText == "Final Set" {
                        // Logic for transitioning from the final set to finishing the workout
                        viewModel.currentSets += 1 // This will push the state to "Finish Workout"
                        showGraphPopover = false
                        viewModel.resumeTimer()
                        ble.MPU6050_1Gyros.removeAll()
                        ble.collectDataToggle = true
                        currentMotivationalPhrase = "Last Set! Push through!"
                    } else if !isWorkoutPaused {
                        ble.collectDataToggle = false// continue the data collection
                        viewModel.pauseTimer()
                        generateRandomData(for: .perSet) // Generate per-set data
                        showGraphPopover = true
                        isWorkoutPaused = true
                        currentMotivationalPhrase = "Take a breather, then keep going!"
                        if let totalSets = Int(viewModel.inputtedSets), viewModel.currentSets < totalSets {
                            viewModel.currentSets += 1
                        }
                    } else {
                        // Resume workout from a paused state
                        viewModel.resumeTimer()
                        showGraphPopover = false
                        isWorkoutPaused = false
                        ble.MPU6050_1Gyros.removeAll() //clears the data for the current set
                        ble.collectDataToggle = true //Stars collecting data again
                        currentMotivationalPhrase = "You're doing great!"
                    }
                } else {
                    // Start the workout
                    currentMotivationalPhrase = "First set, let's go!"
                    viewModel.resumeTimer()
                    showingWorkoutSheet = true
                    showGraphPopover = false
        
                }
            }) {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 300, height: 80)
                    .foregroundColor(hasWorkoutStarted ? (isWorkoutPaused ? .blue : .red) : .gray)
                    .overlay(
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                    )
            }
            .accessibilityLabel(hasWorkoutStarted ? (isWorkoutPaused ? "NextSetButton" : "FinishSetButton") : "StartWorkoutButton")
            .sheet(isPresented: $showingWorkoutSheet) {
                WorkoutDetailsInputView(viewModel: viewModel, ble: ble, hasWorkoutStarted: $hasWorkoutStarted, showingWorkoutSheet: $showingWorkoutSheet)
            }
            
            
            /*
             // Connection status and acceleration data
             if bleManager.isConnected {
             Text("Sensor connected")
             } else {
             Text("Sensor disconnected")
             }
             Text("Acceleration - X: \(bleManager.accelerations[0]) Y: \(bleManager.accelerations[1]) Z: \(bleManager.accelerations[2])")
             .padding()
             Spacer()
             */
            Spacer()
        }
        
    }
    
    
    struct LineGraph: Shape {
        var data: [Double]
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            guard data.count > 1 else {
                return path
            }
            
            let step = rect.width / CGFloat(data.count - 1)
            var x: CGFloat = 0
            let maxY = data.max() ?? 0
            let ratio = rect.height / CGFloat(maxY)
            
            for i in data.indices {
                let y = CGFloat(data[i]) * ratio
                
                if i == 0 {
                    path.move(to: CGPoint(x: x, y: rect.height - y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: rect.height - y))
                }
                
                x += step
            }
            
            return path
        }
    }
    
    // Define a new view for the workout details input form
    struct WorkoutDetailsInputView: View {
        
        @ObservedObject var viewModel: WorkoutViewModel
        @ObservedObject var ble: BLEcentral
        @Binding var hasWorkoutStarted: Bool
        @Binding var showingWorkoutSheet: Bool
        @State private var showingAlert = false
        @State private var alertMessage = ""
        @State private var countdown = 5 // New state variable for countdown
        @State private var countdownTimer: AnyCancellable? // Timer for countdown
        @State private var countdownActive = false // Indicates if the countdown is active
        
        var body: some View {
            
            ZStack {
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 60, height: 6)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .padding(.top, 5)
                VStack {
                    if countdownActive {
                        // Countdown UI
                        Text("Starting in \(countdown)")
                            .font(.largeTitle)
                            .padding()
                            .onAppear {
                                startCountdown()
                            }
                    } else {
                        // Regular input form
                        HStack {
                            Text("Enter Workout Details")
                                .font(.headline)
                            
                            Button(action: {
                                // Action to trigger voice input or start listening for commands
                                viewModel.startListening()
                            }) {
                                Image(systemName: "mic.circle")
                                    .resizable()
                                    .frame(width: 25, height: 25) // Adjusted size for better fit
                                    .padding(.leading, 5)
                            }
                            .accessibilityLabel("Start Voice Command")
                        }
                        .padding()
                        
                        TextField("Sets", text: $viewModel.inputtedSets)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .padding()
                        
                        TextField("Reps", text: $viewModel.inputtedReps)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .padding()
                        
                        TextField("Weight (lbs)", text: $viewModel.inputtedWeights)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .padding()
                        
                        
                        Button("Start Workout") {
                            if isValidInput(viewModel.inputtedSets) && isValidInput(viewModel.inputtedReps) && isValidInput(viewModel.inputtedWeights) {
                                // Initiate countdown
                                countdownActive = true
                            } else {
                                alertMessage = "Please enter valid numbers for sets, reps, and lbs."
                                showingAlert = true
                            }
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                }
                .frame(width: 400, height: 350)
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .shadow(radius: 10)
            }
        }
        
        private func isValidInput(_ input: String) -> Bool {
            guard !input.isEmpty, let _ = Int(input) else { return false }
            return true
        }
        
        private func startCountdown() {
            countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
                if countdown > 0 {
                    countdown -= 1
                } else {
                    countdownTimer?.cancel() // Stop the countdown timer
                    DispatchQueue.main.async {
                        hasWorkoutStarted = true // Ensure this change is captured by the UI
                        showingWorkoutSheet = false // Dismiss or update UI as needed
                        viewModel.startTimer() // Start the main workout timer after countdown
                        ble.MPU6050_1Gyros.removeAll() //Clear the collected Data for previous set
                        ble.collectDataToggle = true //Start collecting data for the current workout
                        
                        
                    }
                }
            }
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
}

#Preview {
    WorkoutMainPage()
}
