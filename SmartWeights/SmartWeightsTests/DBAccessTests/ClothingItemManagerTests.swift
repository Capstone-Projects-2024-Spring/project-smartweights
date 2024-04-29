
//
//  ClothingItemManagerTests.swift
//  SmartWeightsTests
//
//  Created by Daniel Eap on 4/27/24.
//

import XCTest
@testable import SmartWeights

final class ClothingItemManagerTests: XCTestCase {

    var clothingItemManager: ClothingItemDBManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        clothingItemManager = ClothingItemDBManager.shared
        clothingItemManager.clothingItems = [ClothingItemModel(recordId: nil, isActive: 0, imageName: "exampleImageName")]
    }

    override func tearDownWithError() throws {
        clothingItemManager = nil
        try super.tearDownWithError()
    }

    func testFetchClothingItems() throws {
        let expectation = XCTestExpectation(description: "Fetch clothing items")
        
        clothingItemManager.fetchClothingItems { clothingItems, error in
            XCTAssertNotNil(clothingItems)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchSpecificClothingItem() throws {
        let expectation = XCTestExpectation(description: "Fetch specific clothing item")
        let imageName = "exampleImageName"
        
        clothingItemManager.fetchSpecificClothingItem(imageName: imageName) { clothingItem, error in
            XCTAssertNotNil(clothingItem)
            XCTAssertNil(error)
            XCTAssertEqual(clothingItem?.imageName, imageName)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testCreateClothingItem() throws {
        let expectation = XCTestExpectation(description: "Create clothing item")
        let imageName = "exampleImageName"
        
        clothingItemManager.createClothingItem(imageName: imageName) { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.clothingItemManager.clothingItems.last?.imageName, imageName)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testSetActiveClothingItem() throws {
        let expectation = XCTestExpectation(description: "Set active clothing item")
        let imageName = "exampleImageName"
        
        clothingItemManager.setActiveClothingItem(imageName: imageName) { activeClothing, error in
            XCTAssertNil(error)
            XCTAssertEqual(self.clothingItemManager.activeClothing, imageName)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testSetUnactiveAllClothingItems() throws {
        let expectation = XCTestExpectation(description: "Set unactive all clothing items")
        
        clothingItemManager.setUnactiveAllClothingItems { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.clothingItemManager.activeClothing, "")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testGetActiveClothing() throws {
        let expectation = XCTestExpectation(description: "Get active clothing")
        
        clothingItemManager.getActiveClothing { activeClothing, error in
            XCTAssertNil(error)
            XCTAssertEqual(activeClothing, self.clothingItemManager.activeClothing)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}