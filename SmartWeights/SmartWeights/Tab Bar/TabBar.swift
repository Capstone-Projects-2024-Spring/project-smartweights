//
//  TabBar.swift
//  SmartWeights
//
//  Created by Dillon Shi on 3/23/24.
//

import SwiftUI

/// An enumeration representing the tab categories in the tab bar.
enum Tab: String, CaseIterable {
    case home = "house"
    case pet = "pawprint"
    case workout = "dumbbell"
    case achievements = "target"
    case profile = "person" // alt: case more = "ellipsis"
    
    /// Function getView() returns the tab's associated view.
    func getView(tabBar: TabBar) -> some View {
        switch self {
        case .home:
            return AnyView(Homepage(tabBar: tabBar))
        case .pet:
            return AnyView(Pet_Page())
        case .workout:
            return AnyView(WorkoutMainPage())
        case .achievements:
            return AnyView(ChallengesTab())
        case .profile:
            return AnyView(MorePageView())
        }
    }
}

/// Struct TabBar implements the Tab enumeration and TabView to create a navigable tab bar.
struct TabBar: View {
    @State private var selectedTab: Tab = .home
    
    func changeTab(to tab: Tab) {
        self.selectedTab = tab
    }
    
    var body: some View {
        TabView (selection: $selectedTab) {
            ForEach(Tab.allCases, id: \.self) { tab in
                tab.getView(tabBar: self)
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
