//
//  CloudKitTest.swift
//  SmartWeightsTests
//
//  Created by Daniel Eap on 2/29/24.
//

import XCTest
import CloudKit
final class CloudKitTest: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    let containerIdentifier = "iCloud.SmartWeights"
    
    // Provide the record name you created
    let recordName = "4CC49078-D2C2-49C9-866F-3CFCED9D769E"
    
    func testCloudKitContainerInitialization() {
        // Initialize a CloudKit container
        let container = CKContainer(identifier: containerIdentifier)
        
        // Assert that the container is not nil
        XCTAssertNotNil(container, "CloudKit container should not be nil")
    
        let defaultDatabase = container.privateCloudDatabase
            
        // Assert that the default database is not nil
        XCTAssertNotNil(defaultDatabase, "Default database should not be nil")
        
    }
    
    
    func testFetchRecord() {
        // Initialize a CloudKit container
       let container = CKContainer(identifier: containerIdentifier)
       
       // Access the default database of the container
       let defaultDatabase = container.publicCloudDatabase
       
       // Create a record ID for the record you want to fetch
       let recordID = CKRecord.ID(recordName: recordName)
       
       // Create an expectation for the async fetch operation
       let fetchExpectation = expectation(description: "Fetch Record")
        
        // Fetch the record from the default database
                defaultDatabase.fetch(withRecordID: recordID) { (record, error) in
                    if let error = error {
                        XCTFail("Error fetching record: \(error.localizedDescription)")
                    } else {
                        // Assert that the fetched record is not nil
                        XCTAssertNotNil(record, "Fetched record should not be nil")
                        
                        // Fulfill the expectation
                        fetchExpectation.fulfill()
                    }
                }
                
                // Wait for the expectation to be fulfilled
                waitForExpectations(timeout: 10, handler: nil)
    }
    func testFetchRecordAndCheckCurrency() {

            // Initialize a CloudKit container
            let container = CKContainer(identifier: containerIdentifier)
            
            // Access the public database of the container
            let publicDatabase = container.publicCloudDatabase
            
            // Create a record ID for the record you want to fetch
            let recordID = CKRecord.ID(recordName: recordName)
            
            // Create an expectation for the async fetch operation
            let fetchExpectation = expectation(description: "Fetch Record")
            
            // Fetch the record from the public database
            publicDatabase.fetch(withRecordID: recordID) { (record, error) in
                if let error = error {
                    XCTFail("Error fetching record: \(error.localizedDescription)")
                } else {
                    // Assert that the fetched record is not nil
                    XCTAssertNotNil(record, "Fetched record should not be nil")
                    
                    // Check if the currency field is 500
                    if let currency = record?["Currency"] as? Int {
                        XCTAssertEqual(currency, 600, "Currency should be 500")
                    } else {
                        XCTFail("Currency field not found or not an integer")
                    }
                    
                    // Fulfill the expectation
                    fetchExpectation.fulfill()
                }
            }
            
            // Wait for the expectation to be fulfilled
            waitForExpectations(timeout: 10, handler: nil)
        }
  
    let userID = "0366F60C-D346-4EC7-8A83-ADBDD5083C49"
    func testFetchUserPetCount() {
            let container = CKContainer(identifier: containerIdentifier)
            let defaultDatabase = container.publicCloudDatabase
            let userReference = CKRecord.Reference(recordID: CKRecord.ID(recordName: userID), action: .none)
            let predicate = NSPredicate(format: "user == %@", userReference)
            let query = CKQuery(recordType: "Pet", predicate: predicate)
            
            let fetchExpectation = expectation(description: "Fetch User Pet Count")
            
            defaultDatabase.perform(query, inZoneWith: nil) { (records, error) in
                if let error = error {
                    XCTFail("Error fetching user pet count: \(error.localizedDescription)")
                } else {
                    XCTAssertNotNil(records, "Fetched records should not be nil")
                    XCTAssertEqual(records?.count ?? 0, 2, "Pet count for user \(self.userID) should be 2")
                    fetchExpectation.fulfill()
                }
            }
            
            waitForExpectations(timeout: 10, handler: nil)
        }
    
}


