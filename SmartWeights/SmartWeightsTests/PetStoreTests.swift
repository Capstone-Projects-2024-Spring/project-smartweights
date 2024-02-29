//
//  PetStoreTests.swift
//  SmartWeightsTests
//
//  Created by Jonathan Stanczak on 2/28/24.
//

import XCTest

class YourTestClass: XCTestCase {

    struct SellingItem: Equatable {
        let name: String
        let price: String

        static func ==(lhs: SellingItem, rhs: SellingItem) -> Bool {
            return lhs.name == rhs.name && lhs.price == rhs.price
        }
    }

    // sort function to test
    private func sortItems(items: [SellingItem], sortByPrice: Bool) -> [SellingItem] {
        if sortByPrice {
            return items.sorted { (item1, item2) in
                let price1 = Int(item1.price) ?? 0
                let price2 = Int(item2.price) ?? 0
                return price1 < price2
            }
        } else {
            return items.sorted { $0.name < $1.name }
        }
    }

    // Testing sort by price.
    func testSortItemsByPrice() {
        let item1 = SellingItem(name: "Dog", price: "600")
        let item2 = SellingItem(name: "Cat", price: "500")
        let item3 = SellingItem(name: "Dino", price: "750")
        let unsortedItems = [item1, item2, item3]

        let sortedItems = sortItems(items: unsortedItems, sortByPrice: true)
        
        XCTAssertEqual(sortedItems, [item2, item1, item3], "Items should be sorted by price ascending")
    }

    // Testing sort by name.
    func testSortItemsByName() {
        // Given
        let item1 = SellingItem(name: "Orange", price: "600")
        let item2 = SellingItem(name: "Apple", price: "500")
        let item3 = SellingItem(name: "Juice", price: "750")
        let unsortedItems = [item1, item2, item3]

        let sortedItems = sortItems(items: unsortedItems, sortByPrice: false)

        XCTAssertEqual(sortedItems, [item2, item3, item1], "Items should be sorted by name alphabetically")
    }
}

