//
//  MorePageView.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/23/24.
//

import SwiftUI
import UIKit

struct MorePageView: View {
    
    @ObservedObject var viewModel = MorePageViewModel()
    @ObservedObject var backgroundItemDBManager = BackgroundItemDBManager()
    @ObservedObject var clothingItemDBManager = ClothingItemDBManager()
    @ObservedObject var petItemDBManager = PetItemDBManager()
    
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Spacer()
                            ForEach(viewModel.achievements) { achievement in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(achievement.isClaimed ? Color.green : Color.gray.opacity(0.5))
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
                ZStack{
                    ///Consider instead of calling the individual managers to get their actives, put inside PetPageViewModel. Depending on the solution to getting the refresh correctly
                    
                    Image(backgroundItemDBManager.activeBackground)
                        .resizable()
                        .frame(width: 250, height: 250)
                    Image(petItemDBManager.activePet)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    Image(clothingItemDBManager.activeClothing)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Screenshot", systemImage: "camera") {
                        
                        // CODE TO UPDATE "Sharing Companion" ACHIEVEMENT
                        GameCenterManager.shared.updateAchievement(identifier: "SmartWeights.Achievement.SharingCompanion", progressToAdd: 100.0)
                        viewModel.takeScreenshot()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsPageView()) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showingShareSheet, onDismiss: {
//            to reset the screenshot
            viewModel.screenshot = nil
        }) {
            if let screenshot = viewModel.screenshot {
                ShareSheetView(items: [screenshot])
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
