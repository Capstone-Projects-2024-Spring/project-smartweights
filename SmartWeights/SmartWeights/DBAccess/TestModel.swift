//
//  TestModel.swift
//  SmartWeights
//
//  Created by Daniel Eap on 3/18/24.
//

import Foundation

// Model
class PetModel: ObservableObject {
    @Published var health: Int
    @Published var level: Int
    @Published var totalXP: Int

    init(health: Int, level: Int, totalXP: Int) {
        self.health = health
        self.level = level
        self.totalXP = totalXP
    }
}
