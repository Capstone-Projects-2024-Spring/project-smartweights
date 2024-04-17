//
//  FitnessPlanPageViewModel.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/17/24.
//

import Foundation

/// The fitnessPlanViewModel class contains variables for a user's fitness goals.
class fitnessPlanViewModel: ObservableObject {
    @Published var hasPlan: Bool = false // default to false
    @Published var daysPerWeekGoal: Int = 0
    @Published var weightGoal: Int = 0
    @Published var setGoal: Int = 0
    @Published var repGoal: Int = 0
    @Published var notes: String = ""
    @Published var selectedDate: Date = Date() // current date
    
    var fitnessPlanDBManager = FitnessPlanDBManager()
    /// viewModel function to reset all variables
    func clearAllInputs() {
        self.hasPlan = false
        self.daysPerWeekGoal = 0
        self.weightGoal = 0
        self.setGoal = 0
        self.repGoal = 0
        self.notes = ""
        self.selectedDate = Date()
    }
    
    /// viewModel function to update the finess plan by saving the draft variables to the viewModel variables
    func updateFitnessPlan(daysPerWeekGoal: Int, weightGoal: Int, setGoal: Int, repGoal: Int, notes: String, selectedDate: Date) {
        self.daysPerWeekGoal = daysPerWeekGoal
        self.weightGoal = weightGoal
        self.setGoal = setGoal
        self.repGoal = repGoal
        self.notes = notes
        self.selectedDate = selectedDate

        // Save the fitness plan to the database
        fitnessPlanDBManager.createFitnessPlan(
            daysPerWeekGoal: Int64(daysPerWeekGoal),
            dumbbellWeightGoal: Int64(weightGoal),
            setGoal: Int64(setGoal),
            repGoal: Int64(repGoal),
            notes: notes,
            selectedDate: selectedDate
        )
    }
}
