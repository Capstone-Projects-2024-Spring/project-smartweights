//
//  CustomizeViewModel.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/12/24.
//

import Foundation
import CloudKit
import SwiftUI

struct Accessory: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
}

struct BackgroundImage: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
}

struct Pet_selection: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
}

class CustomizeViewModel: ObservableObject {
    @Published var equippedAccessory: Accessory?
    @Published var equippedBackgroundImage: BackgroundImage?
    @Published var equippedPet: Pet_selection?// Default pet
    @Published var backgroundColor: Color = .white // Default background color
    
    var backgroundItemDBManager = BackgroundItemDBManager()
    var clothingItemDBManager = ClothingItemDBManager()
    var petItemDBManager = PetItemDBManager()
    
    // @Published var isDataLoaded = false
    @Published var isPetDataLoaded = false
    @Published var isBackgroundDataLoaded = false
    @Published var isAccessoryDataLoaded = false
    @Published var isDataLoaded = false
    // Data arrays
    var accessories: [Accessory] = [
        // Accessory(name: "Chain", imageName: "chain"),
        // Accessory(name: "Glasses", imageName: "glasses"),
        // Accessory(name: "Jet Pack", imageName: "jetpack"),
    ]
    
    var backgroundImages: [BackgroundImage] = [
        // BackgroundImage(name: "Bamboo", imageName: "Bamboo"),
        // BackgroundImage(name: "Festive", imageName: "Festive"),
        // BackgroundImage(name: "Royal", imageName: "Royal"),
    ]
    
    var pets: [Pet_selection] = [
        // Pet_selection(name: "Dog", imageName: "Dog"),
        // Pet_selection(name: "Cat", imageName: "Cat"),
    ]
    
    init(){
        refreshFetch()
    }
    func refreshFetch(){
        backgroundItemDBManager.fetchBackgroundItems { backgroundItems, error in
            if let error = error {
                print("Error fetching background items: \(error.localizedDescription)")
                return
            }
            if let backgroundItems = backgroundItems {
                DispatchQueue.main.async {
                    self.backgroundImages = backgroundItems.map { item in
                        let backgroundImage = BackgroundImage(name: item.imageName, imageName: item.imageName)
                        if item.isActive == 1 {
                            self.equippedBackgroundImage = backgroundImage
                        }
                        return backgroundImage
                    }
                    self.isBackgroundDataLoaded = true
                    self.checkDataLoaded()
                }
            }
            
        }
        clothingItemDBManager.fetchClothingItems { clothingItems, error in
            if let error = error {
                print("Error fetching clothing items: \(error.localizedDescription)")
                return
            }
            if let clothingItems = clothingItems {
                DispatchQueue.main.async {
                    self.accessories = clothingItems.map { item in
                        let accessory = Accessory(name: item.imageName, imageName: item.imageName)
                        if item.isActive == 1 {
                            self.equippedAccessory = accessory
                        }
                        return accessory
                    }
                    self.isAccessoryDataLoaded = true
                    self.checkDataLoaded()
                }
            }
        }
        petItemDBManager.fetchPetItems { petItems, error in
            if let error = error {
                print("Error fetching pet items: \(error.localizedDescription)")
                return
            }
            if let petItems = petItems {
                DispatchQueue.main.async {
                    self.pets = petItems.map { item in
                        let pet = Pet_selection(name: item.imageName, imageName: item.imageName)
                        if item.isActive == 1 {
                            self.equippedPet = pet
                        }
                        return pet
                    }
                    self.isPetDataLoaded = true
                    self.checkDataLoaded()
                }
            }
        }
    }
    
    private func checkDataLoaded() {
        if isBackgroundDataLoaded && isAccessoryDataLoaded && isPetDataLoaded {
            self.isDataLoaded = true
        }
    }
    func saveCustomizations(){
        // Save the equipped items to the database
        print("Saving customizations...")
        if equippedAccessory == nil {
            clothingItemDBManager.setUnactiveAllClothingItems{ error in 
                if let error = error {
                    print("Error setting all clothing items to inactive: \(error.localizedDescription)")
                    return
                }
            }
        } else {
            clothingItemDBManager.setActiveClothingItem(imageName: equippedAccessory!.imageName){ clothing, error in
                if let error = error {
                    print("Error setting active clothing item: \(error.localizedDescription)")
                    return
                }
            }
        }
        
        if equippedBackgroundImage == nil {
            backgroundItemDBManager.setUnactiveAllBackgroundItems{ error in
                if let error = error {
                    print("Error setting all background items to inactive: \(error.localizedDescription)")
                    return
                }
            }
        } else {
            backgroundItemDBManager.setActiveBackgroundItem(imageName: equippedBackgroundImage!.imageName){ background, error in
                if let error = error {
                    print("Error setting active background item: \(error.localizedDescription)")
                    return
                }
            }
        }
        
        petItemDBManager.setActivePetItem(imageName: equippedPet!.imageName){ pet, error in
            if let error = error {
                print("Error setting active pet: \(error.localizedDescription)")
                return
            }
        }
    }
    
    
}
