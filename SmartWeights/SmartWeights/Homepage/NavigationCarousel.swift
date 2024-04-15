//
//  NavigationCarousel.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/15/24.
//

import SwiftUI

struct CarouselButton: Identifiable {
    let name: String
    var id: String { name }
}

struct NavigationCarousel: View {
    
    let buttons: [CarouselButton]
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("App Features")
                .font(.title3)
                .padding(.top)
                .padding(.horizontal)
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach (buttons) { button in
                        VStack {
                            Image(systemName: "photo")
                                .background(Circle()
                                    .frame(width: 60,
                                           height: 60))
                                .padding()
                            Text("\(button.name)")
                                .font(.subheadline)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    let button = CarouselButton(name: "Test")
    let buttons: [CarouselButton] = [
        button
    ]
    
    return NavigationCarousel(buttons: buttons)
}
