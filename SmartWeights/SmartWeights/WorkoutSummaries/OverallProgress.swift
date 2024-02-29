//
//  PostWorkout.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import SwiftUI


struct DateDataPoints: Identifiable {
    
    
    var id = UUID().uuidString
    var date: String
    var form: Int
    var velocity: Int
    var achievement: Int
    var currency: Int
}

class OverallProgressViewModel: ObservableObject{
    
    @Published var date = Date()
    @Published var shortDate: String = "" // Store short date string
    
    func updateShortDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        self.shortDate = formatter.string(from: date)
    }
    
    init(){
        updateShortDate()
    }
    
    
    
}



struct moreFeedbackSheetView: View {
    
    var body: some View {
        Image("dinosaur")
            .resizable()
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
        Text("data data data data data data data")
        Text("data data data data data data data")
        Text("data data data data data data data")
        Text("data data data data data data data")
        Text("data data data data data data data")
        Text("data data data data data data data")
        
    }
}
    
struct SelectedDateData: View {
    @ObservedObject var viewModel: OverallProgressViewModel
    @State var isSheetPresented: Bool = false
    
    var data = [
        DateDataPoints(date: "2/26/24", form: 20, velocity: 50, achievement: 4, currency: 500),
        DateDataPoints(date: "2/27/24", form: 60, velocity: 10, achievement: 4, currency: 500),
        DateDataPoints(date: "2/28/24", form: 30, velocity: 70, achievement: 54, currency: 5020),
        DateDataPoints(date: "2/29/24", form: 30, velocity: 70, achievement: 54, currency: 5020),
        DateDataPoints(date: "3/1/24", form: 30, velocity: 720, achievement: 54, currency: 5020)
        
    ]
    
    var body: some View{
        
        
        Button(action: {
            isSheetPresented.toggle()
            
        })
        {
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(width:350,height: 200)
                    .cornerRadius(40)
                    .foregroundColor(.gray)
                
                
                VStack(alignment: .leading){
                    
                    ForEach(data){ d in
                        if d.date == viewModel.shortDate{
                            HStack {
                                Text("Form - \(d.form)%")
                                Image(systemName: "figure.strengthtraining.traditional")
                                    .foregroundColor(.green)
                                    
                            }
                            .padding(.bottom, 20)
                            HStack {
                                Text("Velocity - \(d.velocity)%")
                                Image(systemName: "speedometer")
                                    .foregroundColor(.white)
                                    
                            }
                            .padding(.bottom,20)
                            HStack {
                                Text("Achivements earned - \(d.achievement)")
                                    
                                Image(systemName: "medal")
                                    .foregroundColor(.yellow)
                                    
                            }
                            .padding(.bottom, 10)
                            HStack {
                                Text("Currency Earned - \(d.currency)")
                                Image("petcoin")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    
                            }
                            
                        }
                    }
                    
                }
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .bold()
                .frame(minHeight: 200)
                .padding(.leading, 20)
                .sheet(isPresented: $isSheetPresented) {
                    // Content of the sheet
                    moreFeedbackSheetView()
                    
                }
            }
            
        }
        
    }
    
    
}

struct PostWorkout: View {
    
    @ObservedObject var viewModel =  OverallProgressViewModel()
    @State var isFormGraph: Bool = true
    @State var isVelocityGraph: Bool = false
    
    
    var body: some View {
        
        
        ScrollView {
            ZStack{
                VStack{
                    //Title of the page
                    HStack(alignment: .firstTextBaseline){
                        
                        Text("Workout Progress")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .bold()
                            .fontDesign(.monospaced)
                            .multilineTextAlignment(.center)
                        
                        
                    }
                    
                    //calender component
                    //need to export date to get data the correct day
                    
                    CalendarView(viewModel: viewModel)
                    SelectedDateData(viewModel: viewModel)
                    
                    //display data for that day
                    
                    VStack{
                        Button(action: {
                            // Action to perform when the button is tapped
                        }) {
                            ZStack {
                                Menu("Graphs") {
                                    Button(action: {
                                        isFormGraph = true
                                        isVelocityGraph = false
                                        
                                    }, label: {
                                        Text("Form")
                                    })
                                    Button(action: {
                                        isFormGraph = false
                                        isVelocityGraph = true
                                        
                                    }, label: {
                                        Text("Velocity")
                                    })
                                }
                                .font(.title2)
                                .bold()
                                
                                Image(systemName: "cursorarrow.click")
                                    .padding(.leading, 100)
                            }
                        }
                        
                        VStack{
                            if isFormGraph{
                                
                                Text("Form Progress")
                                    .font(.title2)
                                    .bold()
                                WorkoutGraphForm()
                            }
                            else if isVelocityGraph{
                                
                                Text("Velocity Progress")
                                    .font(.title2)
                                    .bold()
                                WorkoutGraphVelocity()
                                
                            }
                        }
                        
                        
                    }
                    VStack {
                        HStack{
                            VStack(alignment: .leading){
                                Text("Overall Form - 80%")
                                Text("Overall Velocity - 70%")
                            }
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .padding(.leading,20)
                            Spacer()
                            Image("dinosaur")
                                .resizable()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                                .cornerRadius(50)
                                .padding(.trailing, 20)
                            
                        }
                        Spacer()
                    }
                    .frame(height: 150)
                    
                    
                    
                    
                    
                }
            }
        }
    }
}


#Preview {
    PostWorkout(viewModel: OverallProgressViewModel())
}
