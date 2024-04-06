//
//  MorePageViewModel.swift
//  SmartWeights
//
//  Created by Timothy Bui on 4/3/24.
//

import Foundation

class MorePageViewModel: ObservableObject {
    var userDBManager = UserDBManager()
    @Published var balance = 0
    @Published var achievements: [Achievement] = [
        Achievement(title: "Achievement 1", description: "", img: "trophy.circle", reward: 50),
        Achievement(title: "Achievement 2", description: "", img: "trophy.circle", reward: 100),
        Achievement(title: "Achievement 3", description: "", img: "trophy.circle", reward: 200),
        Achievement(title: "Achievement 4", description: "", img: "trophy.circle", reward: 400),
        Achievement(title: "Achievement 5", description: "", img: "trophy.circle", reward: 800),
        Achievement(title: "Achievement 6", description: "", img: "trophy.circle", reward: 1600),
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
