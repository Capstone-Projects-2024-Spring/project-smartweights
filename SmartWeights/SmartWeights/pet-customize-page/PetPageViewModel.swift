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
    var foodItemDBManager = FoodItemDBManager()
    @Published var showShop = false
    @Published var showCustomize = false
    @Published var healthBar: Int = 50
    // @Published var totalXP = 0
    @Published var currentLevel = 1
    @Published var showFoodSelection = false
    @Published var selectedFoodIndex = 0
    // @Published var foodItems = [
    //     FoodItem(name: "Orange", quantity: 10, imageName: "orange"),
    //     FoodItem(name: "Apple", quantity: 10, imageName: "apple"),
    //     FoodItem(name: "Juice", quantity: 10, imageName: "juice")
    // ]

    @Published var foodItems: [FoodItemModel] = []

    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""

    @Published var userTotalXP = 0
    var pet: PetModel?
    // Initializer
    init(){
        updateXP()
        foodItemDBManager.fetchFoodItems { fetchedItems, error in
            if let error = error {
                print("Error fetching food items: \(error)")
                return
            }
            if let fetchedItems = fetchedItems {
                DispatchQueue.main.async {
                    self.foodItems = fetchedItems
                }
            }
        }
    }

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
            foodItemDBManager.updateQuantity(name: foodItem.name, newQuantity: Int64(foodItem.quantity)){
                error in
                if let error = error {
                    print("Error updating food item quantity: \(error.localizedDescription)")
                }
            }
        } else {
            showAlert(title: "Insufficient \(foodItem.name)", message: "You don't have enough \(foodItem.name).")
        }
    }
    
    func increaseHealth(by amount: Int) {
        withAnimation {
            healthBar = min(healthBar + amount, 100) // Assuming max health is 100
        }
    }
    
    func updateXP(){
        petDBManager.getXP{ (totalXP, error) in
            if let error = error {
                print("Error getting currency: \(error.localizedDescription)")
            } else if let totalXP = totalXP {
                DispatchQueue.main.async {
                    self.userTotalXP = Int(totalXP)
                }
            }
        
        }
    }
    func AddXP(value: Int) {
        print("Adding \(value) to \(userTotalXP)")
        print("UserXP: \(self.userTotalXP + value)")
        petDBManager.updateUserXP(newXP: Int64(userTotalXP + value)){
            error in
            if let error = error {
                print("Error updating currency: \(error.localizedDescription)")
            }
        }
        return userTotalXP = userTotalXP + value
    }
    
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
