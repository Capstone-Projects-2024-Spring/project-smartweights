//
//  VideoCard.swift
//  SmartWeights
//
//  Created by Dillon Shi on 3/27/24.
//

import SwiftUI
import AVKit

struct VideoCard: View, Identifiable {
    
    var videoFile: String
    var videoFileExt: String
    var title: String
    var description: String
    var id: String { videoFile }
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                GeometryReader { geometry in
                    PlayerView(url: Bundle.main.url(forResource: videoFile, withExtension: videoFileExt)!)
                        .frame(width: geometry.size.width, height: 200)
                }
            }
            .padding(.top, 5)
            VStack (alignment: .leading) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.headline)
                    .bold()
                Text(description)
                    .foregroundStyle(Color.black)
                    .font(.subheadline)
            }
            .padding(.horizontal, 8)
            .padding(.bottom)
            Spacer()
        }
        .frame(width: 250, height: 300)
        .background(Color.africanViolet)
        .cornerRadius(12)
        .padding()
    }
}

#Preview {
    VideoCard(videoFile: "SWTutorialv2", videoFileExt: "mp4", title: "SmartWeights Tutorial", description: "SmartWeights")
}
