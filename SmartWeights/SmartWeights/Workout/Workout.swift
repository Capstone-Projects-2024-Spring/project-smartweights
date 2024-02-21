//
//  Workout.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/19/24.
//

import SwiftUI
import Combine



struct CircularProgressView: View {
    // 1
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.pink.opacity(0.5),
                    lineWidth: 10
                )
            Circle()
            // 2
                .trim(from: 0, to: progress)
                .stroke(
                    Color.pink,
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}


struct Workout: View {
    
    @State public var progress: Double = 0
    
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
            HStack { //Title
                Button(action: { // Back Arrow
                    
                }) {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .foregroundColor(.black)
                        .padding(.leading)
                }
                .padding(.trailing, 40)
                Spacer()
                
                Text("Workout")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                
                    .padding(.trailing, 60)
                Button(action :{
                    print("start workout")
//                    addProgress(data: 0.75)
                    progress = 0.75
                }){
                    Image(systemName: "mic.circle")
                        .resizable()
                        .frame(width: 30,height: 30)
                }
                .padding(.trailing, 42)
                
            }
            
            //Selecting the workout tab or the feedback tab
            Picker(selection: $selectedTab, label: Text("Select a tab")) {
                Text("Sets").tag(0)
                Text("Feedback").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        
        //user inputting their desired weights, reps and sets
        Text((inputtedReps.isEmpty || inputtedSets.isEmpty) ? "BenchPress:" : "BenchPress: \(inputtedSets) x \(inputtedReps)")
            .bold()
        
        Text(inputtedWeights.isEmpty ? "Dumbell Weights: 0 lbs":"Dumbell Weights: \(inputtedWeights) lbs")
            .bold()
        
        HStack{
            VStack{
                Text("Sets")
                    .bold()
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
            
            VStack{
                Text("Repitions")
                    .bold()
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
            VStack{
                Text("Pounds")
                    .bold()
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
        .padding(.top)
        .padding(.bottom,45)
        
        
        VStack{
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 150, height: 150)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("Time")
                        .font(.title3)
                        .bold()
                        .padding(.bottom,100)
                    
                }
                ZStack{
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 150, height: 150)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("Remaining Sets")
                        .font(.title3)
                        .bold()
                        .padding(.bottom, 100)
                    
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 150, height: 150)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("Form")
                        .font(.title3)
                        .bold()
                    CircularProgressView(progress: progress)
                        .frame(width: 100, height: 100)
                    
                }
                ZStack{
                    RoundedRectangle(cornerRadius:  25)
                        .frame(width: 150, height: 150)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("Velocity")
                        .font(.title3)
                        .bold()
                    CircularProgressView(progress: progress)
                        .frame(width: 100, height: 100)
                }
                
            }
        }
        ZStack{
            ZStack{
                Button(action: { // Back Arrow
                    print("Button tapped (temp)")
                    resetProgress()
                })
                {
                    ZStack{
                        RoundedRectangle(cornerRadius:  25)
                            .frame(width: 300, height: 80)
                            .foregroundColor(.green)
                        Text("Finish workout")
                            .bold()
                            .foregroundStyle(.black)
                    }
                }
                
            }
            
        }
        
    
        Spacer()
    }
    func resetProgress() {
        progress = 0
    }
    func addProgress(data: Double) {
        progress = data
    }
}

#Preview {
    Workout()
}
