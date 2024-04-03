import SwiftUI
import Combine

/// Main structure to display the workout page with integrated UI components
struct WorkoutMainPage: View {
    @StateObject var viewModel = WorkoutViewModel()
    @StateObject var bleManager = BLEManager()
    
    @State private var workoutSubscription: AnyCancellable?
    @State private var selectedTab = 0
    @State private var isExpanded = false
    @State private var hasWorkoutStarted = false
    @State private var showingWorkoutSheet = false
    @State private var isWorkoutPaused = false
    
    @State private var showGraphPopover = false
    @State private var graphData: [Double] = []
    
    
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
                    
                    Text("Workout Progress Graph")
                        .font(.headline)
                        .padding()
                    
                    LineGraph(data: graphData) // Use the dynamic data for the line graph
                        .stroke(Color.green, lineWidth: 2)
                        .frame(height: 200)
                        .padding()
                }
                .frame(width: 400, height: 400)
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
                return "Finish Workout" // Changes here to ensure "Finish Workout" shows up right after the final set
            } else if viewModel.currentSets == totalSets - 1 {
                return "Final Set"
            } else if viewModel.currentSets < totalSets {
                return isWorkoutPaused ? "Next Set" : "Finish Set"
            } else {
                return "Complete Workout"
            }
        } else {
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
            
            // Reps count display
            if hasWorkoutStarted {
                HStack {
                    Text("Sets: ")
                        .font(.title2)
                        .bold()
                    
                    Text("\(viewModel.currentSets) / \(viewModel.inputtedSets)")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.orange)
                }
                .padding()
            }
            
            
            HStack{
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
            
            
            // Start/Reset workout button
            Button(action: {
                if hasWorkoutStarted {
                    if buttonText == "Finish Workout" {
                        // Logic for completing the workout
                        generateRandomData(for: .overallWorkout) // Generate overall workout data
                        viewModel.resetWorkoutState()
                        hasWorkoutStarted = false
                        isWorkoutPaused = false
                        showGraphPopover = true
                    } else if buttonText == "Final Set" {
                        // Logic for transitioning from the final set to finishing the workout
                        viewModel.currentSets += 1 // This will push the state to "Finish Workout"
                        showGraphPopover = false
                        viewModel.resumeTimer()
                    } else if !isWorkoutPaused {
                        viewModel.pauseTimer()
                        generateRandomData(for: .perSet) // Generate per-set data
                        showGraphPopover = true
                        isWorkoutPaused = true
                        
                        if let totalSets = Int(viewModel.inputtedSets), viewModel.currentSets < totalSets {
                            viewModel.currentSets += 1
                        }
                    } else {
                        // Resume workout from a paused state
                        viewModel.resumeTimer()
                        showGraphPopover = false
                        isWorkoutPaused = false
                    }
                } else {
                    // Start the workout
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
                WorkoutDetailsInputView(viewModel: viewModel, hasWorkoutStarted: $hasWorkoutStarted, showingWorkoutSheet: $showingWorkoutSheet)
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
        @Binding var hasWorkoutStarted: Bool
        @Binding var showingWorkoutSheet: Bool
        @State private var showingAlert = false
        @State private var alertMessage = ""
        @State private var countdown = 5 // New state variable for countdown
        @State private var countdownTimer: AnyCancellable? // Timer for countdown
        @State private var countdownActive = false // Indicates if the countdown is active
        
        var body: some View {
            ZStack {
                VStack(spacing: 20) { // Adjusted for layout consistency
                    // Use an HStack for alignment of the microphone button to the right
                    HStack {
                        Text("Enter Workout Details")
                            .font(.system(size: 30))
                            .bold()
                            .frame(maxWidth: .infinity) // This will push the text to the center
                        
                        Button(action: {
                            viewModel.startListening()
                            print("Microphone tapped")
                        }) {
                            Image(systemName: "mic.circle")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                    }
                    .padding(.horizontal) // Add horizontal padding to the HStack
                    
                    if countdownActive {
                        // Countdown UI
                        Text("Starting in \(countdown)")
                            .font(.largeTitle)
                            .padding()
                            .onAppear {
                                startCountdown()
                            }
                    } else {
                        // Regular input form now includes the microphone button at the top
                        Group {
                            TextField("Sets", text: $viewModel.inputtedSets)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                            
                            TextField("Reps", text: $viewModel.inputtedReps)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                            
                            TextField("Weight (lbs)", text: $viewModel.inputtedWeights)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                            
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
                        .padding(.horizontal) // Ensure consistent horizontal padding for the input form
                    }
                }
                .frame(width: 400, height: 400)
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
