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
                        .foregroundStyle(.black)
                        .bold()
                    Spacer()
                }
                
                // Start Workout Button
                StartWorkoutButton(tabBar: tabBar)
                
                Divider()
                // Buttons for the additional pages carousel (NavigationCarousel)
                let postWorkout = CarouselButton(name: "Progress", icon: "chart.line.uptrend.xyaxis", link: AnyView(PostWorkout()))
                let rechargeSensor = CarouselButton(name: "How to charge",icon:  "powerplug", link: AnyView(RechargeSensors()))
                
                // Array of defined buttons to be used by the NavigationCarousel view
                let buttons = [postWorkout,rechargeSensor]
                
                // Additional Pages Carousel
                NavigationCarousel(buttons: buttons, iconColor: .white, bgColor: .africanViolet, textColor: .black)
                
                Divider()
                
                // Videos for video carousel
                let bicepCurlVideo = VideoCard(videoId: "ykJmrZ5v0Oo", title: "How to Do a Dumbbell Bicep Curl", description: "Howcast")
                
                // Array of defined videos. Used by VideoCarousel view.
                let videos = [bicepCurlVideo]
                
                // Video Carousel
                VideoCarousel(videoCards: videos)
            }
            .background(.white)
        }
       
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage(tabBar: TabBar())
    }
}
