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
    
    private var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    private var accessories: [Accessory] = [
        Accessory(name: "Chain", imageName: "chain"),
        Accessory(name: "Glasses", imageName: "glasses"),
    ]
    private let minSquares = 6
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image("dog")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 450, height: 450)
                }
                ScrollView {
                    ZStack {
                        LazyVGrid(columns: gridLayout, spacing: 20) {
                            ForEach(accessories) { accessory in
                                VStack {
                                    Image(accessory.imageName)
                                        .resizable()
                                        .scaledToFit()
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
