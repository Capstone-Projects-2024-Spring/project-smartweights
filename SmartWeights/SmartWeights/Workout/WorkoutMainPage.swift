import SwiftUI
///structure to display the main workout page
struct WorkoutMainPage: View {
    ///created an instance of the view model
    @StateObject var viewModel = WorkoutViewModel ()
    
    //workout/feedback nav on top of app
    @State private var selectedTab = 0
    
    @State private var isExpanded = false
    
    var body: some View {
        ZStack{
            //temp for starting and ending workout until we implement Siri
            VStack{
                if(isExpanded && selectedTab == 0){
                    ZStack{
                        Rectangle()
                            .frame(width: 70, height: 50)
                            .foregroundColor(.white)
                        VStack{
                            Button(action:{
                                viewModel.startTimer()
                                
                                viewModel.progress = viewModel.generateRandomNumber()
                            }){
                                Text("Start")
                            }
                            Button(action:{
                                viewModel.stopTimer()
                            }){
                                Text("Finish")
                                
                            }
                            
                        }
                    }
                }
                else{
                    
                    Text("")
                    
                }
            }
            .padding(.bottom,500)
            .padding(.leading, 280)
            
            
            
            VStack {
                HStack { //Title
                    Button(action: {
                        
                        // Handle back button action
                    }) {
                        Image(systemName: "arrow.left")
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .padding(.leading)
                    }
                    .padding(.trailing, 40)
                    Spacer()
                    
                    Text("Workout")
                        .font(.title)
                        .bold()
                        .padding(.trailing, 60)
                    
                    
                    if selectedTab == 0 {
                        VStack{
                            Button(action: {
                                
                                // Start workout button action
                                isExpanded.toggle()
                            }) {
                                Image(systemName: "mic.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            .padding(.trailing, 42)
                        }
                    }
                    else {
                        Text("")
                            .padding(.trailing, 12)
                        Spacer()
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
                
                
                
                if(selectedTab == 0){
                    // Pass the view model instance to StartWorkout view
                    StartWorkout(viewModel: viewModel)
                    
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
