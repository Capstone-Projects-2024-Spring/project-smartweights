//
//  PostWorkout.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import SwiftUI
import CoreData





class allFeedbackViewModel: ObservableObject{
    
    @Published var date = Date()
    @Published var shortDate: String = "" // Store short date string
    @Published var workoutSessions: [WorkoutSession] = []
    
    func updateShortDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        self.shortDate = formatter.string(from: date)
        /*
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "MM-dd-yyyy"
         let dateString = dateFormatter.string(from: dateTime)
         */
    }
    
    init(){
        updateShortDate()
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
    
    @ObservedObject var viewModel =  allFeedbackViewModel()
    
    var body: some View {
        
        
        ScrollView {
            ZStack{
                VStack{
                    //Title of the page
                    HStack(alignment: .firstTextBaseline){
                        
                        Text("All Feedback")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .bold()
                            .fontDesign(.monospaced)
                            .multilineTextAlignment(.center)
                        
                        
                    }
                    
                    
                    CalendarView(viewModel: viewModel)
                    SelectedDateData(viewModel: viewModel)
                    
                    Button(action: {
                        print(coreDataManager.fetchWorkoutSessions(on: Date()))
                    }, label: {
                        Text("print")
                    })
                    Button(action: {
                        print(coreDataManager.fetchWorkoutSessions())
                    }, label: {
                        Text("print")
                    })

                    
                }
            }
        }

        
        }
    
}


#Preview {
    allFeedback(coreDataManager: CoreDataManager(), viewModel: allFeedbackViewModel())
}

