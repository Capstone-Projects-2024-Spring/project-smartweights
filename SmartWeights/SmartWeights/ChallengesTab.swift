//
//  ChallengesTab.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/16/24.
//

import SwiftUI
import GameKit

struct ChallengesTab: View {
    @State var challenges: [Challenge] = [
        Challenge(title: "1st Workout", description: "Complete your first workout.", image: Image("C-1stWorkout"), achievementIdentifier: "SmartWeights.Achievement.1stWorkout", currentProgress: 0, isCompleted: false),
        Challenge(title: "New Shopper", description: "Purchase your first item in the pet store.", image: Image("C-1stItemBought"), achievementIdentifier: "SmartWeights.Achievement.NewShopper", currentProgress: 0, isCompleted: false),
        Challenge(title: "Outfit Change", description: "Customize your pet for the first time.", image: Image("C-1stOutfitChange"), achievementIdentifier: "SmartWeights.Achievement.OutfitChange", currentProgress: 0, isCompleted: false),
        Challenge(title: "Sharing Companion", description: "Interact with the share button on the profile tab.", image: Image("SharingCompanion"), achievementIdentifier: "SmartWeights.Achievement.SharingCompanion", currentProgress: 0, isCompleted: false),
        Challenge(title: "New Best Friends", description: "Level up your pet to level 2.", image: Image("NewBestFriends"), achievementIdentifier: "SmartWeights.Achievement.NewBestFriends", currentProgress: 0, isCompleted: false),
        Challenge(title: "Dinner Time", description: "Feed your pet 50 times.", image: Image("DinnerTime"), achievementIdentifier: "SmartWeights.Achievement.DinnerTime", currentProgress: 0, isCompleted: false),
        Challenge(title: "Loyal Customer", description: "Purchase 50 items in the pet store.", image: Image("LoyalCustomer"), achievementIdentifier: "SmartWeights.Achievement.LoyalCustomer", currentProgress: 0, isCompleted: false),
        Challenge(title: "Workout Machine", description: "Complete 50 workouts.", image: Image("WorkoutMachine"), achievementIdentifier: "SmartWeights.Achievement.WorkoutMachine", currentProgress: 0, isCompleted: false),
        Challenge(title: "Perfect Form", description: "Complete 100 workouts.", image: Image("PerfectForm"), achievementIdentifier: "SmartWeights.Achievement.PerfectForm", currentProgress: 0, isCompleted: false),
        Challenge(title: "Dynamic Duo", description: "Level up your pet to level 10.", image: Image("DynamicDuo"), achievementIdentifier: "SmartWeights.Achievement.DynamicDuo", currentProgress: 0, isCompleted: false)
    ]
    
    var body: some View {
        NavigationView {
            ChallengesList(challenges: challenges, fetchGameCenterProgress: fetchGameCenterProgress)
                .navigationBarTitle("Achievements", displayMode: .inline)
                .preferredColorScheme(.light) // force light mode
        }
    }
    
    func fetchGameCenterProgress() {
        GameCenterManager.shared.fetchAllAchievementsProgress { progressDict, error in
            if let error = error {
                print("Error fetching achievements: \(error.localizedDescription)")
            } else if let progressDict = progressDict {
                DispatchQueue.main.async {
                    for i in self.challenges.indices {
                        if let percentComplete = progressDict[self.challenges[i].achievementIdentifier] {
                            // Update the current progress with the fetched percent complete directly
                            self.challenges[i].currentProgress = Int(percentComplete)
                            // Determine if the challenge is completed based on whether the percent complete is 100
                            self.challenges[i].isCompleted = percentComplete == 100.0
                        }
                    }
                }
            }
        }
    }
}

class Challenge: Identifiable, ObservableObject {
    var id = UUID()
    var title: String
    var description: String
    var image: Image // added for custom images
    var achievementIdentifier: String
    @Published var currentProgress: Int
    @Published var isCompleted: Bool
    
    init(title: String, description: String, image: Image, achievementIdentifier: String, currentProgress: Int, isCompleted: Bool) {
        self.title = title
        self.description = description
        self.image = image
        self.achievementIdentifier = achievementIdentifier
        self.currentProgress = currentProgress
        self.isCompleted = isCompleted
    }
}

struct ChallengesList: View {
    @State private var selectedTab = 0
    var challenges: [Challenge]
    var fetchGameCenterProgress: () -> Void
    @State private var updateListKey = false // Added state to force update

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Picker(selection: $selectedTab, label: Text("Select a tab")) {
                    Text("In Progress").tag(0)
                    Text("Completed").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
                
                Button(action: refreshList) {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 5)  // Provide some spacing between buttons
                
                Button(action: {
                    GameCenterManager.shared.showGameCenterAchievements()
                }) {
                    Image("GameCenterIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        .padding(1)
                        .background(Color.white)
                }
                Spacer()
            }
            .padding(.horizontal)

            List(challenges.filter { selectedTab == 0 ? !$0.isCompleted : $0.isCompleted }) { challenge in
                VStack {
                    HStack {
                        challenge.image // display image for each challenge
                            .resizable()
                            .frame(width: 60, height: 60) // can change size if needed
                            .foregroundColor(.yellow)
                            .padding(.trailing, 8)
                        VStack(alignment: .leading) {
                            Text(challenge.title)
                                .font(.headline)
                            Text(challenge.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    ProgressView(value: Double(challenge.currentProgress), total: 100)
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(.blue) // Customizing the color of the progress bar
                }
            }
            .id(updateListKey) // Use the state key to force the list to re-render
        }
        .onAppear(perform: refreshList)
    }
    
    func refreshList() {
        fetchGameCenterProgress()
        updateListKey.toggle() // Toggle the key to force the list to update
    }
}

#Preview {
    ChallengesTab()
}

