//
//  VideoView.swift
//  SmartWeights
//
//  Created by Dillon Shi on 4/21/24.
//

import SwiftUI
import WebKit

struct VideoView: UIViewRepresentable {
    
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
    VideoView(videoId: "K9E32Z8ZQDU")
}
