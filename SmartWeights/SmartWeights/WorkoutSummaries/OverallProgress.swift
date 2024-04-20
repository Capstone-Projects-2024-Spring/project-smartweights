//
//  PostWorkout.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import SwiftUI
import CoreData





class allFeedbackViewModel: ObservableObject {
    var coreDataManager: CoreDataManager
    @Published var date = Date()
    //    @Published var shortDate: String = "" // Store short date string
    @Published var workoutSessions: [[String:Any]] = [[:]]
    @Published var WorkoutSets: [[String:Any]] = [[:]]
    var workoutNum: Int64 = 0
    
    //    func updateShortDate() {
    //        let formatter = DateFormatter()
    //        formatter.dateStyle = .short
    //        self.shortDate = formatter.string(from: date)
    //    }
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        workoutSessions = coreDataManager.fetchWorkoutSessions(on: Date())
        print(workoutSessions,"----------------------------------------INIT---------------")
        updateData(date:Date())
    }
    
    func updateData(date: Date){
        self.workoutSessions = coreDataManager.fetchWorkoutSessions(on: date)
    }
    
    func updateData(workoutNum: Int64){
        self.WorkoutSets = coreDataManager.fetchExerciseSets(for: workoutNum)
    }
}


//when user wants more info about that workout for that day ie. the sets
struct moreFeedbackSheetView: View {
    
    var body: some View {
        Image("dinosaur")
            .resizable()
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
        Text("data data data data data data data")
    }
}


struct SelectedDateData: View {
    @ObservedObject var viewModel: allFeedbackViewModel
    @State var isSheetPresented: Bool = false
    
    
    var body: some View{
        Text("hello")
    }
    
    
}

struct allFeedback: View {
    @ObservedObject var coreDataManager: CoreDataManager
    @ObservedObject var viewModel: allFeedbackViewModel
    
    init(coreDataManager: CoreDataManager){
        self.coreDataManager = coreDataManager
        self.viewModel = allFeedbackViewModel(coreDataManager:coreDataManager)
    }
    
    var body: some View {
        ScrollView {
            ZStack{
                VStack{
                    //Title of the page
                    HStack(alignment: .firstTextBaseline){
                        Text("All Feedback")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .multilineTextAlignment(.center)
                    }
                    
                    SelectedDateData(viewModel: viewModel)
                    DatePicker("Select a date", selection: $viewModel.date, displayedComponents: .date)
                        .padding()
                        .labelsHidden() // Hide the DatePicker label
                        .onChange(of: viewModel.date) { newValue in
                            viewModel.updateData(date: newValue)
                        }
                    
                    
                  
                        ForEach(0..<viewModel.workoutSessions.count, id: \.self) { index in
                            let workoutSession = viewModel.workoutSessions[index]
                            Text("Workout Session \(index+1):")
                                .padding(.top, 30)
                            Text("Overall Curl Acceleration - \(workoutSession["overallCurlAcceleration"] ?? 0)")
                            Text("Overall Wrist Stability (Left Right) - \(workoutSession["overallWristStabilityLeftRight"] ?? 0)")
                            Text("Overall Wrist Stability (Up Down) - \(workoutSession["overallWristStabilityUpDown"] ?? 0)")
                            Text("Overall Elbow Swing - \(workoutSession["overallElbowSwing"] ?? 0)")
                            Text("Overall Elbow Flare(Left Right) - \(workoutSession["overallElbowFlareLeftRight"] ?? 0)")
                            Text("Overall Elbow Flare (Up Down) - \(workoutSession["overallElbowFlareUpDown"] ?? 0)")
                            }
                    
                    
                    
                    
                    
                    //                    Text("\(viewModel.workoutSessions)")
                    //                        .onReceive(viewModel.$workoutSessions) { workoutSessions in
                    //                            print(workoutSessions, "...................................")
                    //                        }
                }
            }
        }
    }
}



#Preview {
    allFeedback(coreDataManager: CoreDataManager())
}

