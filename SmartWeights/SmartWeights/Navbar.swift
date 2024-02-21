//
//  Navbar.swift
//  SmartWeights
//
//  Created by Dillon Shi on 2/19/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    // Names of SF Symbols
    case house
    case message
    case person
    case leaf
    case gearshape
}

// Custom colors
extension Color {
    static let africanViolet = Color(red: 178/255, green: 132/255, blue: 190/255)
    static let hexA6A6A6 = Color(red: 166/255, green: 166/255, blue: 166/255)
    static let hex212121 = Color(red: 33/255, green: 33/255, blue: 33/255)
    static let hex121212 = Color(red: 18/255, green: 18/255, blue: 18/255)
}

struct Navbar: View {
    @Binding var selectedTab: Tab // Paired with @State var in ContentView
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .foregroundStyle(selectedTab == tab ? Color.africanViolet : Color.hexA6A6A6)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
                Spacer()
            }
            .frame(width: nil, height: 60)
            .background(Color.hex212121)
        }
    }
}

#Preview {
    Navbar(selectedTab: .constant(.house))
}
