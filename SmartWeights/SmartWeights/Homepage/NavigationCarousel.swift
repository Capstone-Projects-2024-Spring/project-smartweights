//
//  NavigationCarousel.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/15/24.
//

import SwiftUI

struct CarouselButton: Identifiable {
    let name: String
    let icon: String
    let link: AnyView
    var id: String { name }
}

struct NavigationCarousel: View {
    
    let buttons: [CarouselButton]
    let iconColor: Color
    let bgColor: Color
    let textColor: Color
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("App Features")
                .font(.title3)
                .foregroundStyle(textColor)
                .padding(.top)
                .padding(.horizontal)
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach (buttons) { button in
                        NavigationLink (destination: button.link) {
                            VStack {
                                Image(systemName: button.icon)
                                    .foregroundStyle(iconColor)
                                    .background(Circle()
                                        .frame(width: 60,
                                               height: 60)
                                            .foregroundStyle(bgColor))
                                    .padding()
                                Text("\(button.name)")
                                    .font(.subheadline)
                                    .foregroundStyle(textColor)
                            }
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let button = CarouselButton(name: "Test", icon: "photo", link: AnyView(PostWorkout()))
    let buttons: [CarouselButton] = [
        button
    ]
    
    return NavigationCarousel(buttons: buttons, iconColor: Color.africanViolet, bgColor: Color.black, textColor: Color.black)
}
