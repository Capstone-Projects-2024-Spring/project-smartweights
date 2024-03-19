//
//  Inventory:Customize_page.swift
//  SmartWeights
//
//  Created by par chea on 3/19/24.
//

import SwiftUI

struct Accessory: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
}

struct BackgroundImage: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
}

struct Pet_selection: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
}


struct Customize_page: View {
    @Environment(\.presentationMode) var presentationMode
    var onBack: (() -> Void)?
    
    @State private var equippedAccessory: Accessory?
    @State private var equippedBackgroundImage: BackgroundImage?
    @State private var equippedPet: Pet_selection? = Pet_selection(name: "Dog", imageName: "dog") // Default pet
    @State private var backgroundColor: Color = .white
    
    private let minSquares = 6
    
    private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    private var accessories: [Accessory] = [
        Accessory(name: "Chain", imageName: "chain"),
        Accessory(name: "Glasses", imageName: "glasses"),
        Accessory(name: "Jet Pack", imageName: "jetpack"),
    ]
    
    private var backgroundImages: [BackgroundImage] = [
        BackgroundImage(name: "Flag", imageName: "flag"),
        BackgroundImage(name: "Sand Castle", imageName: "sandcastle"),
    ]
    
    private var pets: [Pet_selection] = [
        Pet_selection(name: "Dog", imageName: "dog"),
        Pet_selection(name: "Cat", imageName: "cat"),
    ]
    
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    backgroundColor.ignoresSafeArea(edges: .all)
                    
                    // Background image
                    if let bgImage = equippedBackgroundImage {
                        Image(bgImage.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding(.trailing, 270)
                            .padding(.top, 150)
                    }
                    
                    // Conditionally render the Jet Pack behind the dog
                    if let accessory = equippedAccessory, accessory.name == "Jet Pack" {
                        Image(accessory.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    // Pet image
                    if let pet = equippedPet {
                        Image(pet.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                    
                    // Accessory image
                    if let accessory = equippedAccessory, accessory.name != "Jet Pack" {
                        Image(accessory.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                // Background color
                ColorPicker("Set the background color", selection: $backgroundColor)
                    .frame(width: 300, height: 50, alignment: .center)
                    .font(.system(size: 18).bold())
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                
                // Grid layout for accessory for the inventory
                TabView {
                    ScrollView {
                        LazyVGrid(columns: gridLayout, spacing: 20) {
                            ForEach(accessories) { accessory in
                                VStack {
                                    Image(accessory.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .onTapGesture {
                                            equippedAccessory = accessory
                                        }
                                    Text(accessory.name)
                                }
                                .background(Color.gray.opacity(0.5).cornerRadius(15))
                                
                            }
                            ForEach(0..<max(minSquares - accessories.count, 0), id: \.self) { _ in
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
                    .tabItem {
                        Label("Accessories", systemImage: "bag.fill")
                    }
                    
                    // Grid layout for background image
                    ScrollView {
                        LazyVGrid(columns: gridLayout, spacing: 20) {
                            ForEach(backgroundImages) { bgImage in
                                VStack {
                                    Image(bgImage.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .onTapGesture {
                                            equippedBackgroundImage = bgImage
                                        }
                                    Text(bgImage.name)
                                }
                                .background(Color.gray.opacity(0.5).cornerRadius(15))
                            }
                            ForEach(0..<max(minSquares + 1 - accessories.count, 0), id: \.self) { _ in
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
                    .tabItem {
                        Label("Backgrounds", systemImage: "photo")
                    }
                    
                    // Grid layout for the pet
                    ScrollView {
                        LazyVGrid(columns: gridLayout, spacing: 20) {
                            ForEach(pets) { pet in
                                VStack {
                                    Image(pet.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .onTapGesture {
                                            equippedPet = pet
                                        }
                                    Text(pet.name)
                                }
                                .background(Color.gray.opacity(0.5).cornerRadius(15))
                            }
                            ForEach(0..<max(minSquares + 1 - accessories.count, 0), id: \.self) { _ in
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
                    .tabItem {
                        Label("Pets", systemImage: "hare")
                    }
                }
                .frame(height: 400)
            }
        }
    }
}

#Preview{
    Customize_page()
}

