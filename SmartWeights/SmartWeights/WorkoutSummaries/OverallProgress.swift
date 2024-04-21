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
    @Published var workoutSessions: [[String:Any]] = [[:]]
    @Published var WorkoutSets: [[String:Any]] = [[:]]
    var workoutNum: Int64 = 0
    
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        workoutSessions = coreDataManager.fetchWorkoutSessions(on: Date())
        updateData(date:Date())
    }
    
    func updateData(date: Date){
        self.workoutSessions = coreDataManager.fetchWorkoutSessions(on: date)
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
            //calendar
            DatePicker("Select a date", selection: $viewModel.date, displayedComponents: .date)
                .padding()
                .labelsHidden() // Hide the DatePicker label
                .onChange(of: viewModel.date) { newValue in
                    viewModel.updateData(date: newValue)
                }
                .onAppear {
                    viewModel.updateData(date: viewModel.date)
                }
            
            //data
            ScrollView{
                //get data for each workout
                ForEach(0..<viewModel.workoutSessions.count, id: \.self) { index in
                    VStack{
                        let workoutSession = viewModel.workoutSessions[index]
                        Text("Overall Workout Session \(index+1)")
                            .font(.title2)
                            .bold()
                            .padding(.top, 30)
                            .foregroundColor(.white)
                            .underline()
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Curl Acceleration - \(Int(workoutSession["overallCurlAcceleration"] as? Double ?? 0.0))%")
                            Text("Wrist Stability (Left Right) - \(Int(workoutSession["overallWristStabilityLeftRight"] as? Double ?? 0.0))%")
                            Text("Wrist Stability (Up Down) - \(Int(workoutSession["overallWristStabilityUpDown"] as? Double ?? 0.0))%")
                            Text("Elbow Swing - \(Int(workoutSession["overallElbowSwing"] as? Double ?? 0.0))%")
                            Text("Elbow Flare (Left Right) - \(Int(workoutSession["overallElbowFlareLeftRight"] as? Double ?? 0.0))%")
                            Text("Elbow Flare (Up Down) - \(Int(workoutSession["overallElbowFlareUpDown"] as? Double ?? 0.0))%")
                        }
                        .foregroundColor(.white)
                        //get data for each set in the workout
                        let exerciseSets = viewModel.coreDataManager.fetchExerciseSets(for:workoutSession["workoutNum"] as? Int64 ?? 0)
                        ForEach(0..<exerciseSets.count, id: \.self) { index in
                            let exerciseSet = exerciseSets[index]
                            DisclosureGroup(content: {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Curl Acceleration - \(Int(exerciseSet["avgCurlAcceleration"] as? Double ?? 0))%")
                                    Text("Wrist Stability (Left Right) - \(Int(exerciseSet["avgWristStabilityLeftRight"] as? Double ?? 0))%")
                                    Text("Wrist Stability (Up Down) - \(Int(exerciseSet["avgWristStabilityUpDown"] as? Double ?? 0))%")
                                    Text("Elbow Swing - \(Int(exerciseSet["avgElbowSwing"] as? Double ?? 0))%")
                                    Text("Elbow Flare (Left Right) - \(Int(exerciseSet["avgElbowFlareLeftRight"] as? Double ?? 0))%")
                                    Text("Elbow Flare (Up Down) - \(Int(exerciseSet["avgElbowFlareUpDown"] as? Double ?? 0))%")
                                }
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .font(.callout)
                                .padding(.bottom, 10)
                            }, label: {
                                HStack {
                                    Text(" Set \(index+1)")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .bold()
                                        .underline()
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            })
                        }
                        
                    }
                    .padding(.horizontal)
                    .frame(width: 350)
                    .background(Color.africanViolet)
                    .cornerRadius(20)
                }
            }
            
            
        }
    }
}



#Preview {
    allFeedback(coreDataManager: CoreDataManager())
}

