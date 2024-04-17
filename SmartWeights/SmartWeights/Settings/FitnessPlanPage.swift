//
//  FitnessPlanPage.swift
//  SmartWeights
//
//  Created by Jonathan Stanczak on 4/3/24.
//

import Foundation
import SwiftUI

/// FitnessPlanPage struct
struct FitnessPlanPage: View {
    @ObservedObject var viewModel = fitnessPlanViewModel()
    let daysPerWeek = Array(0...7)
    let weight = Array(0...200)
    let sets = Array(0...10)
    let reps = Array(0...20)
    @State private var showClearConfirmation = false
    
    // temp variables to make less database interaction
    @State private var draftDaysPerWeekGoal: Int = 0
    @State private var draftWeightGoal: Int = 0
    @State private var draftSetGoal: Int = 0
    @State private var draftRepGoal: Int = 0
    @State private var draftNotes: String = ""
    @State private var draftSelectedDate = Date()
    
    var body: some View {
        NavigationStack {
            SwiftUI.Form {
                Section(header: Text("Fitness Plan Input")) {
                    Picker("Workouts Per Week", selection: $draftDaysPerWeekGoal) {
                        ForEach(daysPerWeek, id: \.self) { daysPerWeek in
                            Text("\(daysPerWeek)").tag(daysPerWeek)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    DatePicker("Goal End Date", selection: $draftSelectedDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    Picker("Weight Goal", selection: $draftWeightGoal) {
                        ForEach(weight.filter { $0 % 5 == 0 }, id: \.self) { weight in
                            Text("\(weight)").tag(weight)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Set Goal", selection: $draftSetGoal) {
                        ForEach(sets, id: \.self) { sets in
                            Text("\(sets)").tag(sets)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Rep Goal", selection: $draftRepGoal) {
                        ForEach(reps, id: \.self) { reps in
                            Text("\(reps)").tag(reps)
                        }
                    }
                    .pickerStyle(.menu)
                    // Text field for entering notes
                    TextField("Enter fitness plan notes here...", text: $draftNotes)
                        .padding(10)
                        .background(Color.white)
                    //.border(Color.black, width: 1)
                        .cornerRadius(5)
                    
                    // save temp variables to viewModel variables, will update previous page
                    Button("Save") {
                        viewModel.updateFitnessPlan(
                            daysPerWeekGoal: draftDaysPerWeekGoal,
                            weightGoal: draftWeightGoal,
                            setGoal: draftSetGoal,
                            repGoal: draftRepGoal,
                            notes: draftNotes,
                            selectedDate: draftSelectedDate
                        )
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    // clear temp variables
                    Button("Clear Saved Entries") {
                        // Show confirmation dialog
                        showClearConfirmation = true
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .alert(isPresented: $showClearConfirmation) {
                        Alert(
                            title: Text("Are you sure you want to clear all entries? This will delete all inputs saved on the previous page!"),
                            primaryButton: .destructive(Text("Yes")) {
                                // Call clearAllInputs() method upon confirmation
                                viewModel.clearAllInputs()
                                clearTemp()
                            },
                            secondaryButton: .cancel(Text("No"))
                        )
                    }
                }
                .navigationTitle("Fitness Plan")
            } .onAppear {
                // Set draft variables to viewModel variables when view appears
                draftDaysPerWeekGoal = viewModel.daysPerWeekGoal
                draftWeightGoal = viewModel.weightGoal
                draftSetGoal = viewModel.setGoal
                draftRepGoal = viewModel.repGoal
                draftNotes = viewModel.notes
                draftSelectedDate = viewModel.selectedDate
            }
        }
    }
    
    /// struct function to clear the draft variables, is called when clearing saved entries
    func clearTemp() {
        draftDaysPerWeekGoal = 0
        draftWeightGoal = 0
        draftSetGoal = 0
        draftRepGoal = 0
        draftNotes = ""
        draftSelectedDate = Date() // reset selectedDate to current date
    }
}

/// The fitnessPlanViewModel class contains variables for a user's fitness goals.
class fitnessPlanViewModel: ObservableObject {
    @Published var hasPlan: Bool = false // default to false
    @Published var daysPerWeekGoal: Int = 0
    @Published var weightGoal: Int = 0
    @Published var setGoal: Int = 0
    @Published var repGoal: Int = 0
    @Published var notes: String = ""
    @Published var selectedDate: Date = Date() // current date
    
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
    }
}

/// Preview screen
#Preview {
    FitnessPlanPage()
}
