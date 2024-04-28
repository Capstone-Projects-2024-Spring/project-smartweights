//
//  TabBarUITests.swift
//  SmartWeightsUITests
//
//  Created by Dillon Shi on 4/27/24.
//

import XCTest

final class TabBarUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    func testTabBar() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        let petButton = tabBar.buttons["Pet"]
        petButton.tap()
        petButton.tap()
        tabBar.buttons["Workout"].tap()
        tabBar.buttons["Achievements"].tap()
        tabBar.buttons["Profile"].tap()
        
        
    }
}
