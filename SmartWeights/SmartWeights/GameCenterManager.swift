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
    
    /// /// GameCenterManager class function to authenticate.
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
    
    /// GameCenterManager class function to update achievement progress.
    // FUNCTION USED TO UPDATE ACHIEVEMENTS ON GAME CENTER
    func updateAchievement(identifier: String, progressToAdd: Double) {
        guard GKLocalPlayer.local.isAuthenticated else {
            print("User is not authenticated with Game Center.")
            return
        }
        
        // Load current achievements to check and update the status.
        GKAchievement.loadAchievements { [weak self] achievements, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Failed to load achievements: \(error.localizedDescription)")
                return
            }
            
            // Find the specific achievement and add to its current progress.
            if let achievements = achievements, let achievement = achievements.first(where: { $0.identifier == identifier }) {
                let currentProgress = achievement.percentComplete
                let newProgress = min(currentProgress + progressToAdd, 100.0) // Ensure not to exceed 100%
                self.setAchievementProgress(achievement: achievement, progress: newProgress)
            } else {
                // If the achievement is not found or no achievements exist, initialize it.
                self.setAchievementProgress(achievement: GKAchievement(identifier: identifier), progress: min(progressToAdd, 100.0))
            }
        }
    }
    
    /// Sets the achievement progress.
    private func setAchievementProgress(achievement: GKAchievement, progress: Double) {
            achievement.percentComplete = progress
            achievement.showsCompletionBanner = true  // Optionally show a banner if the achievement is completed.

            GKAchievement.report([achievement]) { error in
                if let error = error {
                    print("Failed to report achievement: \(error.localizedDescription)")
                } else {
                    print("Achievement progress updated successfully to \(progress)% for identifier \(achievement.identifier)")
                }
            }
        }
    
    /// GameCenterManager class function to check if an achievement is completed.
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
    
    /// GameCenterManager class function to display Game Center.
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
    
    /// GameCenterManager class function to report achievement.
    // Currently not in use
    func reportAchievement(challenge: Challenge) {
       let achievement = GKAchievement(identifier: challenge.achievementIdentifier)
       achievement.percentComplete = 100.0
       
       GKAchievement.report([achievement]) { error in
           if let error = error {
               print("Failed to report achievement: \(error.localizedDescription)")
           } else {
               print("Achievement reported successfully!")
               // Update challenge completion status in UI
               // Note: This should ideally be updated based on the Game Center callback
           }
       }
   }
    
    /// GameCenterDelegate class for loading Game Center UI into game
    class GameCenterDelegate: NSObject, GKGameCenterControllerDelegate {
        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    /// GameCenterManager class function that fetches all achievements and their completion percentages.
    func fetchAllAchievementsProgress(completion: @escaping ([String: Double]?, Error?) -> Void) {
        guard isAuthenticated else {
            print("User is not authenticated with Game Center.")
            authenticateLocalPlayer()
            completion(nil, NSError(domain: "GameCenterManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "User is not authenticated with Game Center."]))
            return
        }
        
        GKAchievement.loadAchievements { achievements, error in
            if let error = error {
                print("Failed to load achievements: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            var achievementsProgress: [String: Double] = [:]
            achievements?.forEach { achievement in
                achievementsProgress[achievement.identifier] = achievement.percentComplete
            }
            completion(achievementsProgress, nil)
        }
    }

}
