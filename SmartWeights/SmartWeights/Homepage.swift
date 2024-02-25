//
//  Homepage.swift
//  SmartWeights
//
//  Created by par chea on 2/21/24.
//
 
import SwiftUI

var currentWorkout = "Dumbbell Press"

struct Homepage: View {

    var body: some View {
        VStack {
            Spacer()
            // Welcome Message
            HStack {
                Text("Welcome")
                    .padding()
                Spacer()
            }
            
            Spacer()
            // Start Workout Button
            ZStack {
                HStack {
                    VStack {
                        HStack {
                            Text("Start Workout")
                            Image(systemName: "arrow.right")
                        }
                        Text(currentWorkout)
                    }
                    .padding()
                    Spacer()
                    Image(systemName: "photo")
                        .padding()
                }
            }
            
            Spacer()
            // Navigation Carousel
            VStack {
                Text("Button Carousel")
                ScrollView (.horizontal) {
                    HStack {
                        let count = 1...4
                        ForEach(count, id: \.self) { _ in
                            Image(systemName: "photo")
                                .background(Circle())
                                .padding()
                        }
                    }
                }
            }
            
            Spacer()
            // Video Carousel
            VStack {
                HStack {
                    Text("Videos")
                        .padding()
                    Spacer()
                    Image(systemName: "arrow.right")
                        .padding()
                }
                ScrollView (.horizontal) {
                    HStack {
                        let count = 1...4
                        ForEach(count, id: \.self) { number in
                            VStack {
                                Image(systemName: "photo")
                                Text("Video \(number)")
                                Text("Video Description")
                            }
                            .padding()
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}



