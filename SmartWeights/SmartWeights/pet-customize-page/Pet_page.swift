//
//  Pet-page.swift
//  SmartWeights
//
//  Created by par chea on 2/21/24.
//

import SwiftUI


struct Pet_Page: View {
    @StateObject private var viewModel = PetPageFunction() // ViewModel integration
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pet Name")
                    .font(.system(size: 45))
                    .bold()
                    .frame(maxWidth: .infinity, minHeight: 40, alignment: .center)
                
                HStack {
                    HamburgerMenu(
                        navigateToShop: { viewModel.showShop = true },
                        navigateToInventory: { viewModel.showInventory = true },
                        navigateToCustomize: { viewModel.showCustomize = true }
                    )
                    Spacer()
                    
                    Button(action: {
                        viewModel.showFoodSelection.toggle()
                    }) {
                        HStack {
                            Image(systemName: "leaf.arrow.circlepath")
                                .font(.system(size: 35))
                            Text("Change Food")
                                .bold()
                                .font(.system(size: 20))
                                .frame(width: 130, height: 50)
                        }
                        .padding()
                    }
                    .accessibilityIdentifier("ChangeFoodButton")
                    .sheet(isPresented: $viewModel.showFoodSelection) {
                        FoodSelectionView(foodItems: $viewModel.foodItems, selectedFoodIndex: $viewModel.selectedFoodIndex)
                    }
                    
                    if viewModel.foodItems.indices.contains(viewModel.selectedFoodIndex) {
                        let selectedFood = viewModel.foodItems[viewModel.selectedFoodIndex]
                        Button(action: {
                            viewModel.handleFoodUse(selectedFoodIndex: viewModel.selectedFoodIndex)
                        }) {
                            VStack {
                                Image(selectedFood.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                Text("\(selectedFood.quantity)")
                                    .font(.system(size: 25))
                                    .bold()
                                    .foregroundColor(.blue)
                                    .minimumScaleFactor(0.50)
                                    .padding(.top, -15)
                                    .frame(width: 75,height: 25)
                            }
                        }
                        .accessibilityIdentifier("UseFoodButton")
                    }
                    
                }
                .padding(.horizontal, 25)
                
                Image("Panda")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 450, alignment: .center)
                    .padding(.bottom, -30)
                
                VStack {
                    CustomProgressView(value: viewModel.healthBar, maxValue: 1.0, label: "Health", displayMode: .percentage, foregroundColor: .green, backgroundColor: .gray)
                        .frame(height: 20)
                        .padding()
                    
                    CustomProgressView(value: viewModel.levelProgress, maxValue: 5000, label: "Level", displayMode: .rawValue, foregroundColor: .blue, backgroundColor: .gray)
                        .frame(height: 20)
                        .padding()
                }
                .padding(.top, -20)
                Spacer()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(viewModel.alertTitle),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .background(NavigationLink(destination: PetStore(), isActive: $viewModel.showShop) { EmptyView() })
            .background(NavigationLink(destination: InventoryView(), isActive: $viewModel.showInventory) { EmptyView() })
            .background(NavigationLink(destination: CustomizeView(), isActive: $viewModel.showCustomize) { EmptyView() })
        }
    }
}


struct FoodItem: Identifiable {
    var id = UUID()
    var name: String
    var quantity: Int
    var imageName: String
}

class PetPageFunction: ObservableObject {
    @Published var showShop = false
    @Published var showInventory = false
    @Published var showCustomize = false
    @Published var healthBar: Float = 0.25
    @Published var levelProgress: Float = 0.55
    @Published var showFoodSelection = false
    @Published var selectedFoodIndex = 0
    @Published var foodItems = [
        FoodItem(name: "Orange", quantity: 10, imageName: "orange"),
        FoodItem(name: "Apple", quantity: 10, imageName: "apple"),
        FoodItem(name: "Juice", quantity: 10, imageName: "juice")
    ]
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    func handleFoodUse(selectedFoodIndex: Int) {
        guard selectedFoodIndex < foodItems.count else { return }
        var foodItem = foodItems[selectedFoodIndex]
        
        if healthBar >= 1.0 {
            showAlert(title: "Max Health Reached", message: "Your pet is already at maximum health.")
        } else if foodItem.quantity > 0 {
            // Determine health increase amount
            let healthIncrease: Float = foodItem.name == "Orange" ? 0.2 : 0.1 // Orange increases by 0.2, others by 0.1
            increaseHealth(by: healthIncrease)
            
            foodItem.quantity -= 1
            foodItems[selectedFoodIndex] = foodItem
        } else {
            showAlert(title: "Insufficient \(foodItem.name)", message: "You don't have enough \(foodItem.name).")
        }
    }
    
    func increaseHealth(by amount: Float) {
        withAnimation {
            healthBar = min(healthBar + amount, 1.0)
        }
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

// FoodSelectionView definition
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
                    Image(foodItems[index].imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text(foodItems[index].name)
                    Spacer()
                    Text("Quantity: \(foodItems[index].quantity)")
                }
            }
            .accessibilityIdentifier("FoodItemButton_\(foodItems[index].name)") // Add this line
        }
    }
}

/// A view representing a hamburger menu with options to navigate to different pages.
struct HamburgerMenu: View {
    var navigateToShop: () -> Void
    var navigateToInventory: () -> Void
    var navigateToCustomize: () -> Void
    
    var body: some View {
        Menu {
            Button("Shop", action: navigateToShop)
                .accessibilityIdentifier("Shop")
            Button("Inventory", action: navigateToInventory)
                .accessibilityIdentifier("Inventory")
            Button("Customize", action: navigateToCustomize)
                .accessibilityIdentifier("Customize")
        } label: {
            Label {
                Text("")
            } icon: {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding()
                    .background(Circle().fill(Color.gray))
                    .shadow(radius: 5)
            }
            .accessibilityIdentifier("HamburgerMenuButton")
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


struct PetPage_Previews: PreviewProvider {
    static var previews: some View {
        Pet_Page()
    }
}

