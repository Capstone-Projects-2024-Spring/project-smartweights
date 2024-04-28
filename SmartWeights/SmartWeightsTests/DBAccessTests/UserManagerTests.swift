import XCTest
@testable import SmartWeights

final class UserDBManagerTests: XCTestCase {
    var userDBManager: UserDBManager!
    
    override func setUpWithError() throws {
        userDBManager = UserDBManager()
    }
    
    override func tearDownWithError() throws {
        userDBManager = nil
    }
    
    func testCreateUser() {
        // Given
        let firstName = "John"
        let lastName = "Doe"
        let email = "john.doe@example.com"
        
        // When
        userDBManager.createUser(firstName: firstName, lastName: lastName, email: email)
        
        // Then
        XCTAssertTrue(userDBManager.userExists)
    }
    
    func testFetchUser() {
        // When
        userDBManager.fetchUser { user, error in
            // Then
            XCTAssertNotNil(user)
            XCTAssertNil(error)
        }
    }
    
    func testGetCurrency() {
        // When
        userDBManager.getCurrency { currency, error in
            // Then
            XCTAssertNotNil(currency)
            XCTAssertNil(error)
        }
    }
    
    func testUpdateCurrency() {
        // Given
        let newCurrency: Int64 = 100
        
        // When
        userDBManager.updateCurrency(newCurrency: newCurrency) { error in
            // Then
            XCTAssertNil(error)
        }
    }
    
    func testGetName() {
        // When
        userDBManager.getName { name, error in
            // Then
            XCTAssertNotNil(name)
            XCTAssertNil(error)
        }
    }
    
    func testUpdateName() {
        // Given
        let newFirstName = "Jane"
        let newLastName = "Smith"
        
        // When
        userDBManager.updateName(newFirstName: newFirstName, newLastName: newLastName) { error in
            // Then
            XCTAssertNil(error)
        }
    }
}
