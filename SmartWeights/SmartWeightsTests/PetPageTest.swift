//
//  PetPageTest.swift
//  SmartWeightsTests
//
//  Created by par chea on 2/29/24.
//

import XCTest
@testable import SmartWeights

final class PetPageTest: XCTestCase {

    var viewModel: PetPageFunction!

        override func setUpWithError() throws {
            viewModel = PetPageFunction()
        }

        override func tearDownWithError() throws {
            viewModel = nil
        }

        func testHealthIncreaseAfterFoodUse() throws {
            // Given
            let initialHealth = viewModel.healthBar
            let foodIndex = 0

            // When
            viewModel.handleFoodUse(selectedFoodIndex: foodIndex)

            // Then
            XCTAssertGreaterThan(viewModel.healthBar, initialHealth, "Health should increase after using food.")
        }

        func testFoodQuantityDecreaseAfterUse() throws {
            // Given
            let foodIndex = 0
            let initialQuantity = viewModel.foodItems[foodIndex].quantity

            // When
            viewModel.handleFoodUse(selectedFoodIndex: foodIndex)

            // Then
            XCTAssertEqual(viewModel.foodItems[foodIndex].quantity, initialQuantity - 1, "Food quantity should decrease by 1 after use.")
        }

        func testMaxHealthNotExceeded() throws {
            // Given
            viewModel.healthBar = 0.95 
            let foodIndex = 0

            // When
            viewModel.handleFoodUse(selectedFoodIndex: foodIndex)

            // Then
            XCTAssertLessThanOrEqual(viewModel.healthBar, 1.0, "Health should not exceed 1.0")
        }

        func testAlertShownForInsufficientFood() throws {
            // Given
            let foodIndex = 0 
            viewModel.foodItems[foodIndex].quantity = 0

            // When
            viewModel.handleFoodUse(selectedFoodIndex: foodIndex)

            // Then
            XCTAssertTrue(viewModel.showAlert, "Alert should be shown for insufficient food.")
            XCTAssertEqual(viewModel.alertTitle, "Insufficient \(viewModel.foodItems[foodIndex].name)", "Alert title should match expected.")
        }

        func testAlertShownForMaxHealth() throws {
            // Given
            viewModel.healthBar = 1.0 
            let foodIndex = 0 

            // When
            viewModel.handleFoodUse(selectedFoodIndex: foodIndex)

            // Then
            XCTAssertTrue(viewModel.showAlert, "Alert should be shown when health is at max.")
            XCTAssertEqual(viewModel.alertTitle, "Max Health Reached", "Alert title should match expected.")
        }

}
