//  Feedback.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/20/24.

import SwiftUI
///View to display data from each of the set in the workout
//to create each of the boxes for each set


class FeedBackViewModel: ObservableObject{

    @Published var PetFeedbackText: String = "Tuck elbows in more when going up - roar"
    
}


struct VirtualPetFeedback: View{
    
    @State var viewModel = FeedBackViewModel()
    var body: some View{
        
        ZStack {
            Image("bubble")
                .resizable()
                .frame(width: 200,height: 100)
                .foregroundColor(.brown)
                .padding(.bottom,30)
            //need to somehow adjust font size or text box size based on text size
            Text("\(viewModel.PetFeedbackText)")
                .frame(width: 170)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .bold()
                .foregroundColor(.green)
                .padding(.bottom,30)
        }
        .frame(minHeight: 120)
    }
    
    
}

struct PostWorkoutData: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    @State private var isExpanded: Bool = false
    let setIndex: Int
    
    init(viewModel: WorkoutViewModel, setIndex: Int) {
        self.viewModel = viewModel // Initialize viewModel first
        self.setIndex = setIndex
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
            Text("Data data data")
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            WorkoutGraphForm()
        }
    }
}



///View to show all data collected from the most recent workout
struct WorkoutFeedback: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @State private var isGraphExpanded: Bool = false
    
    
    
    
    var body: some View {
        @State var sets = Int(viewModel.inputtedSets) ?? 5
        
        //displays all the set data
        //will add more implmenetation once we get acutal data
        ScrollView {
            VStack {
                
                SwiftUI.Form {
                    ForEach(0..<sets, id: \.self) { index in
                        PostWorkoutData(viewModel: viewModel,setIndex: index + 1)
                    }
                }
                .frame(height: 300)
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust corner radius as needed
                        .stroke(Color.gray, lineWidth: 1) // Set border color and width
                )
                .foregroundColor(.black)
                .background(Color.black)
                .scrollContentBackground(.hidden)
                
                VStack() {
                    HStack {
                        Spacer()
                        ZStack(alignment: .trailing) {
                            
                            Image("dinosaur")
                                .resizable()
                                .frame(width: 140, height: 140)
                            Image("chain")
                                .resizable()
                                .frame(width: 140, height: 140)
                            VirtualPetFeedback(viewModel: FeedBackViewModel())
                                .padding(.trailing,90)
                                .padding(.bottom,100)
                            
                        }
                        
                        
                    }
                    HStack {
                        Button(action: {
                            isGraphExpanded.toggle()
                        }, label: {
                            Text("Graphs")
                                .font(.title3)
                                .bold()
                        })
                        
                        if isGraphExpanded{
                            
                            Image(systemName: "arrowshape.up.fill")
                            
                        }
                        else{
                            Image(systemName: "arrowshape.down.fill")
                        }
                    }
                    .accessibilityLabel("OpenFeedbackGraphButton")
                    
                    
                    
                    if isGraphExpanded{
                        Text("Form")
                            .padding(.bottom,20)
                        WorkoutGraphForm()
                            .frame(height: 250)
                            .padding(.bottom,50)
                        Text("Velocity")
                            .padding(.bottom,20)
                        WorkoutGraphForm()
                            .frame(height: 250)
                        
                    }
                    
                    Spacer()
                }
                .frame(minHeight:  300)
                
                
                Spacer()
            }
        }
    }
}






#Preview {
    WorkoutFeedback(viewModel: WorkoutViewModel())
    //VirtualPetFeedback()
}
