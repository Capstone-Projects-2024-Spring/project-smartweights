//
//  Homepage.swift
//  SmartWeights
//
//  Created by par chea on 2/21/24.
//

import SwiftUI

var currentWorkout = "Dumbbell Press"

/// The homepage view of the SmartWeights app.
struct Homepage: View {
    // Add a state to control navigation
    @State private var navigateToWorkoutDetail = false
    
    var body: some View {
        NavigationStack {
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
                    navigateToWorkoutDetail = true
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
                                    .foregroundStyle(Color.lightGray)
                                    .font(.subheadline)
                            }
                            .padding()
                            Spacer()
                            Image(systemName: "photo")
                                .foregroundStyle(Color.lightGray)
                                .padding()
                        }
                        .foregroundStyle(.white)
                    }
                    .background(Color.darkGray)
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
                                        .foregroundStyle(Color.lightGray)
                                        .background(Circle()
                                            .frame(width: 60, height: 60)
                                            .foregroundStyle(Color.darkGray)
                                        )
                                        .padding()
                                    Text("Page \(number)")
                                        .foregroundStyle(Color.lightGray)
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
                                        .foregroundStyle(Color.lightGray)
                                    Spacer()
                                    VStack (alignment: .leading){
                                        Text("Video \(number)")
                                            .font(.title3)
                                        Text("Video Description")
                                            .foregroundStyle(Color.lightGray)
                                            .font(.subheadline)
                                    }
                                    .padding(.bottom)
                                }
                                .frame(width: 200, height: 250)
                                .background(Color.darkGray)
                                .cornerRadius(12)
                                .padding()
                            }
                            
                        }
                    }
                }
                // navigate to the new view when the state is true
                .background(NavigationLink(destination: WorkoutMainPage(), isActive: $navigateToWorkoutDetail) { EmptyView() })
                
                .foregroundStyle(.white)
                Spacer()
            }
            .background(Color.midnightBlack.edgesIgnoringSafeArea(.all))
            
        }
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
