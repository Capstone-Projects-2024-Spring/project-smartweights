//
//  GameCenterManager.swift
//  SmartWeights
//
//  Created by Jonathan Stanczak on 4/10/24.
//

import Foundation

import UIKit
import GameKit

struct GameCenterConstants { // constants for achievements and their achievement ID (can be found on CloudKit)
    static let firstSignInAchievement = "SmartWeights.Achievement.1stSignIn"
    static let firstWorkoutAchievement = "SmartWeights.Achievement.1stWorkout"
    static let NewShopperAchievement = "SmartWeights.Achievement.NewShopper"
    static let OutfitChangeAchievement = "SmartWeights.Achievement.OutfitChange"
    static let SharingCompanionAchievement = "SmartWeights.Achievement.SharingCompanion"
    static let DinnerTimeAchievement = "SmartWeights.Achievement.DinnerTime"
    static let LoyalCustomerAchievement = "SmartWeights.Achievement.LoyalCustomer"
    static let NewBestFriendsAchievement = "SmartWeights.Achievement.NewBestFriends"
    static let WorkoutMachineAchievement = "SmartWeights.Achievement.WorkoutMachine"
    static let PerfectFormAchievement = "SmartWeights.Achievement.PerfectForm"
    static let DynamicDuoAchievement = "SmartWeights.Achievement.DynamicDuo"
}

func authenticateLocalPlayer() {
    GKLocalPlayer.local.authenticateHandler = { viewController, error in
        if let error = error {
            print("Game Center authentication failed: \(error.localizedDescription)")
        } else if let viewController = viewController {
            // Present the Game Center login view controller
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = scene.windows.first {
                    window.rootViewController?.present(viewController, animated: true, completion: nil)
                }
            }
        } else if GKLocalPlayer.local.isAuthenticated {
            print("Game Center authenticated successfully!")
        }
    }
}

func reportAchievement(identifier: String, percentComplete: Double) {
    guard GKLocalPlayer.local.isAuthenticated else {
        print("Player is not authenticated to Game Center.")
        return
    }
    
    let achievement = GKAchievement(identifier: identifier)
    achievement.percentComplete = percentComplete
    achievement.showsCompletionBanner = true // Show achievement banner on completion
    
    GKAchievement.report([achievement]) { error in
        if let error = error {
            print("Failed to report achievement: \(error.localizedDescription)")
        } else {
            print("Achievement reported successfully!")
        }
    }
}
