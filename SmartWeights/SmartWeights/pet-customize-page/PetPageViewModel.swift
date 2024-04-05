//
//  PetPageViewModel.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/5/24.
//

import Foundation
import CloudKit
import SwiftUI


struct FoodItem: Identifiable {
    var id = UUID()
    var name: String
    var quantity: Int
    var imageName: String
}

class PetPageFunction: ObservableObject {
    
    var inventoryDBManager = InventoryDBManager()
    var userDBManager = UserDBManager()
    var petDBManager = PetDBManager()
    
    @Published var showShop = false
    @Published var showCustomize = false
    @Published var healthBar: Int = 50
    @Published var levelProgress = 0
    @Published var currentLevel = 1
    @Published var showFoodSelection = false
    @Published var selectedFoodIndex = 0
    @Published var foodItems = [
        FoodItem(name: "Orange", quantity: 10, imageName: "orange"),
        FoodItem(name: "Apple", quantity: 10, imageName: "apple"),
        FoodItem(name: "Juice", quantity: 10, imageName: "juice")
    ]
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    // Initializer
    

    func handleFoodUse(selectedFoodIndex: Int) {
        guard selectedFoodIndex < foodItems.count else { return }
        var foodItem = foodItems[selectedFoodIndex]
        
        if healthBar >= 100 {
            showAlert(title: "Max Health Reached", message: "Your pet is already at maximum health.")
        } else if foodItem.quantity > 0 {
            // Determine health increase amount
            let healthIncrease: Int = foodItem.name == "Orange" ? 20 : 10 // Orange increases by 0.2, others by 0.1
            increaseHealth(by: healthIncrease)
            
            foodItem.quantity -= 1
            foodItems[selectedFoodIndex] = foodItem
        } else {
            showAlert(title: "Insufficient \(foodItem.name)", message: "You don't have enough \(foodItem.name).")
        }
    }
    
    func increaseHealth(by amount: Int) {
        withAnimation {
            healthBar = min(healthBar + amount, 100) // Assuming max health is 100
        }
    }
    
    
    func AddXP(value: Int) {
        print("Adding \(value) to \(levelProgress)")
        print("UserXP: \(self.levelProgress + value)")
        petDBManager.updateUserXP(newXP: Int64(levelProgress + value)){
            error in
            if let error = error {
                print("Error updating currency: \(error.localizedDescription)")
            }
        }
        return levelProgress = levelProgress + value
    }
    
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
