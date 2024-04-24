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
    @State private var showSaveConfirmation = false
    
    // draft/temp vars to prevent extra database calls
    @State private var draftDaysPerWeekGoal: Int = 0
    @State private var draftWeightGoal: Int = 0
    @State private var draftSetGoal: Int = 0
    @State private var draftRepGoal: Int = 0
    @State private var draftNotes: String = ""
    @State private var draftSelectedDate = Date()
    
    let characterLimit = 200 // for notes field
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Fitness Plan Input")) {
                    Picker("Workouts Per Week", selection: $draftDaysPerWeekGoal) {
                        ForEach(daysPerWeek, id: \.self) { daysPerWeek in
                            Text("\(daysPerWeek)").tag(daysPerWeek)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    DatePicker("Goal End Date", selection: $draftSelectedDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    Picker("Dumbbell Weight Goal", selection: $draftWeightGoal) {
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
                    
                    ZStack(alignment: .topTrailing) {
                        TextEditor(text: $draftNotes)
                            .frame(minHeight: 100)
                            .padding(2)
                            .background(Color.white)
                            .cornerRadius(5)
                        if draftNotes.isEmpty {
                            Text("Enter your notes here...")
                                .foregroundColor(.gray)
                                .padding(6)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Text("\(draftNotes.count)/\(characterLimit)")
                            .foregroundColor(draftNotes.count > characterLimit ? .red : .primary)
                            .font(.caption)
                            .padding(.trailing, 5)
                            .padding(.top, 5)
                            .offset(y: -5)
                    }
                    .frame(maxHeight: .infinity)
                    .padding()
                    
                    Button("Save") {
                        showSaveConfirmation = true
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
                    
                    Button("Clear Saved Entries") {
                        showClearConfirmation = true
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                }
                .navigationTitle("Fitness Plan")
            }
            .alert("Fitness plan successfully saved.", isPresented: $showSaveConfirmation) {
                Button("OK", role: .cancel) { }
            }
            .alert("Are you sure you want to clear all entries? This will delete all inputs saved on the previous page!", isPresented: $showClearConfirmation) {
                Button("No", role: .cancel) { }
                Button("Yes", role: .destructive) {
                    viewModel.clearAllInputs()
                    clearTemp()
                }
            }
            .onAppear { // show current viewModel vars when page loads
                draftDaysPerWeekGoal = viewModel.daysPerWeekGoal
                draftWeightGoal = viewModel.weightGoal
                draftSetGoal = viewModel.setGoal
                draftRepGoal = viewModel.repGoal
                draftNotes = viewModel.notes
                draftSelectedDate = viewModel.selectedDate
            }
        }
    }
    
    /// FitessPlanPage struct function to reset temporary variables
    func clearTemp() {
        draftDaysPerWeekGoal = 0
        draftWeightGoal = 0
        draftSetGoal = 0
        draftRepGoal = 0
        draftNotes = ""
        draftSelectedDate = Date() // reset selectedDate to current date
    }
    
}
/// Preview screen
#Preview {
    FitnessPlanPage()
}
