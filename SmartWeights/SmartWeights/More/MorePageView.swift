//
//  MorePageView.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/23/24.
//

import SwiftUI

struct MorePageView: View {
    let profile = Profile(firstName: "First", lastName: "Last", level: 1)
    let achievements = [
        Achievement(title: "Achievement 1", description: "", img: "trophy.circle"),
        Achievement(title: "Achievement 2", description: "", img: "trophy.circle"),
        Achievement(title: "Achievement 3", description: "", img: "trophy.circle"),
        Achievement(title: "Achievement 4", description: "", img: "trophy.circle"),
        Achievement(title: "Achievement 5", description: "", img: "trophy.circle"),
        Achievement(title: "Achievement 6", description: "", img: "trophy.circle")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(profile.firstName) \(profile.lastName)")
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(
                        width: 100,
                        height: 100
                    )
                Text("Lv. \(profile.level)")
                ProgressView(value: 0.5)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(
                        width: 100
                    )
                Divider()
                VStack {
                    Text("Achievements")
                        .font(.title3)
                        .fontWeight(.medium)
                    ScrollView(.horizontal) {
                        HStack {
                            Spacer()
                            ForEach(achievements) { achievement in
                                ZStack {
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                        .fill(Color.green)
                                        .frame(width: 120, height: 140)
                                    VStack(spacing: 20) {
                                        Image(systemName: achievement.img)
                                            .resizable()
                                            .frame(
                                                width: 50,
                                                height: 50
                                            )
                                        VStack {
                                            ForEach(achievement.title.split(separator: " "), id: \.self) { word in
                                                            Text(String(word))
                                                                .font(.caption)
                                                        }
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }
                Divider()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 300,
                        height: 300
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Screenshot", systemImage: "camera") {
                        
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings", systemImage: "gearshape") {
                        
                    }
                }
            }
        }
    }
}

struct Profile: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var level: Int
}

struct Achievement: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var img: String    
}

#Preview {
    MorePageView()
}
