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
    
    private let minSquares = 5
    private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    viewModel.backgroundColor
                        .frame(width: 300, height: 320)
                        .cornerRadius(15)
                    
                    // Background image
                    if let bgImage = viewModel.equippedBackgroundImage {
                        Image(bgImage.imageName)
                            .resizable()
                            .frame(width: 400, height: 350)
                    }
                    
                    // Conditionally render the Jet Pack behind the dog
                    if let accessory = viewModel.equippedAccessory, accessory.name == "Jet Pack" {
                        Image(accessory.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    // Pet image
                    if let pet = viewModel.equippedPet {
                        Image(pet.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                    
                    // Accessory image
                    if let accessory = viewModel.equippedAccessory, accessory.name != "Jet Pack" {
                        Image(accessory.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                // Background color picker
                //                ColorPicker("Set the background color", selection: $viewModel.backgroundColor)
                //                    .frame(width: 350, height: 50, alignment: .center)
                //                    .font(.system(size: 18).bold())
                //                    .background(Color.gray.opacity(0.1))
                //                    .cornerRadius(15)
                HStack(spacing: 20) {
                    Button(action:{
                        viewModel.equippedAccessory = nil
                        viewModel.equippedBackgroundImage = nil
                        viewModel.equippedPet = nil
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
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
                // Grid layout for accessory for the inventory
                if viewModel.isDataLoaded {
                    TabView {
                        // Grid layout for accessories
                        ScrollView {
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
                                placeholders(for: viewModel.accessories.count)
                                // Unequip option
                                VStack {
                                    Image(systemName: "xmark") 
                                        .resizable()
                                        .scaledToFit()
                                        .onTapGesture {
                                            viewModel.equippedAccessory = nil
                                        }
                                    Text("Unequip")
                                        .bold()
                                }
                            }
                        }.id(UUID())
                            .tabItem {
                                Label("Accessories", systemImage: "bag.fill")
                            }
                        
                        // Grid layout for background image
                        ScrollView {
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
                                placeholders(for: viewModel.backgroundImages.count)
                                // Unequip option
                                VStack {
                                    Image(systemName: "xmark") 
                                        .resizable()
                                        .scaledToFit()
                                        .onTapGesture {
                                            viewModel.equippedBackgroundImage = nil
                                        }
                                    Text("Unequip")
                                        .bold()
                                }
                                .background(Color.gray.opacity(0.5).cornerRadius(15))
                            }
                        }.id(UUID())
                            .tabItem {
                                Label("Backgrounds", systemImage: "photo")
                            }
                        
                        // Grid layout for the pet
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
                                placeholders(for: viewModel.pets.count)
                            }
                            
                        }.id(UUID())
                            .tabItem {
                                Label("Pets", systemImage: "hare")
                            }
                        
                    }.frame(height: 400)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                }
                
            }
        }
    }
    @ViewBuilder
    private func placeholders(for count: Int) -> some View {
        ForEach(0..<max(minSquares - count, 0), id: \.self) { _ in
            VStack {
                Image(systemName: "")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                    .foregroundColor(.white)
                    .frame(width: 120, height: 150)
            }
            .background(Color.gray.opacity(0.5).cornerRadius(15))
        }
    }
}

#Preview{
    Customize_page()
}
