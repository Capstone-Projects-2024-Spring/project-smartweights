//
//  ChallengesTab.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/16/24.
//

import SwiftUI

struct ChallengesTab: View {
    let challenges = [
        Challenge(title: "Challenge 1", description: "Description for Challenge 1.", currentProgress: 7, progressGoal: 10, reward: "+ 1000 XP"),
        Challenge(title: "Challenge 2", description: "Description for Challenge 2.", currentProgress: 3, progressGoal: 10, reward: "+ 200 SP"),
        Challenge(title: "Challenge 3", description: "Description for Challenge 3.", currentProgress: 5, progressGoal: 10, reward: "+ 100 XP"),
        Challenge(title: "Challenge 4", description: "Description for Challenge 4.", currentProgress: 2, progressGoal: 10, reward: "+ 500 XP"),
        Challenge(title: "Challenge 5", description: "Description for Challenge 5.", currentProgress: 8, progressGoal: 10, reward: "+ 500 SP"),
        Challenge(title: "Challenge 6", description: "Description for Challenge 6.", currentProgress: 1, progressGoal: 10, reward: "+ 100 XP")
    ]
    
    var body: some View {
        NavigationView {
            ChallengesList(challenges: challenges)
                .navigationBarTitle("Challenges", displayMode: .inline)
        }
    }
}

struct Challenge: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var currentProgress: Int
    var progressGoal: Int
    var reward: String
    
    var progressPercent: Double {
        return Double(currentProgress) / Double(progressGoal)
    }
}

struct ChallengeRow: View {
    var challenge: Challenge
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "figure.strengthtraining.traditional")
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
                VStack(alignment: .trailing) {
                    Text("\(challenge.currentProgress)/\(challenge.progressGoal)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Text(challenge.reward)
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
            }
            ProgressView(value: challenge.progressPercent)
                .progressViewStyle(LinearProgressViewStyle())
        }
    }
}

struct ChallengesList: View {
    @State private var selectedTab = 0
    var challenges: [Challenge]
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("Select a tab")) {
                Text("In Progress").tag(0)
                Text("Completed").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            List(challenges) { challenge in
                ChallengeRow(challenge: challenge)
            }
        }
    }
}

#Preview {
    ChallengesTab()
}
