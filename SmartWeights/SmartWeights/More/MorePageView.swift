//
//  MorePageView.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/23/24.
//

import SwiftUI

struct MorePageView: View {
    @ObservedObject var viewModel = MorePageViewModel()
    let profile = Profile(firstName: "First", lastName: "Last", level: 1)
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(viewModel.userDBManager.user?.firstName ?? "First") \(viewModel.userDBManager.user?.lastName ?? "Last")")
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
                Text("\(viewModel.balance) Points")
                Divider()
                VStack {
                    Text("Achievements")
                        .font(.title3)
                        .fontWeight(.medium)
                    ScrollView(.horizontal) {
                        HStack {
                            Spacer()
                            ForEach(viewModel.achievements) { achievement in
                                ZStack {
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                        .fill(achievement.isClaimed ? Color.green : Color.gray)
                                        .frame(width: 120, height: 140)
                                        .onTapGesture {
                                            if (!achievement.isClaimed) {
                                                viewModel.claimAchievement(id: achievement.id)
                                            }
                                        }
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
                                            if (!achievement.isClaimed) {
                                                Text("Reward: \(achievement.reward)")
                                                    .bold()
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
                Image("Dog")
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
                        // CODE TO UPDATE "Sharing Companion" ACHIEVEMENT
                        GameCenterManager.shared.updateAchievement(identifier: "SmartWeights.Achievement.SharingCompanion", progress: 100.0)
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

struct Achievement: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var img: String
    var reward: Int
    var isClaimed: Bool = false
    
    mutating func claim() {
        isClaimed = true
    }
}

#Preview {
    MorePageView()
}
