//
//  VideoCard.swift
//  SmartWeights
//
//  Created by Dillon Shi on 3/27/24.
//

import SwiftUI

struct VideoCard: View, Identifiable {
    
    var videoId: String
    var title: String
    var description: String
    var id: String { videoId }
    
    var body: some View {
        VStack {
            Spacer()
            EmbeddedVideo(videoId: videoId)
            Spacer()
            VStack (alignment: .leading) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.title3)
                Text(description)
                    .foregroundStyle(Color.lightGray)
                    .font(.subheadline)
            }
            .padding(.horizontal, 8)
            .padding(.bottom)
        }
        .frame(width: 200, height: 250)
        .background(Color.darkGray)
        .cornerRadius(12)
        .padding()
    }
}

#Preview {
    VideoCard(videoId: "ykJmrZ5v0Oo", title: "How to Do a Dumbbell Bicep Curl", description: "Howcast")
}
