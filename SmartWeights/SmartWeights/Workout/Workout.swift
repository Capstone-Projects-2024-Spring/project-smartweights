import SwiftUI

struct Workout: View {
    
    // Create an instance of the view model
    @StateObject var viewModel = WorkoutViewModel()
    
    //workout/feedback nav on top of app
    @State private var selectedTab = 0
    
    var body: some View {
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
                    Button(action: {
                        // Start workout button action
                        viewModel.progress = 0.75
                        viewModel.startTimer()
                    }) {
                        Image(systemName: "mic.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .padding(.trailing, 42)
                } else {
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
            
            if(selectedTab == 0){
                // Pass the view model instance to StartWorkout view
                StartWorkout(viewModel: viewModel)
                
                Spacer()
            }
            else if (selectedTab == 1){
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    Workout()
}
