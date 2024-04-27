//
//  VideoViewTests.swift
//  SmartWeightsTests
//
//  Created by Dillon Shi on 4/27/24.
//

import XCTest
import WebKit
@testable import SmartWeights

final class VideoViewTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testVideoView() {
        // Given
        let videoId = "K9E32Z8ZQDU"
        let videoView = VideoView(videoId: videoId)
        
        // When
        let webView = videoView.makeUIView(context: Context())
        videoView.updateUIView(webView, context: Context())
        
        // Then
        XCTAssertTrue(webView is WKWebView)
        
        let expectedURL = "https://www.youtube.com/embed/\(videoId)"
        XCTAssertEqual(webView.url?.absoluteString, expectedURL)
    }

}
