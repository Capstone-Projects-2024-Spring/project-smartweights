//
//  Pet-page.swift
//  SmartWeights
//
//  Created by par chea on 2/21/24.
//

import SwiftUI

/// Represents the main page where the user interacts with their virtual pet.
struct Pet_page: View {
    @State private var showShop = false
    @State private var showInventory = false
    @State private var showCustomize = false
    @State private var healthBar: Float = 0.25
    @State private var levelProgress: Float = 0.55
    @State private var showFoodSelection = false
    @State private var selectedFoodIndex = 0 // Index of the selected food item
    @State private var foodItems = [
        FoodItem(name: "Orange", quantity: 5, imageName: "orange"),
        FoodItem(name: "Apple", quantity: 3, imageName: "apple"),
        FoodItem(name: "Juice", quantity: 10, imageName: "juice")
    ]
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                petNameHeader()
                Hamburger_Food_Menu()
                petImage()
                    .padding(.bottom, -30) // Reduce the bottom padding to push content up
                healthAndLevelProgressViews()
                    .padding(.top, -20) // Reduce the top padding to move it closer to the above content
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .background(NavigationLink(destination: PetStore(), isActive: $showShop) { EmptyView() })
            .background(NavigationLink(destination: InventoryView(), isActive: $showInventory) { EmptyView() })
            .background(NavigationLink(destination: CustomizeView(), isActive: $showCustomize) { EmptyView() })
        }
    }
    
    /// Header view displaying the pet's name.
    private func petNameHeader() -> some View {
        Text("Pet Name")
            .font(.system(size: 45))
            .bold()
            .frame(maxWidth: .infinity, minHeight: 40, alignment: .center)
            .padding()
    }
    
    /// Displays the menu and food selection buttons.
    private func Hamburger_Food_Menu() -> some View {
        HStack {
            HamburgerMenu(
                navigateToShop: { self.showShop = true },
                navigateToInventory: { self.showInventory = true },
                navigateToCustomize: { self.showCustomize = true }
            )
            
            Spacer()
            
            changeFoodButton()
            useFoodButton()
        }
        .padding(.horizontal)
        
    }
    
    /// Button to change the selected food.
    private func changeFoodButton() -> some View {
        Button(action: {
            self.showFoodSelection.toggle()
        }) {
            HStack {
                Image(systemName: "leaf.arrow.circlepath")
                    .font(.system(size: 35))
                Text("Change Food")
                    .bold()
                    .font(.system(size: 18))
            }
            .padding()
        }
        .sheet(isPresented: $showFoodSelection) {
            FoodSelectionView(foodItems: $foodItems, selectedFoodIndex: $selectedFoodIndex)
        }
    }
    
    /// Button for using the selected food to increase pet's health and display the food image.
    private func useFoodButton() -> some View {
        let selectedFood = foodItems[selectedFoodIndex]
        return Button(action: {
            handleFoodUse(selectedFoodIndex: selectedFoodIndex)
        }) {
            HStack {
                Image(selectedFood.imageName) // Dynamic image based on the selected food.
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 100)
                Text("\(selectedFood.quantity)")
                    .font(.system(size: 35))
                    .bold()
                    .foregroundColor(.blue)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    /// Handles the logic when the user decides to use the selected food.
    private func handleFoodUse(selectedFoodIndex: Int) {
        guard selectedFoodIndex < foodItems.count else { return }
        var foodItem = foodItems[selectedFoodIndex]
        
        if healthBar >= 1.0 {
            showAlert(title: "Max Health Reached", message: "Your pet is already at maximum health.")
        } else if foodItem.quantity > 0 {
            increaseHealth(by: 0.05)
            foodItem.quantity -= 1 // Update the quantity
            foodItems[selectedFoodIndex] = foodItem // Save the updated item back to the array
        } else {
            showAlert(title: "Insufficient \(foodItem.name)", message: "You don't have enough \(foodItem.name).")
        }
    }
    
    /// Increases the health of the pet.
    private func increaseHealth(by amount: Float) {
        withAnimation {
            healthBar = min(healthBar + amount, 1.0)
        }
    }
    
    
    /// Shows an alert with a title and message.
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    /// Displays the pet's image.
    private func petImage() -> some View {
        Image("Panda")
            .resizable()
            .scaledToFit()
            .frame(width: 400, height: 400, alignment: .center)
    }
    
    /// Displays health and level progress views.
    private func healthAndLevelProgressViews() -> some View {
        VStack {
            CustomProgressView(value: healthBar, maxValue: 1.0, label: "Health", displayMode: .percentage, foregroundColor: .green, backgroundColor: .gray)
                .frame(height: 20)
                .padding()
            
            
            CustomProgressView(value: levelProgress, maxValue: 5000, label: "Level", displayMode: .rawValue, foregroundColor: .blue, backgroundColor: .gray)
                .frame(height: 20)
                .padding()
        }
        
    }
}

/// Represents an inventory view.
struct InventoryView: View {
    var body: some View {
        Text("Inventory")
            .font(.title)
    }
}

/// Represents a customization view.
struct CustomizeView: View {
    var body: some View {
        Text("Customize")
            .font(.title)
    }
}

/// Model representing a food item.
struct FoodItem: Identifiable {
    var id = UUID()
    var name: String
    var quantity: Int
    var imageName: String
}

/// View for selecting food for the pet.
struct FoodSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var foodItems: [FoodItem]
    @Binding var selectedFoodIndex: Int
    
    var body: some View {
        List(foodItems.indices, id: \.self) { index in
            Button(action: {
                self.selectedFoodIndex = index
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text(self.foodItems[index].name)
                    Spacer()
                    Text("Quantity: \(self.foodItems[index].quantity)")
                }
            }
        }
    }
}

struct Pet_page_Previews: PreviewProvider {
    static var previews: some View {
        Pet_page()
    }
}

