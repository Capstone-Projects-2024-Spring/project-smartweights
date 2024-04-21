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
struct moreFeedbackView: View {
    
    
    var body: some View {
        Text("Hello")
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
    @State private var exerciseSetsText: String = ""
    
    init(coreDataManager: CoreDataManager){
        self.coreDataManager = coreDataManager
        self.viewModel = allFeedbackViewModel(coreDataManager:coreDataManager)
    }
    
    var body: some View {
       
            ZStack{
                VStack{
                    //Title of the page
                    HStack(alignment: .firstTextBaseline){
                        Text("All Feedback")
                            .font(.title)
                            .bold()
                            .fontDesign(.monospaced)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.africanViolet)
                    }
                    
                    DatePicker("Select a date", selection: $viewModel.date, displayedComponents: .date)
                        .padding()
                        .labelsHidden() // Hide the DatePicker label
                        .onChange(of: viewModel.date) { newValue in
                            viewModel.updateData(date: newValue)
                        }
                        .onAppear {
                            viewModel.updateData(date: viewModel.date)
                        }
                    ScrollView{
                        ForEach(0..<viewModel.workoutSessions.count, id: \.self) { index in
                            let workoutSession = viewModel.workoutSessions[index]
                            Text("Workout Session \(index+1):")
                                .font(.title2)
                                .bold()
                                .padding(.top, 30)
                                .foregroundColor(.africanViolet)
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Overall Curl Acceleration - \(workoutSession["overallCurlAcceleration"] ?? 0)%")
                                Text("Overall Wrist Stability (Left Right) - \(workoutSession["overallWristStabilityLeftRight"] ?? 0)%")
                                Text("Overall Wrist Stability (Up Down) - \(workoutSession["overallWristStabilityUpDown"] ?? 0)%")
                                Text("Overall Elbow Swing - \(workoutSession["overallElbowSwing"] ?? 0)%")
                                Text("Overall Elbow Flare(Left Right) - \(workoutSession["overallElbowFlareLeftRight"] ?? 0)%")
                                Text("Overall Elbow Flare (Up Down) - \(workoutSession["overallElbowFlareUpDown"] ?? 0)%")
                            }
                            .padding(.horizontal)
                            let exerciseSets = viewModel.coreDataManager.fetchExerciseSets(for:workoutSession["workoutNum"] as? Int64 ?? 0)
                            ForEach(0..<exerciseSets.count, id: \.self) { index in
                                let exerciseSet = exerciseSets[index]
                                Text(" Set \(index+1):")
                                    .font(.headline)
                                    .padding(.top, 20)
                                    .foregroundColor(.africanViolet)
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Curl Acceleration - \(exerciseSet["avgCurlAcceleration"] as? Int ?? 0)%")
                                    Text("Wrist Stability (Left Right) - \(exerciseSet["avgWristStabilityLeftRight"] as? Int ?? 0)%")
                                    Text("Wrist Stability (Up Down) - \(exerciseSet["avgWristStabilityUpDown"] as? Int ?? 0)%")
                                    Text("Elbow Swing - \(exerciseSet["avgElbowSwing"] as? Int ?? 0)")
                                    Text("Elbow Flare(Left Right) - \(exerciseSet["avgElbowFlareLeftRight"] as? Int ?? 0)%")
                                    Text("Elbow Flare (Up Down) - \(exerciseSet["avgElbowFlareUpDown"] as? Int ?? 0)%")
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    
                    
                    
                
            }
        }
    }
}



#Preview {
    allFeedback(coreDataManager: CoreDataManager())
}

