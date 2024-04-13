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
    
    var body: some View {
        NavigationStack {
            SwiftUI.Form {
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
                // button for FitnessPlanPage
                NavigationLink(destination: FitnessPlanPage()) {
                    Text("Fitness Plan")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }
                            .padding()
                Section(header: Text("Body Measurements")) {
                    Picker("Weight", selection: $selectedWeight) {
                        ForEach(weightsArray, id: \.self) { weight in
                            Text("\(weight) lb").tag(weight)
                        }
                    }
                    .pickerStyle(.menu)
                    HStack {
                        Text("Height")
                        Spacer()
                        Picker("Feet", selection: $selectedFeet) {
                            ForEach(heightFeetArray, id: \.self) { feet in
                                Text("\(feet) ft").tag(feet)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.menu)
                        Picker("Inches", selection: $selectedInches) {
                            ForEach(heightInchesArray, id: \.self) { inches in
                                Text("\(inches) in").tag(inches)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.menu)
                    }
                    Picker("Chest Width", selection: $selectedChestWidth) {
                        ForEach(chestWidthsArray, id: \.self) { chestWidth in
                            Text("\(chestWidth) in").tag(chestWidth)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Upper Arm Length", selection: $selectedUpperArmLength) {
                        ForEach(upperArmLengthsArray, id: \.self) { upperArmLength in
                            Text("\(upperArmLength) in").tag(upperArmLength)
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Forearm Length", selection: $selectedForearmLength) {
                        ForEach(forearmLengthsArray, id: \.self) { forearmLength in
                            Text("\(forearmLength) in").tag(forearmLength)
                        }
                    }
                    .pickerStyle(.menu)
                }
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
                   /* HStack {
                        Image(systemName: "heart")
                        Toggle(isOn: $healthKitEnabled, label: {
                            Text("Enable HealthKit")
                        })
                         } */ 
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
