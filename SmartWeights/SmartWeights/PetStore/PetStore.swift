//
//  PetStore.swift
//  SmartWeights
//
//  Created by Jonathan Stanczak on 2/16/24.
//  Last modified: 2/25/24 11:50 AM

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
}


/// Grid for displaying items.
private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

/// Display view for the Pet Store depending on available items and prices.
struct PetStore: View {
    
    @ObservedObject var viewModel = storeViewModel()
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
                            NavigationLink(destination: ItemDetailView(item: item, userCur: viewModel.userCur,viewModel:viewModel)) {
                                VStack {
                                    item.image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                    
                                    Text(item.name)
                                    
                                    if viewModel.sortByPrice {
                                        Text("\(item.price)") // Displaying price
                                            .font(.headline)
                                            .foregroundColor(.green)
                                    } else {
                                        Text("\(item.price)") // Displaying price
                                            .font(.headline)
                                            .foregroundColor(.green)
                                    }
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}

/// Display view for previewing and purchasing and item.
struct ItemDetailView: View {
    let item: SellingItem
    @State private var canPurchase = false
    let userCur: Int // Add user currency variable
    let viewModel: storeViewModel
    
    var body: some View {
        VStack {
            VStack {
                ZStack { // stack item with current pet
                    item.image
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 50)
                    
                    // Example stacking items
                    /*
                     let image2 = Image("glasses")
                     image2
                     .resizable()
                     .scaledToFit()
                     //.frame(width: 100, height: 100) // Adjust size as needed
                     .padding(.bottom, 50) // Adjust position as needed
                     */
                    
                }
                .padding(.bottom, -5)
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
            Text("\(item.price)")
                .padding(.bottom, 10)
                .font(.system(size: 30))
                .foregroundColor(.green)
            //.padding()
            
            Spacer()
            
            // Purchase Button
            Button(action: {
                // Handle purchase action
                print("Purchase \(item.name)")
                viewModel.subtractFunds(price: Int(item.price) ?? 0)
            }) {
                Text("Purchase")
                    .padding()
                    .background(userCur >= Int(item.price) ?? 0 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.system(size: 20))
            }
            .padding()
            .padding(.top, -120) // Add top padding to move the button higher up
            .disabled(userCur < Int(item.price) ?? 0) // Disable button if userCur is less than item price
            .padding(.top, -30) // Move purchase button higher, can adjust to fit nav bar
        }
    }
}

/// Preview Pet Store page.
#Preview {
    PetStore()
}
