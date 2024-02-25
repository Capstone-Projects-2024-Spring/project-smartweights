//
//  Feedback.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/20/24.
//

import SwiftUI

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
                    
                }
                
            
    
    }
}



struct Feedback: View {
    @StateObject var viewModel = WorkoutViewModel()
    
    
    var body: some View {
        //displays all the set data
        //will add more implmenetation once we get acutal data
        @State var sets = Int(viewModel.inputtedSets) ?? 5
        
        List{
            ForEach(0..<sets, id: \.self) { index in
                PostWorkoutData(setIndex: index + 1)
            }
        }
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            
        })
        Spacer()
        
    }
    
    
}


#Preview {
    Feedback()
}
