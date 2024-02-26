//
//  MorePageView.swift
//  SmartWeights
//
//  Created by Timothy Bui on 2/23/24.
//

import SwiftUI

struct MorePageView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "gearshape")
                        .padding(
                            [.trailing],
                            30
                        )
                }
                Text("Username")
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(
                        width: 100,
                        height: 100
                    )
                Text("Lv. 1")
                ProgressView(value: 0.5)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(
                        width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/
                    )
                Spacer()
                VStack {
                    Text("Achievements")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    HStack {
                        VStack {
                            Image(systemName: "trophy.circle")
                                .resizable()
                                .frame(
                                    width: 75,
                                    height: 75
                                )
                            Text("Achievement Title")
                                .font(.subheadline)
                        }
                        VStack {
                            Image(systemName: "trophy.circle")
                                .resizable()
                                .frame(
                                    width: 75,
                                    height: 75
                                )
                            Text("Achievement Title")
                                .font(.subheadline)
                        }
                        VStack {
                            Image(systemName: "trophy.circle")
                                .resizable()
                                .frame(
                                    width: 75,
                                    height: 75
                                )
                            Text("Achievement Title")
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                    Image(systemName: "dog")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 300,
                            height: 300
                        )
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MorePageView()
}
