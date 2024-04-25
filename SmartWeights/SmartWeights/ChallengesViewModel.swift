//
//  ChallengesViewModel.swift
//  SmartWeights
//
//  Created by Timothy Bui on 4/23/24.
//

import SwiftUI
import Foundation

class ChallengesViewModel: ObservableObject {
    @Published var challenges: [Challenge] = [
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
}
