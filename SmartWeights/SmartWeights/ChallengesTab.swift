//
//  ChallengesTab.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/16/24.
//

import SwiftUI
import GameKit

struct ChallengesTab: View {
    @ObservedObject var challengesViewModel = ChallengesViewModel()
    
    var body: some View {
        NavigationView {
            ChallengesList(challenges: challengesViewModel.challenges, fetchGameCenterProgress: fetchGameCenterProgress)
                .navigationBarTitle("Achievements", displayMode: .inline)
                .preferredColorScheme(.light) // force light mode
        }
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

class Challenge: Identifiable, ObservableObject {
    var id = UUID()
    var title: String
    var description: String
    var image: Image // added for custom images
    var achievementIdentifier: String
    @Published var currentProgress: Int
    @Published var isCompleted: Bool
    
    init(title: String, description: String, image: Image, achievementIdentifier: String, currentProgress: Int, isCompleted: Bool) {
        self.title = title
        self.description = description
        self.image = image
        self.achievementIdentifier = achievementIdentifier
        self.currentProgress = currentProgress
        self.isCompleted = isCompleted
    }
}

struct ChallengesList: View {
    @State private var selectedTab = 0
    var challenges: [Challenge]
    var fetchGameCenterProgress: () -> Void
    @State private var updateListKey = false // Added state to force update

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Picker(selection: $selectedTab, label: Text("Select a tab")) {
                    Text("In Progress").tag(0)
                    Text("Completed").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
                
                Button(action: refreshList) {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 5)  // Provide some spacing between buttons
                
                Button(action: {
                    GameCenterManager.shared.showGameCenterAchievements()
                }) {
                    Image("GameCenterIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        .padding(1)
                        .background(Color.white)
                }
                Spacer()
            }
            .padding(.horizontal)

            List(challenges.filter { selectedTab == 0 ? !$0.isCompleted : $0.isCompleted }) { challenge in
                VStack {
                    HStack {
                        challenge.image // display image for each challenge
                            .resizable()
                            .frame(width: 60, height: 60) // can change size if needed
                            .foregroundColor(.yellow)
                            .padding(.trailing, 8)
                        VStack(alignment: .leading) {
                            Text(challenge.title)
                                .font(.headline)
                            Text(challenge.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    ProgressView(value: Double(challenge.currentProgress), total: 100)
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(.blue) // Customizing the color of the progress bar
                }
            }
            .id(updateListKey) // Use the state key to force the list to re-render
        }
        .onAppear(perform: refreshList)
    }
    
    func refreshList() {
        fetchGameCenterProgress()
        updateListKey.toggle() // Toggle the key to force the list to update
    }
}

#Preview {
    ChallengesTab()
}

