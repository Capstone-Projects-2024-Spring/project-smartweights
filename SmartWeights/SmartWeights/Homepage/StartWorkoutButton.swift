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
                                .foregroundStyle(Color.africanViolet)
                        }
                        Text(currentWorkout)
                            .foregroundStyle(Color.lightGray)
                            .font(.subheadline)
                    }
                    .padding()
                    Spacer()
                    Image(systemName: "photo")
                        .foregroundStyle(Color.lightGray)
                        .padding()
                }
                .foregroundStyle(.white)
            }
            .background(Color.darkGray)
            .cornerRadius(12)
            .padding()
        }
    }
}

#Preview {
    StartWorkoutButton(tabBar: TabBar())
}
