import XCTest
import CloudKit
@testable import SmartWeights

class InventoryTests: XCTestCase {
    var inventoryDBManager: InventoryDBManager!
    var user: CKRecord.Reference!

    override func setUp() {
        super.setUp()
        // Initialize your InventoryDBManager and user here
        // For example:
        // inventoryDBManager = InventoryDBManager()
        // user = CKRecord.Reference(recordID: CKRecord.ID(recordName: "testUser"), action: .none)
    }

    func testGetCurrency() {
        let expectation = self.expectation(description: "Fetch currency")

        inventoryDBManager.getCurrency(user: user) { currency, error in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(currency, "Currency should not be nil")
            // Add more assertions here if needed

            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testSetCurrency() {
        let newCurrency: Int64 = 1000

        inventoryDBManager.setCurrency(user: user, currency: newCurrency)

        let expectation = self.expectation(description: "Fetch currency after setting it")

        inventoryDBManager.getCurrency(user: user) { currency, error in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertEqual(currency, newCurrency, "Currency should be equal to the new value")

            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}
