//
//  PetPageUITests.swift
//  SmartWeightsUITests
//
//  Created by par chea on 2/29/24.
//

import XCTest
@testable import SmartWeights

final class PetPageUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Clean up any resources if needed
    }
    
    
    func testChangeFoodButton() throws {
        let changeFoodButton = app.buttons["ChangeFoodButton"]
        XCTAssertTrue(changeFoodButton.exists)
        changeFoodButton.tap()
        XCTAssertTrue(app.collectionViews.firstMatch.exists)
    }
    
    func testUseFoodButton() throws{
        let usefoodbutton = app.buttons["UseFoodButton"]
        XCTAssertTrue(usefoodbutton.exists)
        usefoodbutton.tap()
    }
    
    
    func testHamburgerMenuButton() throws{
        let hamburgerMenuButton = app.buttons["HamburgerMenuButton"]
        XCTAssertTrue(hamburgerMenuButton.exists, "The hamburger menu button does not exist.")
        hamburgerMenuButton.tap()
    }
    
    func testHamburgerMenuNavigationtoShop() throws {
        let hamburgerMenuButton = app.buttons["HamburgerMenuButton"]
        XCTAssertTrue(hamburgerMenuButton.exists, "The hamburger menu button does not exist.")
        hamburgerMenuButton.tap()
        
        // Test navigation to the Shop view
        let shopButton = app.buttons["Shop"]
        XCTAssertTrue(shopButton.exists, "The Shop button does not exist in the hamburger menu.")
        shopButton.tap()
    }
    
    func testHamburgerMenuNavigationtoInventory() throws {
        let hamburgerMenuButton = app.buttons["HamburgerMenuButton"]
        XCTAssertTrue(hamburgerMenuButton.exists, "The hamburger menu button does not exist.")
        hamburgerMenuButton.tap()
        
        // Test navigation to the Inventory view
        let shopButton = app.buttons["Inventory"]
        XCTAssertTrue(shopButton.exists, "The Shop button does not exist in the hamburger menu.")
        shopButton.tap()
    }
    func testHamburgerMenuNavigationtoCustomize() throws {
        let hamburgerMenuButton = app.buttons["HamburgerMenuButton"]
        XCTAssertTrue(hamburgerMenuButton.exists, "The hamburger menu button does not exist.")
        hamburgerMenuButton.tap()
        
        // Test navigation to the Customize view
        let shopButton = app.buttons["Customize"]
        XCTAssertTrue(shopButton.exists, "The Shop button does not exist in the hamburger menu.")
        shopButton.tap()
    }
}
