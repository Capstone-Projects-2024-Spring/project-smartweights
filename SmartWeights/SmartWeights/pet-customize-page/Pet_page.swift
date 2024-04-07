//
//  Pet-page.swift
//  SmartWeights
//
//  Created by par chea on 2/21/24.
//

import SwiftUI


struct Pet_Page: View {
    @ObservedObject var viewModel = PetPageFunction()

    
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
                
                Image("Dog")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 400, alignment: .center)
                    .padding(.bottom, 0)
                
                VStack {
                    CustomProgressView(value: viewModel.healthBar, maxValue: 100, label: "Health", displayMode: .percentage, foregroundColor: .green, backgroundColor: .gray)
                        .frame(height: 20)
                        .padding()
                    
                    /*
                    // Display Current Level
                    Text("Level \(viewModel.currentLevel)")
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 10)
                     */
                    CustomProgressView(value: viewModel.userTotalXP, maxValue: 100, label: "Level", displayMode: .rawValue, foregroundColor: .blue, backgroundColor: .gray)
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
            .background(NavigationLink(destination: Customize_page(), isActive: $viewModel.showCustomize) { EmptyView() })
        }
    }
}


// FoodSelectionView definition
struct FoodSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var foodItems: [FoodItemModel]
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


