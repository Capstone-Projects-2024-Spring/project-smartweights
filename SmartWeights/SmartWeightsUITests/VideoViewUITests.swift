//
//  VideoViewUITests.swift
//  SmartWeightsUITests
//
//  Created by Dillon Shi on 4/27/24.
//

import XCTest
@testable import SmartWeights

final class VideoViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    func testVideoViewDisplayed() throws {
        let app = XCUIApplication()
        app.launch()
        
        app/*@START_MENU_TOKEN@*/.scrollViews.matching(identifier: "Homepage").otherElements.webViews.webViews.webViews.otherElements["SmartWeights Tutorial - YouTube"].buttons["Play"]/*[[".otherElements[\"house\"].scrollViews.matching(identifier: \"Homepage\").otherElements.webViews.webViews.webViews.otherElements[\"SmartWeights Tutorial - YouTube\"]",".otherElements[\"YouTube Video Player\"].buttons[\"Play\"]",".buttons[\"Play\"]",".scrollViews.matching(identifier: \"Homepage\").otherElements.webViews.webViews.webViews.otherElements[\"SmartWeights Tutorial - YouTube\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 1).children(matching: .other).element
        let element = element2.children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        element.tap()
        
        let fullscreenButtonButton = app/*@START_MENU_TOKEN@*/.buttons["Fullscreen Button"]/*[[".buttons[\"Close\"]",".buttons[\"Fullscreen Button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fullscreenButtonButton.tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.matching(identifier: "Homepage")/*[[".otherElements[\"house\"].scrollViews.matching(identifier: \"Homepage\")",".scrollViews.matching(identifier: \"Homepage\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.containing(.staticText, identifier:"How to Dumbell Curl").element.swipeLeft()
        element2.swipeLeft()
        app/*@START_MENU_TOKEN@*/.scrollViews.matching(identifier: "Homepage").otherElements.webViews.webViews.webViews.otherElements["How to Do Standing Dumbbell Curls - YouTube"].buttons["Play"]/*[[".otherElements[\"house\"].scrollViews.matching(identifier: \"Homepage\").otherElements.webViews.webViews.webViews.otherElements[\"How to Do Standing Dumbbell Curls - YouTube\"]",".otherElements[\"YouTube Video Player\"].buttons[\"Play\"]",".buttons[\"Play\"]",".scrollViews.matching(identifier: \"Homepage\").otherElements.webViews.webViews.webViews.otherElements[\"How to Do Standing Dumbbell Curls - YouTube\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        element.tap()
        fullscreenButtonButton.tap()
        
    }
}
