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
                HStack{
                    Image(systemName: "arrow.backward")
                        .padding(.trailing, 350)
                }
                    
                
                HStack(alignment: .firstTextBaseline){
                    
                    
                    Text("Workout Summary")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                        .fontDesign(.monospaced)
                        .multilineTextAlignment(.center)

                 
                }
                
        
                Calendar()
                
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(width:350,height: 200)
                        .cornerRadius(40)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading){
                        Text("Form")
                            .padding(.bottom, 20)
                        Text("Velocity")
                            .padding(.bottom,30)
                        Text("Achivements earned")
                            .padding(.bottom, 20)
                        Text("Currency Earned")
                        
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
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("Graph")
                    }
                }
                
            
                    
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        Text("Overall Form - 80%")
                        Text("Overall Velocity - 70%")
                    }
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
