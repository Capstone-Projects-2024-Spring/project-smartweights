//
//  VideoCard.swift
//  SmartWeights
//
//  Created by Dillon Shi on 3/27/24.
//

import SwiftUI

struct VideoCard: View {
    
    var videoId: String
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Spacer()
            EmbeddedVideo(videoId: videoId)
                .cornerRadius(12)
                .padding(.horizontal, 8)
            Spacer()
            VStack (alignment: .leading) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.title3)
                Text(description)
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

#Preview {
    VideoCard(videoId: "Y_7aHqXeCfQ", title: "How to Dumbbell Press", description: "Description here")
}
