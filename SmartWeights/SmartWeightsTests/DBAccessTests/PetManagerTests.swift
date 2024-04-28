import XCTest
@testable import SmartWeights

final class PetDBManagerTests: XCTestCase {
    
    var petDBManager: PetDBManager!
    var pet: PetModel!
    override func setUpWithError() throws {
        try super.setUpWithError()
        petDBManager = PetDBManager()
        petDBManager.pet = PetModel(recordId: nil, health: 50,  level: 0, totalXP: 0)
        
        
    }
    
    override func tearDownWithError() throws {
        petDBManager = nil
        try super.tearDownWithError()
    }
    
    func testCreatePet() {
        // Given
        let initialPetExists = petDBManager.petExists
        
        // When
        petDBManager.createPet()
        
        // Then
        XCTAssertTrue(petDBManager.petExists)
        XCTAssertNotEqual(initialPetExists, petDBManager.petExists)
    }
    
    func testFetchPet() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch pet expectation")
        
        // When
        petDBManager.fetchPet { pet, error in
            // Then
            XCTAssertNil(error)
            XCTAssertNotNil(pet)
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    

    func testGetXP() {
        // Given
        let expectation = XCTestExpectation(description: "Get XP expectation")
        
        // When
        petDBManager.getXP { xp, error in
            // Then
            XCTAssertNil(error)
//            XCTAssertNotNil(xp)
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetLevel() {
        // Given
        let expectation = XCTestExpectation(description: "Get level expectation")
        pet = PetModel(recordId: nil, health: 50,  level: 0, totalXP: 0)
        // When
        petDBManager.getLevel { level, error in
            // Then
            XCTAssertNil(error)
            XCTAssertNotNil(level)
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    

    func testUpdateUserXP() {
        // Given
        let newXP: Int64 = 1000
        let expectation = XCTestExpectation(description: "Update user XP expectation")
        pet = PetModel(recordId: nil, health: 50,  level: 0, totalXP: 0)
        // When
        petDBManager.updateUserXP(newXP: newXP) { error in
            // Then
            XCTAssertNil(error)
            XCTAssertEqual(self.petDBManager.totalXP, newXP)
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testUpdateUserLevel() {
        // Given
        let newLevel: Int64 = 1
        let expectation = XCTestExpectation(description: "Update user level expectation")
        
        // When
        petDBManager.updateUserLevel(newLevel: newLevel) { error in
            // Then
            XCTAssertNil(error)
            XCTAssertEqual(self.petDBManager.level, newLevel)
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    
    
}
