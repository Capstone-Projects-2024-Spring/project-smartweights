//
//  ChallengesTab.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/16/24.
//

import SwiftUI

struct AchievementsPageView: View {
    @ObservedObject var achievementsViewModel = AchievementsViewModel() 
    
    var body: some View {
        NavigationView {
            AchievementsList(achievements: achievementsViewModel.achievements)
                .navigationBarTitle("Achievements", displayMode: .inline)
        }
    }
}

struct AchievementRow: View {
    @ObservedObject var achievementsViewModel = AchievementsViewModel()
    var achievement: Achievement
    
    var body: some View {
        VStack {
            HStack {
                achievement.image // display image for each challenge
                    .resizable()
                    .frame(width: 50, height: 50) // can change size if needed
                //Image(systemName: "figure.strengthtraining.traditional")
                    .foregroundColor(.yellow)
                    .padding(.trailing, 8)
                VStack(alignment: .leading) {
                    Text(achievement.title)
                        .font(.headline)
                    Text(achievement.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(achievement.currentProgress)/\(achievement.progressGoal)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Text("+ \(achievement.reward)")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
            }
            HStack {
                ProgressView(value: achievement.progressPercent)
                    .progressViewStyle(LinearProgressViewStyle())
                if (achievement.isComplete && !achievement.isClaimed) {
                    Button(action: {
                        print("\(achievement.id), \(achievement.title) has been claimed")
                        achievementsViewModel.claimAchievement(id: achievement.id)
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundStyle(Color.green)
                                .frame(width: 50, height: 25)
                            Text("Claim")
                        }
                    })
                }
            }
        }
    }
}

struct AchievementsList: View {
    @State private var selectedTab = 0
    var achievements: [Achievement]
    
    var filteredAchievements: [Achievement] {
        switch selectedTab {
        case 0:
            return achievements
        case 1:
            return achievements.filter { !$0.isComplete }
        case 2:
            return achievements.filter { $0.isComplete && $0.isClaimed}
        default:
            return achievements
        }
    }
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("Select a tab")) {
                Text("All").tag(0)
                Text("In Progress").tag(1)
                Text("Completed").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            List(filteredAchievements) { achievement in
                AchievementRow(achievement: achievement)
            }
        }
    }
}

#Preview {
    AchievementsPageView()
}
