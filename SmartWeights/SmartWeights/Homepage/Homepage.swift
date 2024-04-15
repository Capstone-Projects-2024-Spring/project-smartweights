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
    
    let tabBar: TabBar
    
    init(tabBar: TabBar) {
        self.tabBar = tabBar
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Welcome Message
                HStack {
                    Text("Welcome")
                        .font(.title)
                        .padding(.top)
                        .padding(.horizontal)
                    Spacer()
                }
                
                // Start Workout Button
                StartWorkoutButton(tabBar: tabBar)
                
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
                                if number == 1 {
                                    NavigationLink(destination: PostWorkout()) {
                                        VStack {
                                            Image(systemName: "chart.line.uptrend.xyaxis")
                                                .foregroundStyle(Color.africanViolet
                                                )
                                                .background(Circle()
                                                    .frame(width: 60, height: 60)
                                                    .foregroundStyle(Color.darkGray)
                                                )
                                                .padding()
                                            Text("Progress")
                                                .foregroundStyle(Color.lightGray)
                                                .font(.subheadline)
                                        }
                                        .padding()
                                    }
                                } else {
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
                                if number == 1 {
                                    VideoCard(videoId: "ykJmrZ5v0Oo", title: "How to Do a Dumbbell Bicep Curl", description: "Howcast")
                                } else {
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
                }
                .foregroundStyle(.white)
                Spacer()
            }
        }
       
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage(tabBar: TabBar())
    }
}
