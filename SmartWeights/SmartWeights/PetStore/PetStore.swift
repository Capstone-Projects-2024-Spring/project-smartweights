//
//  PetStore.swift
//  SmartWeights
//
//  Created by Jonathan Stanczak on 2/16/24.
//  Last modified: 2/18/24 12:25 PM

import Foundation
import SwiftUI

// Item struct
struct SellingItem: Identifiable {
    var id = UUID() // universal identifier for item number
    var name: String
    var imageName: String
    var category: String
    var price: String
}

// Will need to change or implement in backend but for now example:
private let items = [
    SellingItem(name: "Pet 1", imageName: "icon1", category: "Pets", price: "600"),
    SellingItem(name: "Pet 2", imageName: "icon1", category: "Pets", price: "500"),
    SellingItem(name: "Pet 3", imageName: "icon1", category: "Pets", price: "700"),
    SellingItem(name: "Food 1", imageName: "icon2", category: "Foods", price: "10"),
    SellingItem(name: "Background 1", imageName: "icon3", category: "Backgrounds", price: "65"),
    SellingItem(name: "Outfit 1", imageName: "icon4", category: "Outfits", price: "80"),
]

// grid for displaying items
private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

struct PetStore: View {
    @State private var showAlert = false
    @State private var sortByPrice = false // used for sorting
    @State private var selectedCategory = "Pets" // Default
    let categories = ["Pets", "Foods", "Backgrounds", "Outfits"]
    @State private var userCur = 550 // Default currency
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: { // Back Arrow
                        print("Button tapped (temp)")
                    }) {
                        Image(systemName: "arrow.left")
                            .imageScale(.large)
                            .foregroundColor(.white)
                    }
                    Spacer() // Move "Pet Store" away from back arrow
                    Text("Pet Store")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                    HStack {
                        Image(systemName: "dollarsign.circle")
                            .imageScale(.large)
                            .foregroundColor(.green)
                        Text("\(userCur)") // amount of money
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                }
                .padding() // Add padding to the HStack
                
                HStack {
                    Button(action: {
                        sortByPrice.toggle()
                    }) {
                        Text(sortByPrice ? "Sort by Price" : "Sort by Name")
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
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                // Here you would filter items based on the category
                                self.selectedCategory = category
                            }) {
                                Text(category)
                                    .padding()
                                    .background(self.selectedCategory == category ? Color.blue : Color.gray)
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
                        // Assuming you add filtering logic based on `selectedCategory`
                        ForEach(sortItems(items: items.filter { $0.category == selectedCategory }, sortByPrice: sortByPrice), id: \.id) { item in
                            NavigationLink(destination: ItemDetailView(item: item, userCur: userCur)) {
                                VStack {
                                    Image(item.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                        .frame(width: 130)
                                    Text(item.name)
                                    
                                    if sortByPrice {
                                        Text("\(item.price)") // Displaying price
                                            .font(.headline)
                                            .foregroundColor(.green)
                                    } else {
                                        Text("\(item.price)") // Displaying price
                                            .font(.headline)
                                            .foregroundColor(.green)
                                    }
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                            }
                        }
                    }
                    //.padding([.leading, .trailing, .bottom])
                }
            }
            .background(Color.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}

// Item Detail View - screen for users to preview and purchase
struct ItemDetailView: View {
    let item: SellingItem
    @State private var canPurchase = false
    let userCur: Int // Add user currency variable
    
    var body: some View {
        VStack {
            // Text("\(userCur)") // display userCur
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 50)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 300)
                .frame(width: 300)
                .padding(.horizontal)
                .padding(.top, -350)
            
            // Item Name
            Text(item.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, -5)
            
            // Item Price
            Text("\(item.price)")
            //.padding(.bottom, -50)
                .font(.system(size: 30))
                .foregroundColor(.green)
            //.padding()
            
            Spacer()
            
            // Purchase Button
            Button(action: {
                // Handle purchase action
                print("Purchase \(item.name)")
            }) {
                Text("Purchase")
                    .padding()
                    .background(userCur >= Int(item.price) ?? 0 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.system(size: 20))
            }
            .padding()
            .padding(.top, -150) // Add top padding to move the button higher up
            .disabled(userCur < Int(item.price) ?? 0) // Disable button if userCur is less than item price
        }
    }
}

// sortItems used to display items based on sorting
// lines 139-140 handle prices over 1000
private func sortItems(items: [SellingItem], sortByPrice: Bool) -> [SellingItem] {
    if sortByPrice {
        return items.sorted { (item1, item2) in
            let price1 = Int(item1.price) ?? 0
            let price2 = Int(item2.price) ?? 0
            return price1 < price2
        }
    } else {
        return items.sorted { $0.name < $1.name }
    }
}

// Preview
#Preview {
    PetStore()
}
