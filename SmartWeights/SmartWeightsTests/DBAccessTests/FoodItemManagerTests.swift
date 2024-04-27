
//
//  FoodItemManagerTests.swift
//  SmartWeightsTests
//
//  Created by Daniel Eap on 4/27/24.
//

import XCTest
@testable import SmartWeights

final class FoodItemManagerTests: XCTestCase {

    var foodItemManager: FoodItemDBManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        foodItemManager = FoodItemDBManager.shared
        foodItemManager.foodItems = [
            FoodItemModel(recordId: nil, name: "Apple", quantity: 5, imageName: "Apple"),
            FoodItemModel(recordId: nil, name: "Orange", quantity: 2, imageName: "Orange")
        ]
    }

    override func tearDownWithError() throws {
        foodItemManager = nil
        try super.tearDownWithError()
    }

    func testFetchFoodItems() throws {
        let expectation = XCTestExpectation(description: "Fetch food items")
        
        foodItemManager.fetchFoodItems { foodItems, error in
            XCTAssertNil(error, "Error fetching food items: \(error?.localizedDescription ?? "Unknown error")")
            XCTAssertNotNil(foodItems, "Food items should not be nil")
            XCTAssertEqual(foodItems?.count, 3, "Incorrect number of food items")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testCreateFoodItem() throws {
        let expectation = XCTestExpectation(description: "Create food item")
        
        let initialCount = foodItemManager.foodItems.count
        
        foodItemManager.createFoodItem(name: "Juice", quantity: 0) { error in
            XCTAssertNil(error, "Error creating food item: \(error?.localizedDescription ?? "Unknown error")")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testUpdateQuantity() throws {
        let expectation = XCTestExpectation(description: "Update quantity")
        foodItemManager.foodItems = [
            FoodItemModel(recordId: nil, name: "Apple", quantity: 5, imageName: "Apple"),
            FoodItemModel(recordId: nil, name: "Orange", quantity: 2, imageName: "Orange")
        ]
        let foodItem = foodItemManager.foodItems[0]
        let initialQuantity = foodItem.quantity
        let newQuantity = initialQuantity + 1
        
        foodItemManager.updateQuantity(name: "Apple", newQuantity: newQuantity) { error in
            XCTAssertNil(error, "Error updating quantity: \(error?.localizedDescription ?? "Unknown error")")
            
            XCTAssertNotNil(self.foodItemManager.foodItems.first(where: { $0.name == "Apple" }), "Food item not found")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchQuantity() throws {
        let expectation = XCTestExpectation(description: "Fetch quantity")
        
        let foodItem = foodItemManager.foodItems[0]
        
        foodItemManager.fetchQuantity(name: foodItem.name) { quantity, error in
            XCTAssertNil(error, "Error fetching quantity: \(error?.localizedDescription ?? "Unknown error")")
            
            XCTAssertNotNil(quantity, "Quantity should not be nil")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testUpdateQuantity_add() throws {
        let expectation = XCTestExpectation(description: "Update quantity (add)")
        
        let foodItem = foodItemManager.foodItems[0]
        let initialQuantity = foodItem.quantity
        let quantityToAdd: Int64 = 5
        let expectedQuantity = initialQuantity + quantityToAdd
        
        foodItemManager.updateQuantity_add(name: foodItem.name, quantity: quantityToAdd) { error in
            XCTAssertNil(error, "Error updating quantity: \(error?.localizedDescription ?? "Unknown error")")
            
            XCTAssertNotNil(self.foodItemManager.foodItems.first(where: { $0.name == foodItem.name }), "Food item not found")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}
