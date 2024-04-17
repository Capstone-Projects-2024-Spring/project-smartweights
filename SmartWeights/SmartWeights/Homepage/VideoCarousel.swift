//
//  VideoCarousel.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/15/24.
//

import SwiftUI

struct VideoCarousel: View {
    var body: some View {
        VStack {
            HStack {
                Text("Videos")
                    .font(.title3)
                    .padding(.top)
                    .padding(.horizontal)
                Spacer()
                HStack {
                    Text("See more")
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.africanViolet)
                }
                .padding()
            }
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    let count = 1...4
                    ForEach(count, id: \.self) { number in
                        if number == 1 {
                            VideoCard(videoId: "ykJmrZ5v0Oo", title: "How to Do a Dumbbell Bicep Curl", description: "Howcast")
                        } else {
                            VStack {
                                Spacer()
                                Image(systemName: "photo")
                                    .foregroundStyle(Color.lightGray)
                                Spacer()
                                VStack (alignment: .leading){
                                    Text("Video \(number)")
                                        .font(.title3)
                                    Text("Video Description")
                                        .foregroundStyle(Color.lightGray)
                                        .font(.subheadline)
                                }
                                .padding(.bottom)
                            }
                            .frame(width: 200, height: 250)
                            .background(Color.darkGray)
                            .cornerRadius(12)
                            .padding()
                        }
                    }
                    
                }
            }
        }
        .foregroundStyle(.white)
        Spacer()    }
}

#Preview {
    VideoCarousel()
}
