//
//  Workout.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/19/24.
//

import SwiftUI
import Combine

struct Workout: View {
    @State private var selectedTab = 0
    @State private var inputtedSets = ""
    @State private var inputtedReps = ""
    @State private var inputtedWeights = ""
    @State private var sets: Int = 0 {
        didSet {
            sets = Int(inputtedSets) ?? 0
        }
    }
    
    
    
    
    
    
    
    var body: some View {
        VStack {
            HStack{
                Button(action: { // Back Arrow
                    print("Button tapped (temp)")
                }) {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .foregroundColor(.black)
                        .padding(.leading)
                }
                Spacer()
                
            }
            HStack { //Title
                Text("Workout")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                
            }
            //Selecting the workout tab or the feedback tab
            Picker(selection: $selectedTab, label: Text("Select a tab")) {
                Text("Sets").tag(0)
                Text("Feedback").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        
        //user inputting their desired weights, reps and sets
        Text("BenchPress: \(inputtedSets) x \(inputtedReps)")
        Text("Dumbell Weights: \(inputtedWeights) lbs")
        
        VStack{
            HStack{
                Spacer()
                Text("Set Amount")
                TextField("", text: $inputtedSets)
                    .keyboardType(.numberPad)
                    .onReceive(Just(inputtedSets)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.inputtedSets = filtered
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .frame(width:80)
                    .font(.system(size: 14))
                
            }
            HStack{
                Spacer()
                Text("Repition Amount")
                TextField("", text: $inputtedReps)
                    .keyboardType(.numberPad)
                    .onReceive(Just(inputtedReps)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.inputtedReps = filtered
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .frame(width:80)
                    .font(.system(size: 14))
                
            }
            HStack{
                Spacer()
                Text("Weights (lbs)")
                TextField("", text: $inputtedWeights)
                    .keyboardType(.numberPad)
                    .onReceive(Just(inputtedWeights)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.inputtedWeights = filtered
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .frame(width:80)
                    .font(.system(size: 14))
                
            }
        }
        .padding(.trailing, 50)
        
        HStack {
            
            ForEach(0..<(5)) { index in
                ZStack{
                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 50, height: 50)
                        .padding()
                    Text("\(inputtedReps)")
                }
                
                
            }
        }
        
        
        
        
        
        
        
        Spacer()
    }
}

#Preview {
    Workout()
}
