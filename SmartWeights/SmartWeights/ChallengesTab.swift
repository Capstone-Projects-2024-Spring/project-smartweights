//
//  ChallengesTab.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/16/24.
//

import SwiftUI

struct ChallengesTab: View {
    let challenges = [
        Challenge(title: "1st Sign In", description: "Log in to SmartWeights for the first time.", currentProgress: 0, progressGoal: 1, coinReward: "+ 50 PC", xpReward: "+ 10 XP", image: Image("C-1stLogin")),
        Challenge(title: "1st Workout", description: "Complete your first workout.", currentProgress: 0, progressGoal: 1, coinReward: "+ 50 PC", xpReward: "+ 10 XP", image: Image("C-1stWorkout")),
        Challenge(title: "New Shopper", description: "Purchase your first item in the pet store.", currentProgress: 0, progressGoal: 1, coinReward: "+ 50 PC", xpReward: "+ 10 XP", image: Image("C-1stItemBought")),
        Challenge(title: "Outfit Change", description: "Customize your pet for the first time.", currentProgress: 0, progressGoal: 1, coinReward: "+ 50 PC", xpReward: "+ 10 XP", image: Image("C-1stOutfitChange")),
        Challenge(title: "Sharing Companion", description: "Interact with the share button on the profile tab.", currentProgress: 0, progressGoal: 1, coinReward: "+ 50 PC", xpReward: "+ 10 XP", image: Image("SharingCompanion")),
        Challenge(title: "New Best Friends", description: "Level up your pet to level 2.", currentProgress: 1, progressGoal: 2, coinReward: "+ 100 PC", xpReward: "+ 20 XP", image: Image("NewBestFriends")),
        Challenge(title: "Dinner Time", description: "Feed your pet 50 times.", currentProgress: 0, progressGoal: 50, coinReward: "+ 250 PC", xpReward: "+ 50 XP", image: Image("DinnerTime")),
        Challenge(title: "Loyal Customer", description: "Spend 2000 pet coins in the pet store.", currentProgress: 0, progressGoal: 2000, coinReward: "+ 500 PC", xpReward: "+ 75 XP", image: Image("LoyalCustomer")),
        Challenge(title: "Workout Machine", description: "Complete 50 workouts.", currentProgress: 0, progressGoal: 50, coinReward: "+ 500 PC", xpReward: "+ 50 XP", image: Image("WorkoutMachine")),
        Challenge(title: "Perfect Form", description: "Complete 100 workouts.", currentProgress: 0, progressGoal: 100, coinReward: "+ 1000 PC", xpReward: "+ 100 XP", image: Image("PerfectForm")),
        Challenge(title: "Dynamic Duo", description: "Level up your pet to level 10.", currentProgress: 1, progressGoal: 10, coinReward: "+ 1500 PC", xpReward: "+ 100 XP", image: Image("DynamicDuo"))
    ]
    
    var body: some View {
        NavigationView {
            ChallengesList(challenges: challenges)
                .navigationBarTitle("Achievements", displayMode: .inline)
        }
    }
}

struct Challenge: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var currentProgress: Int
    var progressGoal: Int
    var coinReward: String
    var xpReward: String
    var image: Image // added for custom images
    
    var isCompleted: Bool {
            return currentProgress >= progressGoal
        }
    
    var progressPercent: Double {
        return Double(currentProgress) / Double(progressGoal)
    }
}

struct ChallengeRow: View {
    var challenge: Challenge
    
    var body: some View {
        VStack {
            HStack {
                challenge.image // display image for each challenge
                    .resizable()
                    .frame(width: 60, height: 60) // can change size if needed
                //Image(systemName: "figure.strengthtraining.traditional")
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
                VStack(alignment: .trailing) {
                    Text("\(challenge.currentProgress)/\(challenge.progressGoal)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Text(challenge.coinReward)
                        .font(.subheadline)
                        .foregroundColor(.green)
                    Text(challenge.xpReward)
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
            }
            ProgressView(value: challenge.progressPercent)
                .progressViewStyle(LinearProgressViewStyle())
        }
    }
}

struct ChallengesList: View {
    @State private var selectedTab = 0
    var challenges: [Challenge]
    
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
                Button(action: {
                    // Handle GC button logic here
                }) {
                    Image("GameCenterIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30) // can adjust if needed
                        .foregroundColor(.blue)
                        .padding(1)
                        .background(Color.white)
                }
                Spacer()
            }
            
            // Allows achievements to appear as In Progress or Completed
            List(challenges.filter { selectedTab == 0 ? !$0.isCompleted : $0.isCompleted }) { challenge in
                           ChallengeRow(challenge: challenge)
            }
        }
        
    }
}

#Preview {
    ChallengesTab()
}
