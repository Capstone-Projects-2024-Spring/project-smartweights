//
//  VideoCard.swift
//  SmartWeights
//
//  Created by Dillon Shi on 3/27/24.
//

import SwiftUI
import AVKit

struct VideoCard: View, Identifiable {
    
    var videoId: String
    var title: String
    var description: String
    var id: String { videoId }
    
    var body: some View {
        VStack {
            Spacer()
            EmbeddedVideo()
            Spacer()
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
        }
        .frame(width: 200, height: 250)
        .background(Color.africanViolet)
        .cornerRadius(12)
        .padding()
    }
}

struct EmbeddedVideo: View {
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "SWTutorialv2", withExtension: "mp4")!)
    
    @State var showFullscreen = false
    
    var body: some View {
        VStack {
            videoView
                .frame(height: 140)
        }.fullScreenCover(isPresented: $showFullscreen) {
            videoView
        }
    }
    
    @ViewBuilder
    private var videoView: some View {
        VideoPlayer(player: player) {
            if !showFullscreen {
                VStack {
                    HStack {
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .padding(16)
                            .foregroundStyle(.white)
                            .tint(.white)
                            .onTapGesture {
                                showFullscreen.toggle()
                            }
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .padding(16)
                            .foregroundStyle(.white)
                            .tint(.white)
                            .onTapGesture {
                                showFullscreen.toggle()
                            }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    VideoCard(videoId: "ykJmrZ5v0Oo", title: "How to Do a Dumbbell Bicep Curl", description: "Howcast")
}
