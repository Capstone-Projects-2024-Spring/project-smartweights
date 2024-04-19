//
//  MorePageView.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/23/24.
//

import SwiftUI
import UIKit

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
                        achievementsViewModel.takeScreenshot()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsPageView()) {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .sheet(isPresented: $achievementsViewModel.showingShareSheet, onDismiss: {
    //            to reset the screenshot
                achievementsViewModel.screenshot = nil
            }) {
                if let screenshot = achievementsViewModel.screenshot {
                    ShareSheetView(items: [screenshot])
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

struct ShareSheetView: UIViewControllerRepresentable {
    var items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    MorePageView()
}
