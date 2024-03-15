//
//  Customize_page.swift
//  SmartWeights
//
//  Created by par chea on 3/11/24.
//

import SwiftUI

struct Accessory: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
}

struct Customize_page: View {
    @Environment(\.presentationMode) var presentationMode
    var onBack: (() -> Void)?
    
    @State private var equippedAccessory: Accessory?
    @State private var backgroundColor: Color = .white // Default color for the background
    
    
    private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    private var accessories: [Accessory] = [
        Accessory(name: "Chain", imageName: "chain"),
        Accessory(name: "Glasses", imageName: "glasses"),
    ]
    private let minSquares = 12
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    
                    backgroundColor.ignoresSafeArea(edges: .all)
                    
                    Image("dog")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 450, height: 450)
                    
                    if let accessory = equippedAccessory {
                        Image(accessory.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                // Background Color
                ColorPicker("Set the background color", selection: $backgroundColor)
                    .frame(width: 300, height: 50, alignment: .center)
                    .font(.system(size: 18)
                        .bold())
                    .background(Color.gray.opacity(10))
                    .cornerRadius(15)
                
                
                ScrollView {
                    ZStack {
                        LazyVGrid(columns: gridLayout, spacing: 20) {
                            ForEach(accessories) { accessory in
                                VStack {
                                    Image(accessory.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .onTapGesture{
                                            equippedAccessory = accessory
                                        }
                                    Text(accessory.name)
                                }
                                .background(Color.gray.opacity(0.50).cornerRadius(15))
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
                                .background(Color.gray.opacity(0.50).cornerRadius(15))
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Customize_page()
}
