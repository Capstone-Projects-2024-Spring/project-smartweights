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
                Text("Sets")
                    .bold()
                TextField("", text: $viewModel.inputtedSets)
                    .keyboardType(.numberPad)
                    .onReceive(Just(viewModel.inputtedSets)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            viewModel.inputtedSets = filtered
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .frame(width:80)
                    .font(.system(size: 14))
                
            }
            
            VStack{
                Text("Repitions")
                    .bold()
                TextField("", text: $viewModel.inputtedReps)
                    .keyboardType(.numberPad)
                    .onReceive(Just(viewModel.inputtedReps)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            viewModel.inputtedReps = filtered
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .frame(width:80)
                    .font(.system(size: 14))
                
            }
            VStack{
                Text("Pounds")
                    .bold()
                TextField("", text: $viewModel.inputtedWeights)
                    .keyboardType(.numberPad)
                    .onReceive(Just(viewModel.inputtedWeights)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            viewModel.inputtedWeights = filtered
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .frame(width:80)
                    .font(.system(size: 14))
                
            }
        }
        .padding(.top)
        .padding(.bottom,45)
        
        //to create the four boxes
        VStack{
            HStack{
                ZStack{
                    ZStack{
                        RoundedRectangle(cornerRadius:  25)
                            .frame(width: 150, height: 150)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("Time")
                            .font(.title3)
                            .bold()
                            .padding(.bottom,100)
                        
                    }
                    Text("\(viewModel.hours):\(viewModel.minutes):\(viewModel.seconds)")
                        .bold()
                        .monospaced()
                        .foregroundStyle(.green)
                    
                    
                }
                ZStack{
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 150, height: 150)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("Remaining Sets")
                        .font(.title3)
                        .bold()
                        .padding(.bottom, 100)
                    Text("\(viewModel.inputtedSets)")
                        .bold()
                    
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 150, height: 150)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("Form")
                        .font(.title3)
                        .bold()
                    CircularProgressView(progress: viewModel.progress)
                        .frame(width: 100, height: 100)
                    
                }
                ZStack{
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 150, height: 150)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("Velocity")
                        .font(.title3)
                        .bold()
                    CircularProgressView(progress: viewModel.progress)
                        .frame(width: 100, height: 100)
                }
                
            }
        }
        
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
                            .foregroundColor(.green)
                        Text("New workout")
                            .bold()
                            .foregroundStyle(.black)
                    }
                }
                
            }
            
        }
        
        
        Spacer()
        
    }
    
}


#Preview{
    StartWorkout()
}
