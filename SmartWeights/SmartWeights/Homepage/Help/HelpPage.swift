//
//  HelpPage.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/24/24.
//

import SwiftUI

struct HelpPage: View {
    var body: some View {
        
        NavigationStack {
            List {
                
                // Login
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Login")
                            .font(.title)
                            .padding(.bottom)
                        Text("When you first open the application, you will be greeted with our sign in page. Once you sign in using your apple account, you will automatically be signed in the app in the future.")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Login")
                }
                
                // Home page
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Home page")
                            .font(.title)
                            .padding(.bottom)
                        Text("After login, you will be greeted with the home page. The home page contains a direct path to start a workout and other shortcuts for your convenience. This page also contains educational videos to improve your SmartWeights experience. This tutorial can be viewed anytime from this page.")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Home page")
                }
                
                // Pet page
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Pet page")
                            .font(.title)
                            .padding(.bottom)
                        Text("The page pet is home to your virtual pet and allows you to feed, level up, and customize your pet. Your current equipped food is displayed, and you can change this by clicking the change food button. Your current pet’s outfit is shown as well as their health and level. Make sure you feed your pet! Clicking on the hamburger icon will allow you to open the pet shop or customize your pet.")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Pet page")
                }
                
                // Pet store
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Pet store")
                            .font(.title)
                            .padding(.bottom)
                        Text("The pet store is home to items you can buy for your virtual pet. These items can be purchased using your pet coins gained through workouts and achievements. You can buy new pets, but they will be the same level and health as your other pets.")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Pet store")
                }
                
                // Customize pet
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Customize pet")
                            .font(.title)
                            .padding(.bottom)
                        Text("You can then use the customization page to equip any purchased items on your pet.")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Customize pet")
                }
                
                // Workout page
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Workout page")
                            .font(.title)
                            .padding(.bottom)
                        Text("The workout page allows you to start a workout and receive feedback from your virtual pet between sets and after the workout. Clicking on the start workout button will allow you to enter the amount of sets, reps, and the weight of the dumbbell for your workout. Clicking the voice command icon will allow you to start and finish the workout hands-free. Voice commands including start workout, finish set, next set, and finish workout can be used to work through your workout. The ‘start workout’ command will start your workout, finish set will finish your current set, next set will start your next set, and then finish workout will allow you to conclude your final set. More on voice commands can be found on the workout page.")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Workout page")
                }
                
                // Achievements
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Achievements")
                            .font(.title)
                            .padding(.bottom)
                        Text("The achievements page allows you to track your progress on goals created by the SmartWeights team. Completed achievements will reward you with pet XP and pet coins and can be displayed on your profile.")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Achievements")
                }
                
                // Profile page
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Profile page")
                            .font(.title)
                            .padding(.bottom)
                        Text("The profile tab allows you to see your virtual pet, displayed achievements, pet level, and amount of pet coins. Clicking on the camera icon allows you to share your profile page. Clicking on the settings icon will allow you to customize your profile further.")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Profile page")
                }
                
                // Settings
                NavigationLink {
                    VStack (alignment: .leading){
                        Text("Settings")
                            .font(.title)
                            .padding(.bottom)
                        Text("The settings page allows you to edit your name, fitness plan, and other information. The fitness plan can track your progress")
                        Spacer()
                    }
                    .padding(.horizontal)
                } label: {
                    Text("Settings")
                }
                
            }
            .navigationTitle("Help")

            
//            List(0..<numSections, id: \.self) { index in
//                NavigationLink("Row \(index)", value: index)
//            }
//            .navigationDestination(for: Int.self) {
//                Text("Selected row \($0)")
//            }
//            .navigationTitle("Split View")
        }
        
    }
}

#Preview {
    HelpPage()
}
