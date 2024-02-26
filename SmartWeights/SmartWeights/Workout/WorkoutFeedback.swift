//  Feedback.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/20/24.

import SwiftUI
///View to display data from each of the set in the workout
//to create each of the boxes for each set
struct PostWorkoutData: View {
    @StateObject var viewModel = WorkoutViewModel()
    @State private var isExpanded: Bool = false
    
    let setIndex:Int
    
    init(setIndex: Int) {
        self.setIndex = setIndex
    }
    
    var body: some View {
        
        
        HStack{
            Text(("Set \(setIndex)"))
            Text("Form 90%")
            Text("Velocity 80%")
            Spacer()
            if isExpanded{
                
                Image(systemName: "arrowshape.up.fill")
            
            }
            else{
                Image(systemName: "arrowshape.down.fill")
            }
            
        }
        .onTapGesture {
            withAnimation {
                self.isExpanded.toggle()
                
            }
        }
        
        if isExpanded {
            Text("Data data data")
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            WorkoutGraph()
            
        }
    }
}


///View to show all data collected from the most recent workout
struct WorkoutFeedback: View {
    @StateObject var viewModel = WorkoutViewModel()
    
    
    
    var body: some View {
        @State var sets = Int(viewModel.inputtedSets) ?? 5
        
        //displays all the set data
        //will add more implmenetation once we get acutal data
        ScrollView {
            VStack {
                
                Form {
                    ForEach(0..<sets, id: \.self) { index in
                        PostWorkoutData(setIndex: index + 1)
                    }
                }
                .frame(height: 400)
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust corner radius as needed
                        .stroke(Color.gray, lineWidth: 1) // Set border color and width
                )
                
                //need to somehow link this up to the overallprogress page
                VStack() {
                    
                        Text("Form and Speed")
                            .font(.title2)
                        WorkoutGraph()
                            .frame(height: 250)
                        Spacer()
                    }
                    .frame(height:  500)
                    
                    
                    Spacer()
                }
            }
        }
    }
    
    
    



#Preview {
    WorkoutFeedback()
}
