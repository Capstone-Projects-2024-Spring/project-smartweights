//
//  VideoCard.swift
//  SmartWeights
//
//  Created by Dillon Shi on 3/27/24.
//

import SwiftUI
import WebKit

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

struct EmbeddedVideo: UIViewRepresentable {
    
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let path = "https://www.youtube.com/embed/\(videoId)"
        guard let youtubeURL = URL(string: path) else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: youtubeURL))
    }
}

#Preview {
    VideoCard(videoId: "ykJmrZ5v0Oo", title: "How to Do a Dumbbell Bicep Curl", description: "Howcast")
}
