//
//  PetStoreTests.swift
//  SmartWeightsTests
//
//  Created by Jonathan Stanczak on 4/23/24.
//

import Foundation
import XCTest
@testable import SmartWeights

class StoreViewModelTests: XCTestCase {
    var viewModel: storeViewModel!

    override func setUp() {
        super.setUp()
        viewModel = storeViewModel()
        // Mocks setup if necessary, for example:
        // viewModel.userDBManager = MockUserDBManager()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.userCur, 0, "Initial currency should be 0.")
        XCTAssertEqual(viewModel.selectedCategory, "Pets", "Initial selected category should be 'Pets'.")
        XCTAssertFalse(viewModel.sortByPrice, "Initial sort should not be by price.")
        XCTAssertNotNil(viewModel.items, "Items should not be nil upon initialization.")
    }

    func testSortItemsByPrice() {
        let viewModel = storeViewModel()
        let items = viewModel.items
        let sortedItems = viewModel.sortItems(items: items, sortByPrice: true)
        XCTAssertEqual(sortedItems.map { $0.name }, ["Orange", "Apple", "Juice", "Festive", "Pet Chain", "Floral Glasses", "Bamboo", "Royal", "Dog", "Cat", "Dinosaur"])
    }

    func testSortItemsByName() {
        let viewModel = storeViewModel()
        let items = viewModel.items
        let sortedItems = viewModel.sortItems(items: items, sortByPrice: false)
        XCTAssertEqual(sortedItems.map { $0.name }, ["Apple", "Bamboo", "Cat", "Dinosaur", "Dog", "Festive", "Floral Glasses", "Juice", "Orange", "Pet Chain", "Royal"])
    }

    func testSubtractFunds() {
        let initialCurrency = viewModel.userCur
        viewModel.subtractFunds(price: 100)
        XCTAssertEqual(viewModel.userCur, initialCurrency - 100, "Currency should be decreased by the price of the item.")
    }

    func testPurchaseItem() {
        let initialCurrency = viewModel.userCur
        let item = viewModel.items.first { $0.category != "Foods" }!
        viewModel.purchaseItem(item: item)
        XCTAssert(viewModel.items.contains { $0.id == item.id && $0.isBought == true }, "Item should be marked as bought.")
        XCTAssertEqual(viewModel.userCur, initialCurrency - (Int(item.price) ?? 0), "Currency should be subtracted by item's price.")
    }

    func testAddFunds() {
        let initialCurrency = viewModel.userCur
        viewModel.addFundtoUser(price: 100)
        XCTAssertEqual(viewModel.userCur, initialCurrency + 100, "Currency should be increased by the added amount.")
    }
}
