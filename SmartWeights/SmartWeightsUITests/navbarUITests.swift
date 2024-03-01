//
//  navbarUITests.swift
//  SmartWeightsUITests
//
//  Created by Dillon Shi on 2/29/24.
//

import XCTest
@testable import SmartWeights

final class navbarUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeButton() throws {
        app.launch()
        let homeButton = app.images["house"]
        XCTAssertTrue(homeButton.exists)
        homeButton.tap()
        XCTAssertTrue(app.collectionViews.firstMatch.exists)
    }
    
    func testPetButton() throws {
        app.launch()
        let petButton = app.images["pawprint"]
        XCTAssertTrue(petButton.exists)
        petButton.tap()
        XCTAssertTrue(app.collectionViews.firstMatch.exists)
    }
    
    func testWorkoutButton() throws {
        app.launch()
        let workoutButton = app.images["dumbbell"]
        XCTAssertTrue(workoutButton.exists)
        workoutButton.tap()
        XCTAssertTrue(app.collectionViews.firstMatch.exists)
    }
    
    func testProgressButton() throws {
        app.launch()
        let progressButton = app.images["chart.xyaxis.line"]
        XCTAssertTrue(progressButton.exists)
        progressButton.tap()
        XCTAssertTrue(app.collectionViews.firstMatch.exists)
    }
    
    func testProfileButton() throws {
        app.launch()
        let profileButton = app.images["person"]
        XCTAssertTrue(profileButton.exists)
        profileButton.tap()
        XCTAssertTrue(app.collectionViews.firstMatch.exists)
    }
}
