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
                /*
                // XP Increase Button for testing purpose
                Button(action: {
                    // Assuming you want to increase XP by a fixed amount, e.g., 5
                    viewModel.increaseXP(by: 50)
                    
                }) {
                    Text("Increase XP")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("IncreaseXPButton")
                .padding(.top, 10) // Add some padding on top to separate it from the pet name
                
                */
                HStack {
                    HamburgerMenu(
                        navigateToShop: { viewModel.showShop = true },
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
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
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
                
                Image("dog")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 400, alignment: .center)
                    .padding(.bottom, 0)
                
                VStack {
                    CustomProgressView(value: viewModel.healthBar, maxValue: 100, label: "Health", displayMode: .percentage, foregroundColor: .green, backgroundColor: .gray)
                        .frame(height: 20)
                        .padding()
                    
                    // Display Current Level
                    Text("Level \(viewModel.currentLevel)")
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 10)
                    CustomProgressView(value: viewModel.levelProgress, maxValue: 100, label: "Level", displayMode: .rawValue, foregroundColor: .blue, backgroundColor: .gray)
                        .frame(height: 20)
                        
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
            .background(NavigationLink(destination: Customize_page(), isActive: $viewModel.showCustomize) { EmptyView() })
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
    @Published var showCustomize = false
    @Published var healthBar: Int = 50
    @Published var levelProgress: Int = 0
    @Published var currentLevel = 1
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
        
        if healthBar >= 100 {
            showAlert(title: "Max Health Reached", message: "Your pet is already at maximum health.")
        } else if foodItem.quantity > 0 {
            // Determine health increase amount
            let healthIncrease: Int = foodItem.name == "Orange" ? 20 : 10 // Orange increases by 0.2, others by 0.1
            increaseHealth(by: healthIncrease)
            
            foodItem.quantity -= 1
            foodItems[selectedFoodIndex] = foodItem
        } else {
            showAlert(title: "Insufficient \(foodItem.name)", message: "You don't have enough \(foodItem.name).")
        }
    }
    
    func increaseHealth(by amount: Int) {
        withAnimation {
            healthBar = min(healthBar + amount, 100) // Assuming max health is 100
        }
    }
    
    func increaseXP(by value: Int) {
        // Calculate new progress to see if it exceeds 100
        let newProgress = levelProgress + value
        
        // Check if current level is less than 10
        if currentLevel < 10 {
            // If adding XP will exceed 100, level up and adjust XP
            if newProgress >= 100 {
                withAnimation {
                    // Increase level by 1
                    currentLevel += 1
                    // Reset levelProgress to 0 or to the remainder if exceeding 100
                    // This carries over excess XP to the next level
                    levelProgress = newProgress % 100
                }
            } else {
                withAnimation {
                    // If not exceeding 100, just add the XP to the current progress
                    levelProgress = newProgress
                }
            }
        } else {
            // For level 10, allow XP gain up to 100 but prevent level increase
            if newProgress <= 100 {
                withAnimation {
                    levelProgress = newProgress
                }
            } else {
                // If XP would exceed 100, either cap at 100 or reset; adjust as needed
                withAnimation {
                    levelProgress = 100 // Cap XP at 100 for level 10
                }
            }
        }
        // Ensure current level doesn't exceed 10
        if currentLevel > 10 {
            currentLevel = 10 // Cap the level at 10
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
    var navigateToCustomize: () -> Void
    
    var body: some View {
        Menu {
            Button("Shop", action: navigateToShop)
                .accessibilityIdentifier("Shop")
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

