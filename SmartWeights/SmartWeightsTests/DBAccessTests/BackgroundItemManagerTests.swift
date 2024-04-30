import XCTest
@testable import SmartWeights

final class BackgroundItemManagerTests: XCTestCase {

    var backgroundItemManager: BackgroundItemDBManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        backgroundItemManager = BackgroundItemDBManager()
        backgroundItemManager.backgroundItems = [BackgroundItemModel(recordId: nil, isActive: 0, imageName: "exampleImageName")]
    }

    override func tearDownWithError() throws {
        backgroundItemManager = nil
        try super.tearDownWithError()
    }

    func testFetchBackgroundItems() throws {
        let expectation = XCTestExpectation(description: "Fetch background items")
        
        backgroundItemManager.fetchBackgroundItems { backgroundItems, error in
            XCTAssertNil(error, "Error fetching background items: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(backgroundItems, "Background items should not be nil")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchSpecificBackgroundItem() throws {
        let expectation = XCTestExpectation(description: "Fetch specific background item")
        let imageName = "exampleImageName"
        
        backgroundItemManager.fetchSpecifcBackgroundItem(imageName: imageName) { backgroundItem, error in
            XCTAssertNil(error, "Error fetching specific background item: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(backgroundItem, "Background item should not be nil")
            XCTAssertEqual(backgroundItem?.imageName, imageName, "Incorrect image name")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testCreateBackgroundItem() throws {
        let expectation = XCTestExpectation(description: "Create background item")
        let imageName = "exampleImageName"
        
        backgroundItemManager.createBackgroundItem(imageName: imageName) { error in
            XCTAssertNil(error, "Error creating background item: \(error?.localizedDescription ?? "")")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

//    func testSetActiveBackgroundItem() throws {
//        let expectation = XCTestExpectation(description: "Set active background item")
//        let imageName = "exampleImageName"
//        
//        backgroundItemManager.setActiveBackgroundItem(imageName: imageName) { activeBackground, error in
//            XCTAssertNil(error, "Error setting active background item: \(error?.localizedDescription ?? "")")
//            XCTAssertEqual(activeBackground, imageName, "Incorrect active background item")
//            
//            expectation.fulfill()
//        }
//        }
//        
//        wait(for: [expectation], timeout: 5.0)
//    }

    func testSetUnactiveAllBackgroundItems() throws {
        let expectation = XCTestExpectation(description: "Set unactive all background items")
        
        backgroundItemManager.setUnactiveAllBackgroundItems { error in
            XCTAssertNil(error, "Error setting unactive all background items: \(error?.localizedDescription ?? "")")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testGetActiveBackground() throws {
        let activeBackground = backgroundItemManager.g_getActiveBackground()
        XCTAssertEqual(activeBackground, "", "Incorrect active background")
    }

    static var allTests = [
        ("testFetchBackgroundItems", testFetchBackgroundItems),
        ("testFetchSpecificBackgroundItem", testFetchSpecificBackgroundItem),
        ("testCreateBackgroundItem", testCreateBackgroundItem),
//        ("testSetActiveBackgroundItem", testSetActiveBackgroundItem),
        ("testSetUnactiveAllBackgroundItems", testSetUnactiveAllBackgroundItems),
        ("testGetActiveBackground", testGetActiveBackground)
    ]
}
