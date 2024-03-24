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
    case more = "ellipsis"
    
    /// Function getView() returns the tab's associated view
    func getView() -> some View {
        switch self {
        case .home:
            return AnyView(Homepage())
        case .pet:
            return AnyView(Pet_Page())
        case .workout:
            return AnyView(WorkoutMainPage())
        case .profile:
            return AnyView(SettingsPageView())
        case .more:
            return AnyView(MorePageView())
        }
    }
}

struct TabBar: View {
    var body: some View {
        HStack {
            ForEach(Tab1.allCases, id: \.self) { tab in
                Spacer()
                VStack {
                    Image(systemName: tab.rawValue)
                    Text(String(describing: tab))
                }
                Spacer()
            }
        }
    }
}

#Preview {
    TabBar()
}
