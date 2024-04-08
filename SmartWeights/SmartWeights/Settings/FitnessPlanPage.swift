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
    let weeks = Array(0...3)
    let weight = Array(0...200)
    let sets = Array(0...10)
    let reps = Array(0...20)
    @State private var showClearConfirmation = false
    
    var body: some View {
        NavigationStack {
            SwiftUI.Form {
                Section(header: Text("Fitness Plan Summary")) {
                    Group {
                        VStack {
                            // Display workouts per week
                            Text("Workouts per week: \(viewModel.daysPerWeekGoal)")
                                .font(.system(size: 20))
                            
                            // Display weeks left
                            // Text("Weeks until goal is met: \(viewModel.weekGoal)")
                            //    .font(.system(size: 20))
                            
                            Text("Weeks Until Goal Completion: \(viewModel.weekGoal)")
                                .font(.system(size: 20))
                            
                            // Weight goal
                            Text("Weight Goal: \(viewModel.weightGoal * 5)") // Multiply by 5 to match your scale
                                .font(.system(size: 20))
                            // Set goal
                            Text("Sets Goal: \(viewModel.setGoal)")
                                .font(.system(size: 20))
                            // rep goal
                            Text("Reps Goal: \(viewModel.repGoal)")
                                .font(.system(size: 20))
                            // user notes
                            Text("Notes: \(viewModel.notes)")
                                .font(.system(size: 20))
                        }
                        .padding()
                        .cornerRadius(10)
                    }
                } // end of first section
                Section(header: Text("Fitness Plan Input")) {
                    Picker("Workouts Per Week", selection: $viewModel.daysPerWeekGoal) {
                        ForEach(daysPerWeek, id: \.self) { daysPerWeek in
                            Text("\(daysPerWeek)").tag(daysPerWeek)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Weeks Until Goal is Reached", selection: $viewModel.weekGoal) {
                        ForEach(weeks, id: \.self) { weeks in
                            Text("\(weeks)").tag(weeks)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Weight Goal", selection: $viewModel.weightGoal) {
                        ForEach(weight, id: \.self) { weight in
                            Text("\(weight)").tag(weight)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Set Goal", selection: $viewModel.setGoal) {
                        ForEach(sets, id: \.self) { sets in
                            Text("\(sets)").tag(sets)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Rep Goal", selection: $viewModel.repGoal) {
                        ForEach(reps, id: \.self) { reps in
                            Text("\(reps)").tag(reps)
                        }
                    }
                    .pickerStyle(.menu)
                    // Text field for entering notes
                    TextField("Enter fitness plan notes here...", text: $viewModel.notes)
                        .padding(10)
                        .background(Color.white)
                    //.border(Color.black, width: 1)
                        .cornerRadius(5)
                }
                Section(header: Text("Upcoming Dates")) {
                    if viewModel.weekGoal > 0 {
                            Button("Calculate End Date") {
                                viewModel.calculateFinishDate()
                            }
                            if let endDate = viewModel.endDate {
                                let dateFormatter: DateFormatter = {
                                    let formatter = DateFormatter()
                                    formatter.dateStyle = .medium
                                    return formatter
                                }()
                                Text("End Date: \(dateFormatter.string(from: endDate))")
                                    .font(.system(size: 20))
                            } else {
                                Text("End date not available")
                                    .font(.system(size: 20))
                            }
                        } else {
                            Text("No date available")
                                .font(.system(size: 20))
                        }
                }
                
            }
        }
    }
}

/// The fitnessPlanViewModel class contains variables for a user's fitness goals.
class fitnessPlanViewModel: ObservableObject {
    @Published var hasPlan: Bool = false // default to false
    @Published var daysPerWeekGoal: Int = 0
    @Published var weekGoal: Int = 0
    @Published var weightGoal: Int = 0
    @Published var setGoal: Int = 0
    @Published var repGoal: Int = 0
    @Published var notes: String = ""
    @Published var startDate: Date = Date() // current date
    @Published var endDate: Date? // used to calculate goal finish date
    
    func clearAllInputs() {  // reset all variables in viewModel
        self.hasPlan = false
        self.daysPerWeekGoal = 0
        self.weekGoal = 0
        self.weightGoal = 0
        self.setGoal = 0
        self.repGoal = 0
        self.notes = ""
        self.startDate = Date()
        self.endDate = nil
    }
    
    func calculateFinishDate() { // calculate finish date for given amount of weeks
        let daysInAdvance = weekGoal * 7
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: Date())
        let finishDate = calendar.date(byAdding: .day, value: daysInAdvance, to: currentDate)
        self.endDate = finishDate
    }
}

/// Preview screen
#Preview {
    FitnessPlanPage()
}

