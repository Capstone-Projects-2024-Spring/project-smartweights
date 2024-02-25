//
//  Homepage.swift
//  SmartWeights
//
//  Created by par chea on 2/21/24.
//
 
import SwiftUI

var currentWorkout = "Dumbbell Press"

extension Color {
    static let hex2E2E2E = Color(red: 46/255, green: 46/255, blue: 46/255)
}

struct Homepage: View {

    var body: some View {
        VStack {
            Spacer()
            // Welcome Message
            HStack {
                Text("Welcome")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.top)
                    .padding(.horizontal)
                Spacer()
            }
            
            // Start Workout Button
            ZStack {
                HStack {
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Start Workout")
                                .font(.title2)
                            Image(systemName: "arrow.right")
                                .foregroundStyle(Color.africanViolet)
                        }
                        Text(currentWorkout)
                            .font(.subheadline)
                    }
                    .padding()
                    Spacer()
                    Image(systemName: "photo")
                        .padding()
                }
                .foregroundStyle(.white)
            }
            .background(Color.hex2E2E2E)
            .cornerRadius(12)
            .padding()
            
            
            // Navigation Carousel
            VStack (alignment: .leading) {
                Text("App Features")
                    .font(.title3)
                    .padding(.top)
                    .padding(.horizontal)
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        let count = 1...6
                        ForEach(count, id: \.self) { number in
                            VStack {
                                Image(systemName: "photo")
                                    .background(Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(Color.hex2E2E2E)
                                    )
                                    .padding()
                                Text("Page \(number)")
                                    .font(.subheadline)
                            }
                            .padding()
                        }
                    }
                }
            }
            .foregroundStyle(.white)
            
            // Video Carousel
            Spacer()
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
        .background(Color.hex121212)
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}



