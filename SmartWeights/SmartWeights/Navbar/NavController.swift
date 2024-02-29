//
//  BarNavigation.swift
//  SmartWeights
//
//  Created by par chea on 2/21/24.
//

import SwiftUI

/// A navigation controller that manages the navigation between different views in the SmartWeights app.
struct NavController: View {
    @State private var selectedTab: Tab = .house
    @StateObject var viewModel = WorkoutViewModel()
    
    
    var body: some View {
        ZStack {
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
                    WorkoutMainPage(viewModel: viewModel).frame(maxWidth: .infinity, maxHeight: .infinity)
                case .gearshape:
                    Pet_Page().frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            VStack {
                Spacer() // This pushes the navbar to the bottom
                Navbar(selectedTab: $selectedTab)
                    .frame(height: 50) // Adjust this height as needed
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom]) // Ignore safe area on sides only
    }
    
}


#Preview {
    NavController()
}
