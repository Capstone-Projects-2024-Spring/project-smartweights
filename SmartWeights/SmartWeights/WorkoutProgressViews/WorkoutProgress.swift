//
//  PostWorkout.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import SwiftUI

struct PostWorkout: View {
    

    
    var body: some View {
        ZStack{
            VStack{
                //back arrow for future implementation
                HStack{
                    Image(systemName: "arrow.backward")
                        .padding(.trailing, 350)
                }
                    
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
                
                Calendar()
                
                //display data for that day
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(width:350,height: 200)
                        .cornerRadius(40)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading){
                        Text("Form - 50%")
                            .padding(.bottom, 20)
                        Text("Velocity - 90%")
                            .padding(.bottom,30)
                        Text("Achivements earned - 2")
                            .padding(.bottom, 20)
                        Text("Currency Earned - 50 coins")
                    
                        
                    }
                    .padding(.leading, 20)
                    .padding(.bottom,0)
                }
                VStack{
                    Text("Overall Progress")
                        .font(.title2)
                        .bold()
                        
                    ZStack{
                        Rectangle()
                            .frame(width: 350, height: 300)
                            .foregroundColor(.white)
                        
                        WorkoutGraph()
                    }
                }
                    
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        Text("Overall Form - 80%")
                        Text("Overall Velocity - 70%")
                    }
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding(.leading,20)
                    Spacer()
                    Image("VirtualPet")
                        .resizable()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                        .cornerRadius(50)
                        .padding(.trailing, 20)
                }
                
                
                
            }
        }
    }
}

#Preview {
    PostWorkout()
}
