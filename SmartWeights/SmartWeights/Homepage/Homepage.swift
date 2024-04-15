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
                
                // Define buttons for the additional pages carousel (NavigationCarousel)
                let postWorkout = CarouselButton(name: "Progress", icon: "chart.line.uptrend.xyaxis", link: AnyView(PostWorkout()))
                
                // Place defined buttons in array to be used by the NavigationCarousel view
                let buttons = [postWorkout]
                
                // Additional Pages Carousel
                NavigationCarousel(buttons: buttons, iconColor: Color.africanViolet, bgColor: .black, textColor: .black)
                
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
