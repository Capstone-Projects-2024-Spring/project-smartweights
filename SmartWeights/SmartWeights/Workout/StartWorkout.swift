import SwiftUI
import Combine

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
    @StateObject var viewModel = WorkoutViewModel()
    
    var body: some View {
        //user inputting their desired weights, reps and sets
        Text((viewModel.inputtedReps.isEmpty || viewModel.inputtedSets.isEmpty) ? "BenchPress:" : "BenchPress: \(viewModel.inputtedSets) x \(viewModel.inputtedReps)")
            .bold()
        
        Text(viewModel.inputtedWeights.isEmpty ? "Dumbell Weights: 0 lbs":"Dumbell Weights: \(viewModel.inputtedWeights) lbs")
            .bold()
        
        HStack{
            VStack{
                TextField("Sets", text: $viewModel.inputtedSets)
                    .keyboardType(.numberPad)
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
                    .keyboardType(.numberPad)
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
                    .keyboardType(.numberPad)
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
                Image("jetpack")
                    .resizable()
                .frame(width: 140, height: 140)
                
                Image("dog")
                    .resizable()
                .frame(width: 140, height: 140)
                
                Image("glasses")
                    .resizable()
                .frame(width: 140, height: 140)
                
                
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
                    Text("Velocity")
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
        
        
        Spacer()
        
    }
    
}


#Preview{
    StartWorkout()
}
