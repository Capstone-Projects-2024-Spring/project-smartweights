//
//  BarNavigation.swift
//  SmartWeights
//
//  Created by par chea on 2/21/24.
//

import SwiftUI

struct BarNavigation: View {
    @State private var selectedTab: Tab = .house

    var body: some View {
        VStack(spacing: 0) {
            // Use the selectedTab to determine which view to show
            switch selectedTab {
            case .house:
                Homepage().frame(maxWidth: .infinity, maxHeight: .infinity)
            case .message:
                PetStore().frame(maxWidth: .infinity, maxHeight: .infinity)
            case .person:
                PostWorkout().frame(maxWidth: .infinity, maxHeight: .infinity)
            case .leaf:
                Calendar().frame(maxWidth: .infinity, maxHeight: .infinity)
            case .gearshape:
                WorkoutGraph().frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            // The navbar at the bottom, ensuring it doesn't overlap the content
            Navbar(selectedTab: $selectedTab)
                .frame(height: 50) // Adjust this height as needed
        }
        .edgesIgnoringSafeArea(.bottom) // Ensure it fits full screen including the bottom edge
    }
}

#Preview {
    BarNavigation()
}
