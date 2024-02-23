//
//  HamburgerMenu.swift
//  SmartWeights
//
//  Created by par chea on 2/23/24.
//

import SwiftUI

struct HamburgerMenu: View {
    var navigateToShop: () -> Void
    var navigateToInventory: () -> Void
    var navigateToCustomize: () -> Void
    
    var body: some View {
        Menu {
            Button(action: navigateToShop) {
                Label("Shop", systemImage: "cart")
            }
            Button(action: navigateToInventory) {
                Label("Inventory", systemImage: "list.bullet")
            }
            Button(action: navigateToCustomize) {
                Label("Customize", systemImage: "paintbrush")
            }
        
        } label: {
            Image(systemName: "line.horizontal.3")
                .foregroundColor(.blue)
                .font(.title)
                .padding()
                .background(Circle().fill(Color.gray))
                .shadow(radius: 5)
        }
    }
}
