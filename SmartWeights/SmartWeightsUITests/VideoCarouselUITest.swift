//
//  VideoCarouselUITest.swift
//  SmartWeightsUITests
//
//  Created by Dillon Shi on 4/27/24.
//

import XCTest

final class VideoCarouselUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testVideoCarousel() throws {
        
        let app = XCUIApplication()
        app.launch()
        let youtubeVideo = app.scrollViews.matching(identifier: "Homepage").otherElements.webViews.otherElements["SmartWeights Tutorial - YouTube"]
        
        XCTAssertTrue(youtubeVideo.exists)
    }
}
