//
//  StartWorkoutButton.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/15/24.
//

import SwiftUI

struct StartWorkoutButton: View {
    
    let tabBar: TabBar
    
    var body: some View {
        Button { tabBar.changeTab(to: .workout) }
        label: {
            ZStack {
                HStack {
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Start Workout")
                                .font(.title2)
                            Image(systemName: "arrow.right")
                        }
                        .bold()
                        Text(currentWorkout)
                            .font(.subheadline)
                    }
                    .padding()
                    Spacer()
                    Image(systemName: "figure.strengthtraining.traditional")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                }
            }
            .foregroundStyle(.white)
            .background(Color.africanViolet)
                .cornerRadius(12)
            .padding()
        }
    }
}

#Preview {
    StartWorkoutButton(tabBar: TabBar(coreDataManager: CoreDataManager(container: PersistenceController.preview.container)))
}
