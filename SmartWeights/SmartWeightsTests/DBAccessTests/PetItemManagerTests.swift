
import XCTest
@testable import SmartWeights

final class PetItemManagerTests: XCTestCase {
    
    var petItemManager: PetItemDBManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        petItemManager = PetItemDBManager()
        petItemManager.petItems = [
            PetItemModel(recordId: nil, isActive:1, petName:"",imageName: "Dog"),
            PetItemModel(recordId: nil, isActive:0, petName:"",imageName: "Cat")
        ]
    }
    
    override func tearDownWithError() throws {
        petItemManager = nil
        try super.tearDownWithError()
    }
    
    func testFetchPetItems() throws {
        let expectation = XCTestExpectation(description: "Fetch pet items")
        
        petItemManager.fetchPetItems { petItems, error in
            XCTAssertNil(error, "Error fetching pet items: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(petItems, "Pet items should not be nil")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchSpecificPetItem() throws {
        let expectation = XCTestExpectation(description: "Fetch specific pet item")
        let imageName = "Dog"
        
        petItemManager.fetchSpecificPetItem(imageName: imageName) { petItem, error in
            XCTAssertNil(error, "Error fetching specific pet item: \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(petItem, "Pet item should not be nil")
            XCTAssertEqual(petItem?.imageName, imageName, "Incorrect pet item fetched")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCreatePetItem() throws {
        let expectation = XCTestExpectation(description: "Create pet item")
        let imageName = "Cat"
        
        petItemManager.createPetItem(imageName: imageName) { error in
            XCTAssertNil(error, "Error creating pet item: \(error?.localizedDescription ?? "")")
            
            // Verify that the pet item was created
            let petItem = self.petItemManager.petItems.first(where: { $0.imageName == imageName })
            XCTAssertNotNil(petItem, "Pet item should not be nil")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSetActivePetItem() throws {
        let expectation = XCTestExpectation(description: "Set active pet item")
        let imageName = "Dog"
        
        petItemManager.setActivePetItem(imageName: imageName) { activePet, error in
            XCTAssertNil(error, "Error setting active pet item: \(error?.localizedDescription ?? "")")
            XCTAssertEqual(activePet, imageName, "Active pet item is incorrect")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetActivePet() throws {
        let expectation = XCTestExpectation(description: "Get active pet")
        let expectedActivePet = "Dog"
        
        petItemManager.getActivePet { activePet, error in
            XCTAssertNil(error, "Error getting active pet: \(error?.localizedDescription ?? "")")
            XCTAssertEqual(activePet, expectedActivePet, "Active pet is incorrect")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
