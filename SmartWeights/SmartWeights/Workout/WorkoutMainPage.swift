import SwiftUI
import Combine

/// Main structure to display the workout page with integrated UI components
struct WorkoutMainPage: View {
    @StateObject var viewModel = WorkoutViewModel()
    @ObservedObject var ble = BLEcentral()
    @ObservedObject var formCriteria = FormCriteria()
    @StateObject var storeModel = storeViewModel()
    @ObservedObject var workoutPageViewModel = WorkoutPageViewModel()
    
    @State private var currentWorkoutSession: WorkoutSession?
    @State private var workoutSubscription: AnyCancellable?
    @State private var selectedTab = 0
    @State private var isExpanded = false
    @State private var hasWorkoutStarted = false
    @State private var showingWorkoutSheet = false
    @State private var isWorkoutPaused = false
    
    @State var showGraphPopover: Bool = false {
        didSet {
            if showGraphPopover {
                self.feedback = formCriteria.giveFeedback(dumbbellArray: ble.MPU6050_1Gyros,elbowArray: ble.MPU6050_2Gyros)
                self.feedbackDataForSets.append(feedback)
                self.workoutAnalysis = formCriteria.UpdateWorkoutAnalysis(totalSets: totalSets, dumbbellArray: ble.MPU6050_1Gyros, elbowArray: ble.MPU6050_2Gyros)
                print(self.workoutAnalysis)
                self.workoutAnalysisForSets.append(self.workoutAnalysis)
            }
        }
    }
    @State private var graphData: [Double] = []
    @State private var feedback: (String, String, String, String) = ("", "", "", "")
    @State var feedbackDataForSets: [(String, String, String, String)] = []
    @State var workoutAnalysis: [String:Double] = [:]
    @State var workoutAnalysisForSets:[[String:Double]] = []
    @State var totalSets:Int = 0
    //TODO: IMPLEMENT THE DANGEROUS ASPECT
    var dangerousCalled = false
    var dangerous: Bool {
        formCriteria.dangerousForm(dumbbellArray: ble.MPU6050_1Gyros, elbowArray: ble.MPU6050_2Gyros)
    }
    
    @State private var currentMotivationalPhrase = "Let's get started!"
    let coreDataManager = CoreDataManager()

    var body: some View {
        ZStack {
            VStack {
                ZStack{
                    workoutTitleView
                    VStack{
                        Image(systemName: "dumbbell.fill")
                            .frame(width: 25, height: 25)
                            .foregroundColor(ble.MPU_1_Connected ? .green : .red)
                        
                        Text("Dumbbell")
                            .font(.custom("small", size: 12))
                        
                    }
                    .padding(.leading,200)
                    VStack{
                        Image(systemName: "figure.arms.open")
                            .frame(width: 25, height: 25)
                            .foregroundColor(ble.MPU_2_Connected ? .green : .red)
                        
                        Text("Elbow")
                            .font(.custom("small", size: 12))
                    }
                    .padding(.leading,300)
                    
                    
                }
                
                
                
                // Tab selection for workout or feedback
                workoutTabSelection
                
                // Content based on selected tab
                if selectedTab == 0 {
                    StartWorkoutView
                } else if selectedTab == 1 {
                    WorkoutFeedback(viewModel: viewModel, showGraphPopover: $showGraphPopover, feedbackDataForSets: $feedbackDataForSets,workoutAnalysisForSets: $workoutAnalysisForSets,totalSets: $totalSets)
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
                    
                    
                    //---------------------FEEDBACK----------------//
                    VStack{
                        HStack {
                            ZStack {
                                Image("bubble2")
                                    .resizable()
                                    .frame(width: 250, height: 150)
                                VStack{
                                    Text("\(feedback.2)")
                                        .foregroundColor(feedback.2 == "Whoa slow down!!" ? Color.red : Color.green)
                                    Text("\(feedback.3)")
                                        .foregroundColor(feedback.3 == "Keep that elbow steady!" ? Color.red : Color.green)
                                }
                                
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
                        Text("\(feedback.1)") //gives overall elbow stability
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
                    Image("bubble2")
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
                    // If the workout has started, get the next workout number and create a new workout session
                    let workoutNum = coreDataManager.getNextWorkoutNumber()
                    
                    if buttonText == "Finish Workout" {
                        if let workoutSession = currentWorkoutSession{
                            totalSets = Int(viewModel.inputtedSets) ?? 0

                            // Get feedback from formCriteria
                            let currentFeedback = formCriteria.giveFeedback(dumbbellArray: ble.MPU6050_1Gyros, elbowArray: ble.MPU6050_2Gyros)
                            
                            // Check if feedback indicates poor form
                            if currentFeedback.2 == "Whoa slow down!!" {
                                // Call function to reduce HP
                                workoutPageViewModel.lowerHP()
                            }
                            
                            print("hello test")
                            print(currentFeedback.2)
                            // Logic for completing the workout
                            generateRandomData(for: .overallWorkout) // Generate overall workout data
                            storeModel.addFundtoUser(price: 50)
                            workoutPageViewModel.AddXP(value: 25)
                            viewModel.resetWorkoutState()
                            hasWorkoutStarted = false
                            isWorkoutPaused = false
                            ble.collectDataToggle = false //stops collecting data
                            createWorkoutSession(dateTime: Date(), workoutNum: workoutNum, overallCurlAcceleration: <#T##Double#>, overallElbowFlareLR: <#T##Double#>, overallElbowFlareUD: <#T##Double#>, overallElbowSwing: <#T##Double#>, overallWristStabilityLR: <#T##Double#>, overallWristStabilityUD: <#T##Double#>)
                            print("hello")
                            //need to add this data to another array to store for workout history
                            //TODO: Need to move this
                            ble.MPU6050_1_All_Gyros.removeAll()//remove all data from current workout (after storing the data)
                            ble.MPU6050_2_All_Gyros.removeAll()
                            showGraphPopover = true
                            currentMotivationalPhrase = "Let's get started with a New Workout!"
                        }
                    } else if buttonText == "Final Set" {
                        // Logic for transitioning from the final set to finishing the workout
                        viewModel.currentSets += 1 // This will push the state to "Finish Workout"
                        showGraphPopover = false
                        viewModel.resumeTimer()
                        ble.MPU6050_1Gyros.removeAll()
                        ble.MPU6050_2Gyros.removeAll()
                        ble.collectDataToggle = true
                        currentMotivationalPhrase = "Last Set! Push through!"
                    } else if !isWorkoutPaused {
                        ble.collectDataToggle = false
                        viewModel.pauseTimer()
                        generateRandomData(for: .perSet) // Generate per-set data
                        showGraphPopover = true
                        isWorkoutPaused = true
                        currentMotivationalPhrase = "Take a breather, then keep going!"
                        if let totalSets = Int(viewModel.inputtedSets), viewModel.currentSets < totalSets {
                            viewModel.currentSets += 1
                        }
                        // Get feedback from formCriteria
                        let currentFeedback = formCriteria.giveFeedback(dumbbellArray:ble.MPU6050_1Gyros , elbowArray:ble.MPU6050_2Gyros)
                        
                        // Check if feedback indicates poor form
                        if currentFeedback.2 == "Whoa slow down!!" {
                            // Call function to reduce HP
                            workoutPageViewModel.lowerHP()
                        }
                        
                        print("hello test")
                        print(currentFeedback.2)
                    } else {
                        // Resume workout from a paused state
                        viewModel.resumeTimer()
                        showGraphPopover = false
                        isWorkoutPaused = false
                        ble.MPU6050_1Gyros.removeAll() //clears the data for the current set
                        ble.MPU6050_2Gyros.removeAll()
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
                WorkoutDetailsInputView(viewModel: viewModel, ble: ble,form: formCriteria, hasWorkoutStarted: $hasWorkoutStarted, showingWorkoutSheet: $showingWorkoutSheet,feedbackDataForSets: $feedbackDataForSets, workoutAnalysisForSets: $workoutAnalysisForSets)
            }
            
            
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
        @ObservedObject var form: FormCriteria
        @Binding var hasWorkoutStarted: Bool
        @Binding var showingWorkoutSheet: Bool
        @State private var showingAlert = false
        @State private var alertMessage = ""
        @State private var countdown = 5 // New state variable for countdown
        @State private var countdownTimer: AnyCancellable? // Timer for countdown
        @State private var countdownActive = false // Indicates if the countdown is active
        @Binding var feedbackDataForSets: [(String, String, String, String)]
        @Binding var workoutAnalysisForSets: [[String:Double]]
        
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
                                feedbackDataForSets.removeAll()
                                workoutAnalysisForSets.removeAll()
                                form.resetListofData()
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
                        ble.MPU6050_2Gyros.removeAll()
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
