//
//  MorePageViewModel.swift
//  SmartWeights
//
//  Created by Timothy Bui on 4/3/24.
//

import Foundation
import SwiftUI

class AchievementsViewModel: ObservableObject {
    var userDBManager = UserDBManager()
    @Published var balance = 0
    @Published var achievements: [Achievement] = [
        Achievement(title: "1st Sign In", description: "Sign in for the first time.", image: Image("C-1stLogin"), reward: 100, currentProgress: 1, progressGoal: 1),
        Achievement(title: "1st Workout", description: "Complete your first workout.", image: Image("C-1stWorkout"), reward: 100, currentProgress: 1, progressGoal: 1),
        Achievement(title: "New Shopper", description: "Purchase your first item.", image: Image("C-1stItemBought"), reward: 100, currentProgress: 1, progressGoal: 1),
        Achievement(title: "Outfit Change", description: "Customize your pet's outfit and background for the first time.", image: Image("C-1stOutfitChange"), reward: 100, currentProgress: 0, progressGoal: 1)
    ]
    
    init() {
        getBalance()
    }
    
    func getBalance() {
        userDBManager.getCurrency { (currency, error) in
            if let error = error {
                print("Error getting currency: \(error.localizedDescription)")
            } else if let currency = currency {
                DispatchQueue.main.async {
                    self.balance = Int(currency)
                }
            }
        }
    }
    
    func addToBalance(amount: Int) {
        print("Adding \(amount) to \(balance)")
        userDBManager.updateCurrency(newCurrency: Int64(balance + amount)) { error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                print("SUCCESS")
            }
        }
        
        return balance += amount
    }
    
    func claimAchievement(id: UUID) {
        if let index = achievements.firstIndex(where: { $0.id == id }) {
            achievements[index].claim()
            addToBalance(amount: achievements[index].reward)
        }
    }
}
