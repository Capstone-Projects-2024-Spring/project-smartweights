//
//  SettingsPageView.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/29/24.
//

import SwiftUI

struct SettingsPageView: View {
    let heightFeetArray = Array(0...9)
    let heightInchesArray = Array(0...11)
    let weightsArray = Array(0...500)
    let chestWidthsArray = Array(0...100)
    let upperArmLengthsArray = Array(0...100)
    let forearmLengthsArray = Array(0...100)
    
    @State private var selectedFeet = 0
    @State private var selectedInches = 0
    @State private var selectedWeight = 0
    @State private var selectedChestWidth = 0
    @State private var selectedUpperArmLength = 0
    @State private var selectedForearmLength = 0
    
    @State private var allNotificationsEnabled = false
    @State private var workoutNotificationsEnabled = false
    @State private var petNotificationsEnabled = false
    @State private var healthKitEnabled = false
    
    @State private var showingLogoutConfirmation = false
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userID") var userID: String = ""
    
    @ObservedObject var viewModel = fitnessPlanViewModel()
    let daysPerWeek = Array(0...7)
    let weeks = Array(0...3)
    let weight = Array(0...200)
    let sets = Array(0...10)
    let reps = Array(0...20)
    @State private var showClearConfirmation = false
    @State private var isEditing: Bool = false // Track whether fitness plan editing mode is active
    
    /// struct function to print date with only month/date/year and prevent the time and time zone from displayin
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: viewModel.selectedDate)
    }
    
    var body: some View {
        NavigationStack {
            SwiftUI.Form {
                /*
                Section(header: Text("Profile")) {
                    Group {
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(
                                        width: 100,
                                        height: 100
                                    )
                                Text("First Last")
                                Button("Edit Profile") {
                                    
                                }
                                .font(.footnote)
                                .foregroundStyle(Color(Color.white))
                                .padding()
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
                */
                Section(header: Text("Fitness Plan Summary")) {
                    Group {
                        VStack(alignment: .center) {
                            // Workouts goal
                            Text("Workouts per week: \(viewModel.daysPerWeekGoal)")
                                .font(.system(size: 20))
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            // Weeks goal
                            Text("Goal End Date: \(formattedDate)")
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
                    .frame(maxWidth: .infinity)
                    
                    // Navigation Link to Edit Fitness Plan
                    NavigationLink(destination: FitnessPlanPage(viewModel: viewModel)) {
                        Text("Edit Fitness Plan")
                        //.padding() // if want navigation button to be bigger
                    }
                }
                
//                Section(header: Text("Body Measurements")) {
//                    Picker("Weight", selection: $selectedWeight) {
//                        ForEach(weightsArray, id: \.self) { weight in
//                            Text("\(weight) lb").tag(weight)
//                        }
//                    }
//                    .pickerStyle(.menu)
//                    HStack {
//                        Text("Height")
//                        Spacer()
//                        Picker("Feet", selection: $selectedFeet) {
//                            ForEach(heightFeetArray, id: \.self) { feet in
//                                Text("\(feet) ft").tag(feet)
//                            }
//                        }
//                        .labelsHidden()
//                        .pickerStyle(.menu)
//                        Picker("Inches", selection: $selectedInches) {
//                            ForEach(heightInchesArray, id: \.self) { inches in
//                                Text("\(inches) in").tag(inches)
//                            }
//                        }
//                        .labelsHidden()
//                        .pickerStyle(.menu)
//                    }
//                    Picker("Chest Width", selection: $selectedChestWidth) {
//                        ForEach(chestWidthsArray, id: \.self) { chestWidth in
//                            Text("\(chestWidth) in").tag(chestWidth)
//                        }
//                    }
//                    .pickerStyle(.menu)
//                    Picker("Upper Arm Length", selection: $selectedUpperArmLength) {
//                        ForEach(upperArmLengthsArray, id: \.self) { upperArmLength in
//                            Text("\(upperArmLength) in").tag(upperArmLength)
//                        }
//                    }
//                    .pickerStyle(.menu)
//                    Picker("Forearm Length", selection: $selectedForearmLength) {
//                        ForEach(forearmLengthsArray, id: \.self) { forearmLength in
//                            Text("\(forearmLength) in").tag(forearmLength)
//                        }
//                    }
//                    .pickerStyle(.menu)
//                }
                Section(
                    header: Text("Preferences")
                ) {
                    HStack {
                        Image(systemName: "bell")
                        NavigationLink("Notifications") {
                            SwiftUI.Form(content: {
                                Toggle("Enable All Notifications", isOn: $allNotificationsEnabled)
                                Toggle("Enable Workout Notifications", isOn: $workoutNotificationsEnabled)
                                Toggle("Enable Pet Notifications", isOn: $petNotificationsEnabled)
                            })
                            .navigationTitle("Notifications")
                            .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
                Button("Logout", systemImage: "rectangle.portrait.and.arrow.right") {
                    // Implement logout button functionality
                    showingLogoutConfirmation = true
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert("Confirm Logout", isPresented: $showingLogoutConfirmation) {
            Button("Yes", role: .destructive) {
                // Clear AppStorage variables here
                email = ""
                firstName = ""
                lastName = ""
                userID = ""
            }
            Button("No", role: .cancel) {}
        }
        message: {
            Text("Are you sure you want to logout?")
        }
    }
}

#Preview {
    SettingsPageView()
}
