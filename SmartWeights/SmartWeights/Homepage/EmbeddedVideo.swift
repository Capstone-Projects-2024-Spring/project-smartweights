//
//  EmbeddedVideo.swift
//  SmartWeights
//
//  Created by Dillon Shi on 3/27/24.
//

import SwiftUI
import WebKit

struct EmbeddedVideo: UIViewRepresentable {
    
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else {return}
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}

#Preview {
    EmbeddedVideo(videoId: "Y_7aHqXeCfQ")
        .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
        .cornerRadius(12)
        .padding(.horizontal, 24)
}
