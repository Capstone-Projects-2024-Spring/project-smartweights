//
//  SettingsPageView.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/29/24.
//

import SwiftUI

struct SettingsPageView: View {
    @State private var notificationsEnabled = false
    @State private var darkModeEnabled = false
    @State private var useSystemSettingsEnabled = false
    
    var body: some View {
        NavigationStack {
            Form {
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
                Section(
                    header: Text("Preferences"),
                    footer: Text("System settings will override dark mode and use the current device's theme")
                ) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Language")
                    }
                    HStack {
                        Image(systemName: "bell")
                        Toggle(isOn: $notificationsEnabled, label: {
                            Text("Notifications")
                        })
                    }
                    HStack {
                        Image(systemName: "moon")
                        Toggle(isOn: $darkModeEnabled, label: {
                            Text("Dark Mode")
                        })
                    }
                    HStack {
                        Image(systemName: "gearshape")
                        Toggle(isOn: $useSystemSettingsEnabled, label: {
                            Text("Use System Settings")
                        })
                    }
                }
                Button("Logout", systemImage: "rectangle.portrait.and.arrow.right") {
                    // Implement logout button functionality
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back", systemImage: "arrowshape.backward.fill") {
                        // Implement back button functionality
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsPageView()
}
