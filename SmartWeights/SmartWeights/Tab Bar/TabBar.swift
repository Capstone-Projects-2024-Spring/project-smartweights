//
//  TabBar.swift
//  SmartWeights
//
//  Created by Dillon Shi on 3/23/24.
//

import SwiftUI

/// An enumeration representing the tab categories in the tab bar.
enum Tab1: String, CaseIterable {
    case home = "house"
    case pet = "pawprint"
    case workout = "dumbbell"
    case profile = "person"
    case settings = "gearshape" // alt: case more = "ellipsis"
    
    /// Function getView() returns the tab's associated view.
    func getView() -> some View {
        switch self {
        case .home:
            return AnyView(Homepage())
        case .pet:
            return AnyView(Pet_Page())
        case .workout:
            return AnyView(WorkoutMainPage())
        case .profile:
            return AnyView(MorePageView())
        case .settings:
            return AnyView(SettingsPageView())
        }
    }
}

/// Struct TabBar implements the Tab enumeration and TabView to create a navigable tab bar.
struct TabBar: View {
    @State private var selectedTab: Tab1 = .home
    
    var body: some View {
        TabView (selection: $selectedTab) {
            ForEach(Tab1.allCases, id: \.self) { tab in
                tab.getView()
                    .tabItem {
                        Label(String(describing: tab).capitalized, systemImage: tab.rawValue)
                    }
                    .tag(tab)
            }
        }
        .tint(.africanViolet)
    }
}

#Preview {
    TabBar()
}
