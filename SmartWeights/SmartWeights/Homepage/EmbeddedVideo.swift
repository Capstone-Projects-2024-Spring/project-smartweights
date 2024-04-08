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
    EmbeddedVideo(videoId: "ykJmrZ5v0Oo")
        .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
        .cornerRadius(12)
        .padding(.horizontal, 24)
}
