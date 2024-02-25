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
            // Welcome Message
            HStack {
                Text("Welcome Back")
            }
            
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
                    Image(systemName: "photo")
                }
            }
            
            // Navigation Carousel
            VStack {
                Text("Button Carousel")
                HStack {
                    let count = 1...4
                    ForEach(count, id: \.self) { _ in
                        Image(systemName: "photo")
                            .background(Circle())
                    }
                }
            }
            
            // Video Carousel
            VStack {
                HStack {
                    Text("Videos")
                    Image(systemName: "arrow.right")
                }
                HStack {
                    let count = 1...4
                    ForEach(count, id: \.self) { number in
                        VStack {
                            Image(systemName: "photo")
                            Text("Video \(number)")
                            Text("Video Description")
                        }
                    }
                }
            }
        }
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}



