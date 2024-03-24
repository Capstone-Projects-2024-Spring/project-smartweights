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

class CustomizeViewModel: ObservableObject {
    @Published var equippedAccessory: Accessory?
    @Published var equippedBackgroundImage: BackgroundImage?
    @Published var equippedPet: Pet_selection? = Pet_selection(name: "Dog", imageName: "dog") // Default pet
    @Published var backgroundColor: Color = .white // Default background color
    
    // Data arrays
    let accessories: [Accessory] = [
        Accessory(name: "Chain", imageName: "chain"),
        Accessory(name: "Glasses", imageName: "glasses"),
        Accessory(name: "Jet Pack", imageName: "jetpack"),
    ]
    
    let backgroundImages: [BackgroundImage] = [
        BackgroundImage(name: "Bamboo", imageName: "Bamboo"),
        BackgroundImage(name: "Festive", imageName: "Festive"),
        BackgroundImage(name: "Royal", imageName: "Royal"),
    ]
    
    let pets: [Pet_selection] = [
        Pet_selection(name: "Dog", imageName: "dog"),
        Pet_selection(name: "Cat", imageName: "cat"),
    ]
}

struct Customize_page: View {
    @Environment(\.presentationMode) var presentationMode
    var onBack: (() -> Void)?
    
    @ObservedObject var viewModel = CustomizeViewModel()
    
    private let minSquares = 6
    private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    viewModel.backgroundColor.ignoresSafeArea(edges: .all)
                    
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
                ColorPicker("Set the background color", selection: $viewModel.backgroundColor)
                    .frame(width: 350, height: 50, alignment: .center)
                    .font(.system(size: 18).bold())
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                
                // Grid layout for accessory for the inventory
                TabView {
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

                        }
                    }
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

                        }
                    }
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
                    }
                    .tabItem {
                        Label("Pets", systemImage: "hare")
                    }
                }
                .frame(height: 400)
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
