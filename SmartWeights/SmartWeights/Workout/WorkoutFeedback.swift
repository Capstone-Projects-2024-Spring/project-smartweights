//  Feedback.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/20/24.

import SwiftUI
///View to display data from each of the set in the workout
//to create each of the boxes for each set


struct PostWorkoutData: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    @State private var isExpanded: Bool = false
    let setIndex: Int
    let feedback: (String, String, String, String)
    let workoutAnalysis: [String:Double]
    
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
            Text("\(feedback.0)") //gives overall acceleration
                .font(.subheadline)
            Text("\(feedback.1)") //gives overall elbow stability
                .font(.subheadline)
        }
        
        if isExpanded {
            VStack(alignment: .leading){
                Text("\(Int(workoutAnalysis["averageWristLeftRightRotation"] ?? 0.0 * 100))% wrist stability (left right)")
                Text("\(Int(workoutAnalysis["averageWristUpDownRotation"] ?? 0.0 * 100))% wrist wrist stability (up down)")
                Text("\(Int(workoutAnalysis["averageElbowFlareUpDown"] ?? 0.0 * 100))% elbow stability(up down)")
                Text("\(Int(workoutAnalysis["averageElbowFlareForwardBackward"] ?? 0.0 * 100))% elbow (foward backward)")
            }
        }
    }
}



///View to show all data collected from the most recent workout
struct WorkoutFeedback: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @State private var sets: Int = 0
    @Binding var showGraphPopover: Bool
    @Binding var feedbackDataForSets: [(String, String, String, String)]
    @Binding var workoutAnalysisForSets: [[String: Double]]

    var body: some View {
        ScrollView {
            VStack {
                SwiftUI.Form {
                    ForEach(feedbackDataForSets.indices, id: \.self) { index in
                        PostWorkoutData(viewModel: viewModel, setIndex: index + 1, feedback: feedbackDataForSets[index],workoutAnalysis: workoutAnalysisForSets[index])
                           }
                }
                .frame(height: 600)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .foregroundColor(.black)
                .background(Color.blue)
                .scrollContentBackground(.hidden)

                Spacer()
            }
        }
    }
}
