//
//  Inventory:Customize_page.swift
//  SmartWeights
//
//  Created by par chea on 3/19/24.
//

import SwiftUI


struct Customize_page: View {
    @Environment(\.presentationMode) var presentationMode
    var onBack: (() -> Void)?
    
    @ObservedObject var viewModel = CustomizeViewModel()
    
    // State to keep track of selected tab
    @State private var selectedTab = 0

    private let minSquares = 5
    private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if let bgImage = viewModel.equippedBackgroundImage {
                        Image(bgImage.imageName)
                            .resizable()
                            .frame(width: 350, height: 300)
                    }
                    
                    if let accessory = viewModel.equippedAccessory, accessory.name == "Jet Pack" {
                        Image(accessory.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    if let pet = viewModel.equippedPet {
                        Image(pet.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350, height: 300)
                    }
                    
                    if let accessory = viewModel.equippedAccessory, accessory.name != "Jet Pack" {
                        Image(accessory.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                }

                HStack(spacing: 20) {
                    Button(action:{
                        viewModel.equippedAccessory = nil
                        viewModel.equippedBackgroundImage = nil
                        // viewModel.equippedPet = nil
                    }){
                        Text("Unequip All")
                            .foregroundColor(.white)
                            .font(.system(size: 18).bold())
                            .frame(width: 125, height: 50)
                            .background(Color.red)
                            .cornerRadius(15)
                    }
                    Button(action: {
                        viewModel.saveCustomizations()
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.system(size: 18).bold())
                            .frame(width: 125, height: 50)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                }

                // if viewModel.isDataLoaded {
                    TabView(selection: $selectedTab) {
                        ScrollView {
                            VStack {
                                Button(action: {
                                    viewModel.equippedAccessory = nil
                                }) {
                                    Text("Unequip Accessory")
                                        .foregroundColor(.green)
                                        .font(.system(size: 18).bold())
                                        .frame(width: 125, height: 50)
                                        .background(Color.blue)
                                        .cornerRadius(15)
                                }
                            }
                            LazyVGrid(columns: gridLayout, spacing: 20) {
                                ForEach(viewModel.accessories) { accessory in
                                    VStack {
                                        Image(accessory.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .onTapGesture {
                                                viewModel.equippedAccessory = accessory
                                            }
                                        Text(accessory.name)
                                            .bold()
                                    }
                                    .background(Color.gray.opacity(0.5).cornerRadius(15))
                                }
                            }
                        }
                        .id(UUID())
                        .tabItem {
                            Label("Accessories", systemImage: "bag.fill")
                        }
                        .tag(0)

                        ScrollView {
                            VStack {
                                Button(action: {
                                    viewModel.equippedBackgroundImage = nil
                                }) {
                                    Text("Unequip Background")
                                        .foregroundColor(.green)
                                        .font(.system(size: 18).bold())
                                        .frame(width: 125, height: 50)
                                        .background(Color.blue)
                                        .cornerRadius(15)
                                }
                            }
                            LazyVGrid(columns: gridLayout, spacing: 20) {
                                ForEach(viewModel.backgroundImages) { bgImage in
                                    VStack {
                                        Image(bgImage.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .onTapGesture {
                                                viewModel.equippedBackgroundImage = bgImage
                                            }
                                        Text(bgImage.name)
                                            .bold()
                                    }
                                    .background(Color.gray.opacity(0.5).cornerRadius(15))
                                }
                            }
                        }
                        .id(UUID())
                        .tabItem {
                            Label("Backgrounds", systemImage: "photo")
                        }
                        .tag(1)

                        ScrollView {
                            LazyVGrid(columns: gridLayout, spacing: 20) {
                                ForEach(viewModel.pets) { pet in
                                    VStack {
                                        Image(pet.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .onTapGesture {
                                                viewModel.equippedPet = pet
                                            }
                                        Text(pet.name)
                                            .bold()
                                    }
                                    .background(Color.gray.opacity(0.5).cornerRadius(15))
                                }
                            }
                        }
                        .id(UUID())
                        .tabItem {
                            Label("Pets", systemImage: "hare")
                        }
                        .tag(2)
                    }
                    .frame(height: 400)
                // } else {
                //     ProgressView()
                //         .progressViewStyle(CircularProgressViewStyle())
                //         .scaleEffect(2)
                // }
            }
        }
    }
}

#Preview{
    Customize_page()
}
