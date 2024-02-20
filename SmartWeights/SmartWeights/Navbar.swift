//
//  Navbar.swift
//  SmartWeights
//
//  Created by Dillon Shi on 2/19/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case message
    case person
    case leaf
    case gearshape
}

struct Navbar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
    }
}

#Preview {
    Navbar(selectedTab: .constant(.house))
}
