//  Feedback.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/20/24.

import SwiftUI
//to create each of the boxes for each set
/// PostWorkoutData is a view that displays the feedback for each set in the workout
/// -Note: This view displays both the data for the set and the overall data for the workout

struct PostWorkoutData: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    @State private var isExpanded: Bool = false
    let setIndex: Int
    let feedback: (String, String, String, String)
    let workoutAnalysis: [String:Double]
    
    /// Initializes the PostWorkoutData view
    /// - Parameters:
    ///   - viewModel: 
    ///   - setIndex: 
    ///   - feedback: 
    ///   - workoutAnalysis: 
    init(viewModel: WorkoutViewModel, setIndex: Int, feedback: (String, String, String, String),workoutAnalysis: [String:Double]) {
        self.viewModel = viewModel
        self.setIndex = setIndex
        self.feedback = feedback // Initialize feedback
        self.workoutAnalysis = workoutAnalysis //initialize all workout data
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Set \(setIndex)")
                Spacer()
                if isExpanded{
                    Image(systemName: "arrowshape.up.fill")
                } else {
                    Image(systemName: "arrowshape.down.fill")
                }
            }
            .onTapGesture {
                withAnimation {
                    self.isExpanded.toggle()
                }
            }
            HStack{
                
                
                Text("\(feedback.0)") //gives overall acceleration
                    .font(.subheadline)
                    .bold()
                if workoutAnalysis["averageUpDownAcceleration"]! < 70.0{
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .bold()
                }
                else{
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .bold()
                }
            }
            HStack{
                Text("\(feedback.1)") //gives overall elbow stability
                    .font(.subheadline)
                    .bold()
                if workoutAnalysis["averageElbowSwing"]! < 70.0{
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .bold()
                }
                else{
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .bold()
                }
            }
        }
        
        if isExpanded {
            VStack(alignment: .leading){
                HStack{
                    Text("\(Int(workoutAnalysis["averageWristLeftRightRotation"] ?? 0.0))% wrist stability (left right)")
                    if workoutAnalysis["averageWristLeftRightRotation"]! < 70.0{
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .bold()
                    }
                    else{
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .bold()
                    }
                }
                HStack{
                    Text("\(Int(workoutAnalysis["averageWristUpDownRotation"] ?? 0.0))% wrist wrist stability (up down)")
                    if workoutAnalysis["averageWristUpDownRotation"]! < 70.0{
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .bold()
                    }
                    else{
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .bold()
                    }
                }
                
                HStack{
                    Text("\(Int(workoutAnalysis["averageElbowFlareUpDown"] ?? 0.0))% elbow stability(up down)")
                    if workoutAnalysis["averageElbowFlareUpDown"]! < 70.0{
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .bold()
                    }
                    else{
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .bold()
                    }
                }
                HStack{
                    Text("\(Int(workoutAnalysis["averageElbowFlareForwardBackward"] ?? 0.0))% elbow (forward backward)")
                    if workoutAnalysis["averageElbowFlareForwardBackward"]! < 70.0{
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .bold()
                    }
                    else{
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .bold()
                    }
                }
            }
        }
    }
}

/// OverallWorkoutData is a view that displays the overall feedback for the workout
/// -Note: This view displays the overall data for the workout
struct OverallWorkoutData: View{
    @Binding var workoutAnalysisForSets: [[String: Double]]
    @ObservedObject var viewModel: WorkoutViewModel
    var totalSets: Int
    
    
    var body: some View{
        Text("Overall Workout Feedback")
            .font(.headline)
        if workoutAnalysisForSets.count == totalSets{
            if let last = workoutAnalysisForSets.last {
                VStack(alignment: .leading){
                    HStack{
                        Text("\(Int(last["overallWorkoutUpDownAverage"] ?? 0.0 * 100))% good curl acceleration (left right)")
                        if last["overallWorkoutUpDownAverage"]! < 70.0{
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .bold()
                        }
                        else{
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .bold()
                        }
                    }
                    HStack{
                        Text("\(Int(last["overallDumbbellTwistingLeftRight"] ?? 0.0 * 100))% wrist stability (left right)")
                        if last["overallDumbbellTwistingLeftRight"]! < 70.0{
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .bold()
                        }
                        else{
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .bold()
                        }
                    }
                    HStack{
                        Text("\(Int(last["overallDumbbellTwistingUpDown"] ?? 0.0 * 100))% wrist stability (up down)")
                        if last["overallDumbbellTwistingUpDown"]! < 70.0{
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .bold()
                        }
                        else{
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .bold()
                        }
                    }
                    HStack{
                        
                        Text("\(Int(last["overallWorkoutElbowSwing"] ?? 0.0 * 100))% elbow stability (swinging)")
                        if last["overallWorkoutElbowSwing"]! < 70.0{
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .bold()
                        }
                        else{
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .bold()
                        }
                    }
                    HStack{
                        Text("\(Int(last["overallWorkoutElbowFlareUpDown"] ?? 0.0 * 100))% elbow stability (up down)")
                        if last["overallWorkoutElbowFlareUpDown"]! < 70.0{
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .bold()
                        }
                        else{
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .bold()
                        }
                    }
                    HStack{
                        Text("\(Int(last["overallWorkoutElbowFlareForwardBackward"] ?? 0.0 * 100))% elbow stability (forward backward)")
                        if last["overallWorkoutElbowFlareForwardBackward"]! < 70.0{
                            Image(systemName: "xmark")
                                .foregroundColor(.red)
                                .bold()
                        }
                        else{
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .bold()
                            
                        }
                    }
                }
            }
            
            
        }
        else{
            Text("Finish workout to see overall feedback")
        }
    }
}



///View to show all data collected from the most recent workout
/// -Note: This view displays the feedback for each set in the workout and the overall data for the workout
struct WorkoutFeedback: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @State private var sets: Int = 0
    @Binding var feedbackDataForSets: [(String, String, String, String)]
    @Binding var workoutAnalysisForSets: [[String: Double]]
    @Binding var totalSets:Int
    var body: some View {
        ScrollView {
            VStack {
                SwiftUI.Form {
                    ForEach(feedbackDataForSets.indices, id: \.self) { index in
                        PostWorkoutData(viewModel: viewModel, setIndex: index + 1, feedback: feedbackDataForSets[index],workoutAnalysis: workoutAnalysisForSets[index])
                    }
                }
                .frame(height: 500)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.gray, lineWidth: 0)
                )
                .foregroundColor(.black)
                .background(Color.gray.opacity(0.1))
                .scrollContentBackground(.hidden)
                OverallWorkoutData(workoutAnalysisForSets: $workoutAnalysisForSets, viewModel: viewModel, totalSets: totalSets)
                
                
                Spacer()
            }
        }
    }
}
