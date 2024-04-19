//
//  Achievement.swift
//  SmartWeights
//
//  Created by Timothy Bui on 4/16/24.
//

import Foundation
import SwiftUI

struct Achievement: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var image: Image
    var reward: Int
    var currentProgress: Int
    var progressGoal: Int
    var isClaimed: Bool = false
    
    mutating func claim() {
        isClaimed = true
    }
    
    var progressPercent: Double {
        return Double(currentProgress) / Double(progressGoal)
    }
    
    var isComplete: Bool {
        if (currentProgress >= progressGoal) {
            return true
        } else {
            return false
        }
    }
}
