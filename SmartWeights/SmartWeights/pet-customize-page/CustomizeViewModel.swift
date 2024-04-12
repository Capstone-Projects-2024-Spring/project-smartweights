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
    @Published var equippedPet: Pet_selection? = Pet_selection(name: "Dog", imageName: "Dog") // Default pet
    @Published var backgroundColor: Color = .white // Default background color
    
    // Data arrays
    let accessories: [Accessory] = [
        Accessory(name: "Chain", imageName: "chain"),
        Accessory(name: "Glasses", imageName: "glasses"),
        Accessory(name: "Jet Pack", imageName: "jetpack"),
    ]
    
    let backgroundImages: [BackgroundImage] = [
        BackgroundImage(name: "Bamboo", imageName: "Bamboo"),
        BackgroundImage(name: "Festive", imageName: "Festive"),
        BackgroundImage(name: "Royal", imageName: "Royal"),
    ]
    
    let pets: [Pet_selection] = [
        Pet_selection(name: "Dog", imageName: "Dog"),
        Pet_selection(name: "Cat", imageName: "Cat"),
    ]
}
