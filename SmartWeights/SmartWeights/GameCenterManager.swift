//
//  GameCenterManager.swift
//  SmartWeights
//
//  Created by Jonathan Stanczak on 4/10/24.
//

import Foundation

import UIKit
import GameKit

class GameCenterManager: NSObject, ObservableObject { // Singleton instance
    
    static let shared = GameCenterManager()
    @Published var isAuthenticated = false
    
    
    private let gameCenterDelegate = GameCenterDelegate()
    
    override private init() {
        super.init()
        authenticateLocalPlayer()
    }
    
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
        GKLocalPlayer.local.authenticateHandler = { [weak self] viewController, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Game Center authentication failed: \(error.localizedDescription)")
                // Handle authentication failure
                self.isAuthenticated = false
            } else if let viewController = viewController {
                // Present the Game Center login view controller
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let window = scene.windows.first {
                        window.rootViewController?.present(viewController, animated: true, completion: nil)
                    }
                }
                self.isAuthenticated = false
            } else if GKLocalPlayer.local.isAuthenticated {
                // Player authenticated
                print("Game Center authenticated successfully!")
                self.isAuthenticated = true
            }
        }
    }
    
    func updateAchievement(identifier: String, progress: Double) {
        if !isAuthenticated {
            // Handle the case where the user is not authenticated
            authenticateLocalPlayer()
            //return
        }
        let achievement = GKAchievement(identifier: identifier)
        achievement.percentComplete = progress
        
        GKAchievement.report([achievement]) { error in
            if let error = error {
                print("Failed to report achievement: \(error.localizedDescription)")
                // Handle reporting error (e.g., show an error message)
            } else {
                print("Achievement reported successfully!")
                // Update UI or handle successful achievement reporting
            }
        }
    }
    
    // check if achievement is completed
    func checkAchievementCompletion(identifier: String) {
        guard GKLocalPlayer.local.isAuthenticated else {
            print("User is not authenticated with Game Center.")
            return
        }
        
        GKAchievement.loadAchievements { achievements, error in
            if let error = error {
                print("Failed to load achievements: \(error.localizedDescription)")
                return
            }
            
            if let achievement = achievements?.first(where: { $0.identifier == identifier }) {
                if achievement.percentComplete >= 100.0 && !achievement.isCompleted {
                    // Achievement is completed, handle accordingly
                    print("Achievement (\(identifier)) is completed!")
                }
            }
        }
    }
    
    func showGameCenterAchievements() {
        if !GameCenterManager.shared.isAuthenticated {
            // Handle the case where the user is not authenticated
            GameCenterManager.shared.authenticateLocalPlayer()
        }
        let gameCenterVC = GKGameCenterViewController()
        gameCenterVC.gameCenterDelegate = gameCenterDelegate
        // gameCenterVC.leaderboardIdentifier = nil // Show default achievements view
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController?.present(gameCenterVC, animated: true, completion: nil)
            }
        }
    }
    
    
    class GameCenterDelegate: NSObject, GKGameCenterControllerDelegate {
        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true, completion: nil)
        }
    }
}
