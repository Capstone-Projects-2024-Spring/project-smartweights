//
//  HomepageUITests.swift
//  SmartWeightsUITests
//
//  Created by Dillon Shi on 4/27/24.
//

import XCTest
@testable import SmartWeights

final class HomepageUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        
    }

    func testVideoCarousel() throws {
        
        let youtubeVideo = app.scrollViews.matching(identifier: "Homepage").otherElements.webViews.otherElements["SmartWeights Tutorial - YouTube"]
        
        
        let seconds = 10.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            XCTAssertTrue(youtubeVideo.exists)
        }
    }
    
    func testButtonCarousel() throws {
        
        let elementsQuery = app/*@START_MENU_TOKEN@*/.scrollViews.matching(identifier: "Homepage")/*[[".otherElements[\"house\"].scrollViews.matching(identifier: \"Homepage\")",".scrollViews.matching(identifier: \"Homepage\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements
        elementsQuery.buttons["Progress"].tap()
        
        let backButton = app/*@START_MENU_TOKEN@*/.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*[[".otherElements[\"house\"].navigationBars[\"_TtGC7SwiftUI32NavigationStackHosting\"]",".navigationBars[\"_TtGC7SwiftUI32NavigationStackHosting\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Back"]
        backButton.tap()
        
        app/*@START_MENU_TOKEN@*/.scrollViews.matching(identifier: "Homepage").otherElements.images["powerplug"]/*[[".otherElements[\"house\"].scrollViews.matching(identifier: \"Homepage\").otherElements",".buttons[\"Charging\"].images[\"powerplug\"]",".images[\"powerplug\"]",".scrollViews.matching(identifier: \"Homepage\").otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        backButton.tap()
        
        app/*@START_MENU_TOKEN@*/.scrollViews.matching(identifier: "Homepage").otherElements.images["sensor"]/*[[".otherElements[\"house\"].scrollViews.matching(identifier: \"Homepage\").otherElements",".buttons[\"Attaching Sensors\"].images[\"sensor\"]",".images[\"sensor\"]",".scrollViews.matching(identifier: \"Homepage\").otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        backButton.tap()
        
        elementsQuery.buttons["Help"].tap()
        app/*@START_MENU_TOKEN@*/.navigationBars["Help"]/*[[".otherElements[\"house\"].navigationBars[\"Help\"]",".navigationBars[\"Help\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Back"].tap()
    }
    
    func testStartWorkoutButton() throws {
        
        app/*@START_MENU_TOKEN@*/.buttons["Homepage"]/*[[".otherElements[\"house\"]",".buttons[\"Start Workout, Dumbbell Press\"]",".buttons[\"Homepage\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
}
