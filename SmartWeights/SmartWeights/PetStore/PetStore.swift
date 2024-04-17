//
//  PetStore.swift
//  SmartWeights
//
//  Created by Jonathan Stanczak on 2/16/24.
//  Last modified: 3/23/24 1:30 PM

import Foundation
import SwiftUI

/// SellingItem struct that contains essential item attributes.
struct SellingItem: Identifiable {
    var id = Int() // universal identifier for item number
    var name: String
    var category: String
    var price: String
    var image: Image //  property for the image itself
    var description: String
    var isBought = false
}

/// Grid for displaying items.
private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

/// Display view for the Pet Store depending on available items and prices.
struct PetStore: View {
    @ObservedObject var viewModel = storeViewModel()
    @State private var showingDetail = false
    @State private var selectedItem: SellingItem?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Pet Store")
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                    Spacer()
                    HStack {
                        Image( "petcoin")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("\(viewModel.userCur)") // amount of money
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(.green)
                    }
                }
                .padding() // Add padding to the HStack
                
                HStack {
                    Button(action: {
                        viewModel.sortByPrice.toggle()
                    }) {
                        Text(viewModel.sortByPrice ? "Sort by Price" : "Sort by Name")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    .padding(.bottom, -10)
                    .padding(.top, -15)
                    Spacer() // Moves sort button to far left
                }
                .padding(.horizontal) // Moves sorting button off the "wall"
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.categories, id: \.self) { category in
                            Button(action: {
                                viewModel.selectedCategory = category
                            }) {
                                Text(category)
                                    .padding()
                                    .background(viewModel.selectedCategory == category ? Color.blue : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(25)
                                    .font(.system(size: 15))
                            }
                        }
                    }
                    .padding()
                }
                
                ScrollView {
                    LazyVGrid(columns: gridLayout, spacing: 10) {
                        ForEach(viewModel.sortItems(items: viewModel.items, sortByPrice: viewModel.sortByPrice).filter { $0.category == viewModel.selectedCategory }, id: \.id) { item in
                            Button(action: {
                                self.selectedItem = item
                            }) {
                                VStack {
                                    item.image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                    
                                    Text(item.name)
                                    // Displaying price with your existing logic...
                                }
                                .frame(width: 130, height: 175)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding([.leading, .trailing, .bottom])
                }
            }
            .sheet(item: $selectedItem) { item in
                ItemDetailView(item: item, viewModel: viewModel, userCur: viewModel.userCur)
            }
        }
    }
}

/// Display view for previewing and purchasing and item.
struct ItemDetailView: View {
    var item: SellingItem
    @ObservedObject var viewModel: storeViewModel // Add view model reference
    @State private var canPurchase = false
    let userCur: Int // Add user currency variable
    
    var body: some View {
        VStack {
            VStack { // handles preview logic, currently will default dog if showing background or outfit
                if(item.category == "Foods") {
                    item.image
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 50)
                } else if(item.category == "Pets") {
                    item.image
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 50)
                } else if(item.category == "Outfits" || item.category == "Backgrounds") {
                    ZStack { // if item is jetpack or background, show behind pet
                        if(item.name == "Jetpack" || item.category == "Backgrounds") {
                            if(item.category == "Backgrounds") {
                                item.image
                                    .resizable()
                                    .scaledToFit() // change size of background later
                                    .padding(.bottom, 50)
                            } else { // jetpack
                                item.image
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.bottom, 50)
                                
                            }
                            Image("dog") // Display pet image
                                .resizable()
                                .scaledToFit()
                                .padding(.bottom, 50)
                            
                        } else { // outfit that goes in front of pet
                            Image("dog") // Display pet image
                                .resizable()
                                .scaledToFit()
                                .padding(.bottom, 50)
                            
                            item.image
                                .resizable()
                                .scaledToFit()
                                .padding(.bottom, 50)
                            
                        }
                    }
                    .padding(.bottom, -5)
                }
            }
            
            // Item Name
            Text(item.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 1)
            
            // Item Description
            Text(item.description)
                .font(.title)
                .padding(.bottom, 1)
            
            // Item Price
            Text(item.price)
                .padding(.bottom, 10)
                .font(.system(size: 30))
                .foregroundColor(.green)
            
            Spacer()
            
            Button(action: {
                // Handle purchase action
                viewModel.purchaseItem(item: item)
                // This is to force SwiftUI to reevaluate the `isBought` state of our item.
                // SwiftUI will now check the `isBought` property again to determine the correct label and color for the button.
            }) {
                // Dynamically checking `isBought` status from the viewModel's items to ensure it's up-to-date
                if viewModel.items.first(where: { $0.id == item.id })?.isBought ?? false {
                    Text("Purchased")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.system(size: 20))
                } else {
                    Text("Purchase")
                        .padding()
                        .background(userCur >= Int(item.price) ?? 0 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.system(size: 20))
                }
            }
            .disabled(userCur < Int(item.price) ?? 0 || viewModel.items.first(where: { $0.id == item.id })?.isBought ?? false)
            .padding()
        }
    }
}

/// Preview Pet Store page
#Preview {
    PetStore()
}
