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
    static let hexF2F2F2 = Color(red: 150/255, green: 150/255, blue: 150/255)
}

/// The homepage view of the SmartWeights app.
struct Homepage: View {

    var body: some View {
        VStack {
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
            Button(action: {
                // Link to WorkoutGraph
            }) {
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
                                .foregroundStyle(Color.hexF2F2F2)
                                .font(.subheadline)
                        }
                        .padding()
                        Spacer()
                        Image(systemName: "photo")
                            .foregroundStyle(Color.hexF2F2F2)
                            .padding()
                    }
                    .foregroundStyle(.white)
                }
                .background(Color.hex2E2E2E)
                .cornerRadius(12)
                .padding()
            }
            
            
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
                                    .foregroundStyle(Color.hexF2F2F2)
                                    .background(Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(Color.hex2E2E2E)
                                    )
                                    .padding()
                                Text("Page \(number)")
                                    .foregroundStyle(Color.hexF2F2F2)
                                    .font(.subheadline)
                            }
                            .padding()
                        }
                    }
                }
            }
            .foregroundStyle(.white)
            
            // Video Carousel
            VStack {
                HStack {
                    Text("Videos")
                        .font(.title3)
                        .padding(.top)
                        .padding(.horizontal)
                    Spacer()
                    HStack {
                        Text("See more")
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color.africanViolet)
                    }
                    .padding()
                }
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        let count = 1...4
                        ForEach(count, id: \.self) { number in
                            VStack {
                                Spacer()
                                Image(systemName: "photo")
                                    .foregroundStyle(Color.hexF2F2F2)
                                Spacer()
                                VStack (alignment: .leading){
                                    Text("Video \(number)")
                                        .font(.title3)
                                    Text("Video Description")
                                        .foregroundStyle(Color.hexF2F2F2)
                                        .font(.subheadline)
                                }
                                .padding(.bottom)
                            }
                            .frame(width: 200, height: 250)
                            .background(Color.hex2E2E2E)
                            .cornerRadius(12)
                            .padding()
                        }
                    }
                }
            }
            .foregroundStyle(.white)
            
            Spacer()
        }
        .background(Color.hex121212)
        //.padding(.bottom, 80) // Padding for Navbar
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
