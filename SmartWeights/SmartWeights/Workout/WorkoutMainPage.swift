import SwiftUI
import Combine

/// Main structure to display the workout page with integrated UI components
struct WorkoutMainPage: View {
    @StateObject var ble:BLEcentral
    @StateObject var formCriteria:FormCriteria
    @StateObject var storeModel = storeViewModel()
    @StateObject var workoutPageViewModel = WorkoutPageViewModel()
    @StateObject var viewModel: WorkoutViewModel
    
    init() {
        let ble = BLEcentral()
        let formCriteria = FormCriteria()
        self._ble = StateObject(wrappedValue: ble)
        self._formCriteria = StateObject(wrappedValue: formCriteria)
        self._viewModel = StateObject(wrappedValue: WorkoutViewModel(ble: ble, formCriteria: formCriteria))
    }
    
    
    @State private var workoutSubscription: AnyCancellable?
    @State private var selectedTab = 0
    @State private var isExpanded = false
    @State private var graphData: [Double] = []
//    @State private var feedback: (String, String, String, String) = ("", "", "", "")
//    @State var feedbackDataForSets: [(String, String, String, String)] = []
//    @State var workoutAnalysis: [String:Double] = [:]
//    @State var workoutAnalysisForSets:[[String:Double]] = []
//    @State var totalSets:Int = 0
    //TODO: IMPLEMENT THE DANGEROUS ASPECT
    var dangerousCalled = false
    var dangerous: Bool {
        formCriteria.dangerousForm(dumbbellArray: ble.MPU6050_1Gyros, elbowArray: ble.MPU6050_2Gyros)
    }
    
    @State private var currentMotivationalPhrase = "Let's get started!"
    
    
    
    var body: some View {
        ZStack {
            
            VStack {
                ZStack{
                    VStack {
                        HStack{
                            Spacer()
                            Image(systemName: "dumbbell.fill")
                                .frame(width: 30, height: 25)
                                .foregroundColor(ble.MPU_1_Connected ? .green : .red)
                            Spacer()
                            Image(systemName: "figure.arms.open")
                                .frame(width: 20, height: 25)
                                .foregroundColor(ble.MPU_2_Connected ? .green : .red)
                            Spacer()
                            
                        }
                        Text("Connections")
                            .font(.system(size: 12))
                    }
                    .padding(.leading, 290)
                }
                .padding(.bottom, 5)
                
                
                
                // Tab selection for workout or feedback
                workoutTabSelection
                
                // Content based on selected tab
                if selectedTab == 0 {
                    StartWorkoutView
                } else if selectedTab == 1 {
                    WorkoutFeedback(viewModel: viewModel, feedbackDataForSets: $viewModel.feedbackDataForSets,workoutAnalysisForSets: $viewModel.workoutAnalysisForSets,totalSets: $viewModel.totalSets)
                }
            }
            
            .popover(isPresented: $viewModel.showGraphPopover) {
                VStack {
                    HStack {
                        Spacer() // Pushes the button to the right
                        Button(action: {
                            viewModel.showGraphPopover = false // Close the popover
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
                    
                    //---------------------FEEDBACK----------------//
                    VStack{
                        HStack {
                            ZStack {
                                Image("bubble2")
                                    .resizable()
                                    .frame(width: 250, height: 150)
                                VStack{
                                    Text("\(viewModel.feedback.2)")
                                        .foregroundColor(viewModel.feedback.2 == "Whoa slow down!!" ? Color.red : Color.green)
                                    Text("\(viewModel.feedback.3)")
                                        .foregroundColor(viewModel.feedback.3 == "Keep that elbow steady!" ? Color.red : Color.green)
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
                        Text("\(viewModel.feedback.0)") //gives overall acceleration
                            .font(.subheadline)
                        Text("\(viewModel.feedback.1)") //gives overall elbow stability
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
        .accessibilityLabel("WorkoutSelectTab")
        .padding(.horizontal)
    }
    
    // Compute the button text based on current and total sets
    private var buttonText: String {
        let totalSets = Int(viewModel.inputtedSets) ?? 0
        if viewModel.hasWorkoutStarted {
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
                return viewModel.isWorkoutPaused ? "Start Next Set" : "Finish Set"
            }
        } else {
            // Before the workout starts
            return "Start Workout"
        }
    }
    
    private var StartWorkoutView: some View {
        VStack {
            if !viewModel.hasWorkoutStarted {
            }
            
            ZStack{
                // Time rectangel box
                RoundedRectangle(cornerRadius:  25)
                    .frame(width: 250, height: 50)
                    .foregroundColor(Color.africanViolet)
                    .padding()
                HStack{
                    Text("Time: ")
                    Text("\(viewModel.hours):\(viewModel.minutes):\(viewModel.seconds)")
                }
                .font(.system(size: 25))
                .bold()
                .foregroundStyle(.white)
            }
            .padding(.bottom, -15)
            
            
            
            HStack {
                ZStack {
                    Image("bubble2")
                        .resizable()
                        .frame(width: 350, height: 135)
                    Text(viewModel.currentMotivationalPhrase)
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
                if viewModel.hasWorkoutStarted {
                    if buttonText == "Finish Workout" {
                        viewModel.finishworkout()
                    } else if buttonText == "Final Set" {
                        viewModel.finalset()
                        // Logic for transitioning from the final set to finishing the workout
//                        viewModel.currentSets += 1 // This will push the state to "Finish Workout"
//                        viewModel.showGraphPopover = false
//                        viewModel.resumeTimer()
//                        ble.MPU6050_1Gyros.removeAll()
//                        ble.MPU6050_2Gyros.removeAll()
//                        ble.collectDataToggle = true
//                        viewModel.currentMotivationalPhrase = "Last Set! Push through!"
                    } else if !viewModel.isWorkoutPaused {
                        ble.collectDataToggle = false
                        viewModel.pauseTimer()
                        viewModel.showGraphPopover = true
                        viewModel.isWorkoutPaused = true
                        viewModel.currentMotivationalPhrase = "Take a breather, then keep going!"
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
                        viewModel.showGraphPopover = false
                        viewModel.isWorkoutPaused = false
                        ble.MPU6050_1Gyros.removeAll() //clears the data for the current set
                        ble.MPU6050_2Gyros.removeAll()
                        ble.collectDataToggle = true //Stars collecting data again
                        viewModel.currentMotivationalPhrase = "You're doing great!"
                    }
                } else {
                    // Start the workout
                    viewModel.currentMotivationalPhrase = "First set, let's go!"
                    viewModel.resumeTimer()
                    viewModel.showingWorkoutSheet = true
                    viewModel.showGraphPopover = false
                    
                }
            }) {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 300, height: 80)
                    .foregroundColor(buttonText == "Finish Workout" ? .red : (viewModel.hasWorkoutStarted ? (viewModel.isWorkoutPaused ? .blue : .red) : .gray))
                    .overlay(
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                            .font(.title2)
                    )
            }
            .accessibilityLabel(viewModel.hasWorkoutStarted ? (viewModel.isWorkoutPaused ? "NextSetButton" : "FinishSetButton") : "StartWorkoutButton")
            .sheet(isPresented: $viewModel.showingWorkoutSheet) {
                WorkoutDetailsInputView(viewModel: viewModel, ble: ble,form: formCriteria, hasWorkoutStarted: $viewModel.hasWorkoutStarted, showingWorkoutSheet: $viewModel.showingWorkoutSheet,feedbackDataForSets: $viewModel.feedbackDataForSets, workoutAnalysisForSets: $viewModel.workoutAnalysisForSets)
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
                    if viewModel.countdownActive {
                        // Countdown UI
                        Text("Starting in \(viewModel.countdown)")
                            .font(.largeTitle)
                            .padding()
                            .onAppear {
                                viewModel.startCountdown()
                            }
                    } else {
                        // Regular input form
                        HStack {
                            Text("Enter Workout Details")
                                .font(.headline)
                            
                            Button(action: {
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
                            viewModel.validateAndStartCountdown(sets: viewModel.inputtedSets, reps: viewModel.inputtedReps, weights: viewModel.inputtedWeights)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.africanViolet)
                        .cornerRadius(10)
                        .alert(isPresented: $viewModel.showingAlert) {
                            Alert(title: Text("Invalid Input"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                }
                .frame(width: 400, height: 350)
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .shadow(radius: 10)
            }
        }
    }
}

#Preview {
    WorkoutMainPage()
}
