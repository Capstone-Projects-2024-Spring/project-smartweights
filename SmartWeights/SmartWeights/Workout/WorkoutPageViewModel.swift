//
//  WorkoutPageViewModel.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/5/24.
//

import Foundation
import CloudKit
import SwiftUI


class WorkoutPageViewModel: ObservableObject{

    var petDBManager = PetDBManager.shared


    @Published var userTotalXP = 0
    var pet: PetModel?
    // Initializer
    init(){
        fetchPet()
        updateXP()
    }

    func updateXP(){
        petDBManager.getXP{ (totalXP, error) in
            if let error = error {
                print("Error getting XP: \(error.localizedDescription)")
            } else if let totalXP = totalXP {
                DispatchQueue.main.async {
                    self.userTotalXP = Int(totalXP)
                    print(" UserXP from WorkoutVM: \(self.userTotalXP)")
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
    func lowerHP() {
        // Lower pet's HP by 5
        print("I'm being called right now")
        guard let currentPet = self.pet else {
            print("No pet available to update health.")
            return
        }
        print("Current HP: \(currentPet.health)")
        let newHealth = max(currentPet.health - 5, 0) // Ensuring health doesn't go below 0
        petDBManager.updatePetHealth(newHealth: newHealth) { [weak self] error in
            if let error = error {
                print("Error updating pet's health: \(error.localizedDescription)")
            } else {
                self?.pet?.health = newHealth
                print("Pet's new HP: \(newHealth)")
            }
        }
    }
    private func fetchPet() {
        petDBManager.fetchPet { [weak self] pet, error in
            if let pet = pet {
                DispatchQueue.main.async {
                    self?.pet = pet
                }
            } else if let error = error {
                print("Error fetching pet: \(error.localizedDescription)")
            }
        }
    }
    
}
