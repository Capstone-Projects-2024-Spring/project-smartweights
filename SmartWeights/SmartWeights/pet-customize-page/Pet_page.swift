//
//  Pet-page.swift
//  SmartWeights
//
//  Created by par chea on 2/21/24.
//

import SwiftUI

struct Pet_page: View {
    
    @State private var showShop = false
    @State private var showInventory = false
    @State private var showCustomize = false
    
    // Sample progress values
    @State private var HealthBar: Float = 0.25
    @State private var levelProgress: Float = 0.55
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pet Name")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 40, alignment: .center)
                
                HStack {
                    HamburgerMenu(
                        navigateToShop: { self.showShop = true },
                        navigateToInventory: { self.showInventory = true },
                        navigateToCustomize: { self.showCustomize = true }
                    )
                    Spacer() // Fills the remaining space to keep the menu aligned left
                }
                Spacer()
                
                
                // Custom Image in the center of the screen
                Image("Panda") // Replace "customPetImage" with the name of your image asset
                    .resizable()
                    .scaledToFit()
                    .frame(width: 450, height: 400, alignment: .center) // Adjust the size as needed
    
                
                // Custom Health Progress Bar
                CustomProgressView(value: HealthBar, maxValue: 1.0, label: "Health", displayMode: .percentage, foregroundColor: .green, backgroundColor: .gray)
                    .frame(height: 20)
                    .padding()
                
                // Custom Level Progress Bar
                CustomProgressView(value: levelProgress, maxValue: 5000, label: "Level", displayMode: .rawValue, foregroundColor: .blue, backgroundColor: .gray)
                    .frame(height: 20)
                    .padding()
                Spacer()
            }
            
            
            .background(Color.black)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            
            // Navigation Links
            .background(NavigationLink(destination: PetStore(), isActive: $showShop) { EmptyView() })
            .background(NavigationLink(destination: InventoryView(), isActive: $showInventory) { EmptyView() })
            .background(NavigationLink(destination: CustomizeView(), isActive: $showCustomize) { EmptyView() })
        }
    }
}



// Testing Purpose for the Hamburger menu
struct InventoryView: View {
    var body: some View {
        Text("Inventory")
            .font(.title)
    }
}

struct CustomizeView: View {
    var body: some View {
        Text("Customize")
            .font(.title)
    }
}




struct Pet_page_Previews: PreviewProvider {
    static var previews: some View {
        Pet_page()
    }
}





