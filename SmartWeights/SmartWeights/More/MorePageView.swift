//
//  MorePageView.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/23/24.
//

import SwiftUI

struct MorePageView: View {
    @ObservedObject var achievementsViewModel = AchievementsViewModel()
    let profile = Profile(firstName: "First", lastName: "Last", level: 1)
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(achievementsViewModel.userDBManager.user?.firstName ?? "First") \(achievementsViewModel.userDBManager.user?.lastName ?? "Last")")
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
                Text("\(achievementsViewModel.balance) Points")
                Divider()
                VStack {
                    Text("Achievements")
                        .font(.title3)
                        .fontWeight(.medium)
                    ScrollView(.horizontal) {
                        HStack {
                            Spacer()
                            ForEach(achievementsViewModel.achievements) { achievement in
                                if (achievement.isComplete) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(Color.green)
                                            .frame(width: 120, height: 120)
                                        VStack {
                                            achievement.image
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Text(achievement.title)
                                                .font(.headline)
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }
                Divider()
                Image("dog")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 250,
                        height: 250
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Screenshot", systemImage: "camera") {
                        
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsPageView()) {
                        Image(systemName: "gearshape")
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

#Preview {
    MorePageView()
}
