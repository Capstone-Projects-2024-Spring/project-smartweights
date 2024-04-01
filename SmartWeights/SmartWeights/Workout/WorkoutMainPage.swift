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
            //temp for starting and ending workout until we implement Siri
            //            VStack{
            //                if(isExpanded && selectedTab == 0){
            //                    ZStack{
            //                        Rectangle()
            //                            .frame(width: 70, height: 50)
            //                            .foregroundColor(.white)
            //                        VStack{
            //                            Button(action:{
            //
            //                                bleManager.scanningToggle = true
            //                                viewModel.startTimer()
            //
            //                                viewModel.progress = viewModel.generateRandomNumber()
            //                            }){
            //                                Text("Start")
            //                            }
            //                            .accessibilityLabel("startWorkoutButton")
            //                            Button(action:{
            //                                viewModel.stopTimer()
            //                                bleManager.scanningToggle = false
            //                            }){
            //                                Text("Finish")
            //
            //                            }
            //                            .accessibilityLabel("endWorkoutButton")
            
            //                        }
            //                    }
            //                }
            //                else{
            //
            //                    Text("")
            //
            //                }
            //            }
            //            .padding(.bottom,500)
            //            .padding(.leading, 280)
            //
            //
            
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

#Preview {
    WorkoutMainPage()
}
