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
    
    init(viewModel: WorkoutViewModel, setIndex: Int, feedback: (String, String, String, String)) {
            self.viewModel = viewModel
            self.setIndex = setIndex
            self.feedback = feedback // Initialize feedback
        }
    
    var body: some View {
        HStack{
            Text(("Set \(setIndex)  Form 80%  Velocity 60%"))
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
        
        if isExpanded {
            VStack{
                // ... your code ...
                Text("\(feedback.0)") //gives overall acceleration
                    .font(.subheadline)
                Text("\(feedback.1)") //gives overall elbow stability
                    .font(.subheadline)
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

    var body: some View {
        ScrollView {
            VStack {
                SwiftUI.Form {
                    ForEach(feedbackDataForSets.indices, id: \.self) { index in
                               PostWorkoutData(viewModel: viewModel, setIndex: index + 1, feedback: feedbackDataForSets[index])
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





//#Preview {
//    //    WorkoutFeedback(viewModel: WorkoutViewModel(), feedback: ("","","",""), showGraphPopover: $showGraphPopover)
//    //}
//}
