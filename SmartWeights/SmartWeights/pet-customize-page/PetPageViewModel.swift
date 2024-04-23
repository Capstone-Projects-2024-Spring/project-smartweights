//
//  PetPageViewModel.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/5/24.
//

import Foundation
import CloudKit
import SwiftUI
import Combine


struct FoodItem: Identifiable {
    var id = UUID()
    var name: String
    var quantity: Int
    var imageName: String
}

class PetPageFunction: ObservableObject {
    //    static let shared = PetPageFunction()
    
    var petDBManager = PetDBManager.shared
    var petItemDBManager = PetItemDBManager.shared
    var clothingItemDBManager = ClothingItemDBManager.shared
    var backgroundItemDBManager = BackgroundItemDBManager.shared
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
    
    // @Published var petItems: [PetItemModel] = []
    
    @Published var isLoading = false
    
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    @Published var userTotalXP = 0
    
    @Published var pet: PetModel?
    
    @Published var activePet: String = ""
    @Published var activeBackground: String = ""
    @Published var activeClothing: String = ""
    
    // private var cancellables = Set<AnyCancellable>()
    // Initializer
    init(){
        // fetchPetHealth()
        //updateXP()
        updateLevel()
        
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
        // petItemDBManager.fetchPetItems{ petItems, error in
        //     if let error = error {
        //         print("Error fetching pet items: \(error.localizedDescription)")
        //         return
        //     }
        //     if let petItems = petItems {
        //         DispatchQueue.main.async {
        //             self.petItems = petItems
        //         }
        //     }
        
        // }
        // activePet = petItemDBManager.g_getActivePet()
        // activeClothing = clothingItemDBManager.g_getActiveClothing()
        //  petItemDBManager.getActivePet{ activePet, error in
        //      if let error = error {
        //          print("Error fetching activePet: \(error.localizedDescription)")
        //          return
        //      } else {
        //          DispatchQueue.main.async {
        //              self.activePet = activePet
        //              print("ACTIVE PET: \(self.activePet)")
        //          }
        //      }
        //  }
        //  petItemDBManager.$activePet
        // .sink { [weak self] newActivePet in
        //     self?.activePet = newActivePet
        // }
        // .store(in: &cancellables)
        //        activePet = petItemDBManager.activePet
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
        guard let currentPet = pet else {
            print("Pet not available")
            return
        }
        let newHealth = min(Int(currentPet.health) + amount, 100)
        petDBManager.updatePetHealth(newHealth: Int64(newHealth)) { [weak self] error in
            if let error = error {
                print("Error updating pet's health: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    // Perform the animation after confirming the health is updated in CloudKit
                    withAnimation {
                        self?.healthBar = Int(newHealth)
                    }
                    // Update the local pet model
                    self?.pet?.health = Int64(newHealth)
                }
            }
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
    
    func updateLevel(){
        petDBManager.getLevel{ (userLevel, error) in
            if let error = error {
                print("Error getting Level: \(error.localizedDescription)")
            } else if let userLevel = userLevel {
                DispatchQueue.main.async {
                    self.currentLevel = Int(userLevel)
                }
            }
            
        }
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    func getActivePet(){
        petItemDBManager.getActivePet { (activePet, error) in
            if let error = error {
                print("Error getting active pet: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.activePet = activePet
                }
            }
        }
    }
    
    
    func refreshData() {
        isLoading = true
        let group = DispatchGroup()
        
        group.enter()
        fetchPetHealth()
        group.leave()
        
        
        group.enter()
        petDBManager.getXP{ (totalXP, error) in
            if let error = error {
                print("Error getting XP: \(error.localizedDescription)")
            } else if let totalXP = totalXP {
                DispatchQueue.main.async {
                    self.userTotalXP = Int(totalXP)
                    print("XP has been initialized to: \(self.userTotalXP)")
                }
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
        }
    }
    
    func addXP(value: Int) {
        let newProgress = userTotalXP + value
        updateXPAndLevelIfNeeded(newXP: newProgress)
    }
    
    private func updateXPAndLevelIfNeeded(newXP: Int) {
        let neededXPForNextLevel = 100
        var newXpAfterLevelUp = newXP
        var newLevel = currentLevel
        var levelChanged = false

        // Loop to handle multiple level-ups in one go
        while newLevel < 10 && newXpAfterLevelUp >= neededXPForNextLevel {
            newXpAfterLevelUp -= neededXPForNextLevel
            newLevel += 1
            levelChanged = true
            print("Level up: \(newLevel), Remaining XP after level up: \(newXpAfterLevelUp)")
        }

        // If maximum level is reached, cap XP and level
        if newLevel >= 10 {
            newLevel = 10
            newXpAfterLevelUp = min(newXpAfterLevelUp, neededXPForNextLevel)
            print("Max level reached: \(newLevel), XP capped at: \(newXpAfterLevelUp)")
        }

        // Update the database and local state
        if levelChanged || newXpAfterLevelUp != userTotalXP {
            updateUserXPInDatabase(newXP: newXpAfterLevelUp) { success in
                if success {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.userTotalXP = newXpAfterLevelUp
                            if levelChanged {
                                self.currentLevel = newLevel
                                self.updateUserLevelInDatabase(newLevel: newLevel)
                            }
                        }
                    }
                } else {
                    print("Failed to update XP in the database.")
                }
            }
        } else {
            print("No XP or level change needed. Current XP: \(userTotalXP), Current Level: \(currentLevel)")
        }
    }

    private func updateUserLevelInDatabase(newLevel: Int) {
        petDBManager.updateUserLevel(newLevel: Int64(newLevel)) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error updating Level in database: \(error.localizedDescription)")
                } else {
                    print("Level successfully updated in database to Level: \(newLevel)")
                }
            }
        }
    }

    private func updateUserXPInDatabase(newXP: Int, completion: @escaping (Bool) -> Void) {
        petDBManager.updateUserXP(newXP: Int64(newXP)) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error updating XP: \(error.localizedDescription)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
    
    
    func fetchPetHealth() {
        petDBManager.fetchPet { [weak self] pet, error in
            if let error = error {
                print("Error fetching pet: \(error.localizedDescription)")
            } else if let pet = pet {
                DispatchQueue.main.async {
                    self?.pet = pet
                    self?.healthBar = Int(pet.health)
                }
            }
        }
    }
    
    
    
    func getActiveAll(){
        activeClothing = clothingItemDBManager.g_getActiveClothing()
        activePet = petItemDBManager.g_getActivePet()
        activeBackground = backgroundItemDBManager.g_getActiveBackground()
    }
    func getPetStats(){
        userTotalXP = petDBManager.getXP()
        healthBar = petDBManager.getHealth()
    }
    
}
