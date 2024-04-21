//
//  VideoCarousel.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/15/24.
//

import SwiftUI

struct VideoCarousel: View {
    
    let videoCards: [VideoCard]
    
    var body: some View {
        VStack {
            HStack {
                Text("Videos")
                    .font(.title3)
                    .padding(.top)
                    .padding(.bottom, -10)
                    .padding(.horizontal)
                    .foregroundStyle(.black)
                    .bold()
                Spacer()
            }
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(videoCards) { video in
                        video
                    }
                    
                }
            }
        }
        .foregroundStyle(.white)
        Spacer()    }
}

#Preview {
    
    let bicepCurl = VideoCard(videoFile: "SWTutorialv2", videoFileExt: "mp4", title: "SmartWeights Tutorial", description: "SmartWeights")
    
    return VideoCarousel(videoCards: [bicepCurl])
}
