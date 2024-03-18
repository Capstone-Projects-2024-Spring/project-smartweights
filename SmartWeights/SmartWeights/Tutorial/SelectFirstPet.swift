//
//  SelectFirstPet.swift
//  SmartWeights
//
//  Created by Jonathan Stanczak on 2/28/24.
//

import Foundation
import SwiftUI

/// Grid for displaying items.
private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

class Pet: ObservableObject {
    var image: Image
    var name: String
    var petID: Int
    
    init(image: Image, name: String, petID: Int) {
        self.image = image
        self.name = name
        self.petID = petID
    }
}

/// View for selecting the first pet when user first uses the application.
struct SelectPet: View {
    @State private var name: String = ""
    @State private var selectedPet: Pet? = nil // Added to store the selected pet
    var title = "Select Pet"
    var caption = "You can change your pet's appearance at any time."
    
    var body: some View {
        
        VStack {
            // display title
            Text(title)
                .font(.system(size: 40))
                .fontWeight(.bold)
            
            // display caption
            Text(caption)
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
            
            // display pet options
            HStack {
                PetGrid(pet: Pet(image: Image("dog"), name: "Dog", petID: 1), selectedPet: $selectedPet)
                    .padding(.trailing, -15)
                PetGrid(pet: Pet(image: Image("cat"), name: "Cat", petID: 2), selectedPet: $selectedPet)
            }
            
            // Text field for pet name
            TextField("Enter your pet's name...", text: $name, onCommit: { // saves user input when typing
                UserDefaults.standard.set(self.name, forKey: "name")
            })
            .padding()
            .frame(width: 320) // Set the desired width
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.vertical, 10)
            
            if name.count > 0 && selectedPet != nil {
                Button(action: {
                    print(name)
                }) {
                    Text("Continue")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.system(size: 20))
                }
                .padding()
            }
        }
    }
}

/// View for the Pets to choose from
struct PetGrid: View {
    @ObservedObject var pet: Pet
    @Binding var selectedPet: Pet?
    @State private var isBackgroundBlue = false
    
    var body: some View {
        VStack {
            pet.image
                .resizable()
                .frame(width: 120, height: 120)
            Text(pet.name)
        }
        .padding()
        .background(selectedPet?.image == pet.image ? Color.blue : Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding()
        .onTapGesture {
            selectedPet = pet
        }
    }
}

/// Preview screen.
#Preview {
    SelectPet()
}
