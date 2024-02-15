//
//  WorkoutData.swift
//  SmartWeights
//
//  Created by Tu Ha on 2/15/24.
//

import Foundation

struct DataPoints: Identifiable {
    
    var id = UUID().uuidString
    var date: String
    var form: Int
}
