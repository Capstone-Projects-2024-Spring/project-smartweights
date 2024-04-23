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
    @ObservedObject var coreDataManager: CoreDataManager
    
    let tabBar: TabBar
    // TODO: Currently hardcoded for demo. Change back afterwards.
    @State private var showTutorial = true
    
    init(tabBar: TabBar, coreDataManager: CoreDataManager) {
        self.tabBar = tabBar
        self.coreDataManager = coreDataManager

        // Check if user is new and show popup accordingly
        if UserDefaults.standard.bool(forKey: "isNewUser") {
            _showTutorial = State(initialValue: true)
            UserDefaults.standard.set(false, forKey: "isNewUser")
        }
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
                let postWorkout = CarouselButton(name: "Progress", icon: "chart.line.uptrend.xyaxis", link: AnyView(allFeedback(coreDataManager: coreDataManager)))
                let rechargeSensor = CarouselButton(name: "How to charge",icon:  "powerplug", link: AnyView(RechargeSensors()))
                let attachSensor = CarouselButton(name: "How to attach", icon: "sensor", link: AnyView(AttachSensors()))
                
                // Array of defined buttons to be used by the NavigationCarousel view
                let buttons = [postWorkout,rechargeSensor, attachSensor]
                
                // Additional Pages Carousel
                NavigationCarousel(coreDataManager: coreDataManager, buttons: buttons, iconColor: .white, bgColor: .africanViolet, textColor: .black)
                
                Divider()
                
                // Videos for video carousel
                let SWTutorial = VideoCard(videoId: "K9E32Z8ZQDU", title: "SmartWeights Tutorial", description: "SmartWeights")
                
                let DumbbellTutorial = VideoCard(videoId: "av7-8igSXTs", title: "How to Dumbell Curl", description: "Livestrong")
                
                // Array of defined videos. Used by VideoCarousel view.
                let videos = [SWTutorial, DumbbellTutorial]
                
                // Video Carousel
                VideoCarousel(videoCards: videos)
            }
            .background(.white)
            .fullScreenCover(isPresented: $showTutorial, content: {
                TutorialPopup(show: $showTutorial)
            })
            .statusBarHidden(false)
        }
    
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage(tabBar: TabBar(coreDataManager: CoreDataManager()), coreDataManager: CoreDataManager())
    }
}
