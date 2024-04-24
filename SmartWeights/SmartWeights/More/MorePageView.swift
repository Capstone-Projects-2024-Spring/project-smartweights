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
    @ObservedObject var challengesViewModel = ChallengesViewModel()
    @ObservedObject var backgroundItemDBManager = BackgroundItemDBManager.shared
    @ObservedObject var clothingItemDBManager = ClothingItemDBManager.shared
    @ObservedObject var petItemDBManager = PetItemDBManager.shared
    @State private var updateKey = false
    
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
                            ForEach(challengesViewModel.challenges) { challenge in
                                if (challenge.isCompleted) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(Color.green)
                                            .frame(width: 120, height: 120)
                                        VStack {
                                            challenge.image
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Text(challenge.title)
                                                .font(.headline)
                                        }
                                    }
                                }
                            }
                            .id(updateKey)
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
            .onAppear(perform: {
                refreshList()
            })
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
    
    func refreshList() {
        fetchGameCenterProgress()
        updateKey.toggle()
    }
    
    func fetchGameCenterProgress() {
        GameCenterManager.shared.fetchAllAchievementsProgress { progressDict, error in
            if let error = error {
                print("Error fetching achievements: \(error.localizedDescription)")
            } else if let progressDict = progressDict {
                DispatchQueue.main.async {
                    for i in self.challengesViewModel.challenges.indices {
                        if let percentComplete = progressDict[self.challengesViewModel.challenges[i].achievementIdentifier] {
                            // Update the current progress with the fetched percent complete directly
                            self.challengesViewModel.challenges[i].currentProgress = Int(percentComplete)
                            // Determine if the challenge is completed based on whether the percent complete is 100
                            self.challengesViewModel.challenges[i].isCompleted = percentComplete == 100.0
                        }
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
