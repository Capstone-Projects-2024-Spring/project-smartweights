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
    @ObservedObject var coreDataManager: CoreDataManager
    
    let buttons: [CarouselButton]
    let iconColor: Color
    let bgColor: Color
    let textColor: Color
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Additional Pages")
                .font(.title3)
                .foregroundStyle(textColor)
                .padding(.top)
                .padding(.horizontal)
                .bold()
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
                                Spacer()
                            }
                            .frame(width: 70, height: 70)
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let button = CarouselButton(name: "Test", icon: "photo", link: AnyView(allFeedback(coreDataManager: CoreDataManager())))
    let buttons: [CarouselButton] = [
        button
    ]
    
    return NavigationCarousel(coreDataManager: CoreDataManager(), buttons: buttons, iconColor: Color.africanViolet, bgColor: Color.black, textColor: Color.black)
}
