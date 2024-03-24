//
//  Navbar.swift
//  SmartWeights
//
//  Created by Dillon Shi on 2/19/24.
//  Created by par chea on 2/21/24.
//

import SwiftUI

/// An enumeration representing the different tabs in the navigation bar.
enum Tab: String, CaseIterable {
    // Names of SF Symbols
    case house
    case message
    case person
    case leaf
    case gearshape
}

/// A custom navigation bar view.
struct Navbar: View {
    @Binding var selectedTab: Tab // Paired with @State var in ContentView
    
    var body: some View {
        // Need to add some frame to VStack
        VStack {
            Spacer()
            HStack{
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: tab.rawValue)
                        .foregroundStyle(selectedTab == tab ? Color.charcoalGray : Color.stoneGray)
                        .font(.system(size: 25))
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .offset(y: selectedTab == tab ? -40 : 0) // Anyway to not hard-code values?
                        .background(Circle().frame(width:50, height: 50).opacity(selectedTab == tab ? 1.0 : 0.0)
                            .offset(y: selectedTab == tab ? -40: 0)
                            .frame(width: 65, height: 65)
                            .foregroundStyle(Color.africanViolet))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
                Spacer()
            }
            .frame(width: nil, height: 50)
            .background(Color.charcoalGray)
        }
        .edgesIgnoringSafeArea([.top, .bottom]) // Ignore safe area on sides only
    }
}

#Preview {
    Navbar(selectedTab: .constant(.house))
}
