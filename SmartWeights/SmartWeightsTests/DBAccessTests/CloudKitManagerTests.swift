
import XCTest
import CloudKit
@testable import SmartWeights

final class CloudKitManagerTests: XCTestCase {

    var cloudKitManager: CloudKitManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        cloudKitManager = CloudKitManager.shared
    }

    override func tearDownWithError() throws {
        cloudKitManager = nil
        try super.tearDownWithError()
    }

    func testSaveItem() throws {
        // Given
        let record = CKRecord(recordType: "TestRecord")
        
        // When
        cloudKitManager.saveItem(record: record)
        
        // Then
        // Add your assertions here
    }
    
    func testSavePrivateItem() throws {
        // Given
        let record = CKRecord(recordType: "TestRecord")
        
        // When
        cloudKitManager.savePrivateItem(record: record)
        
        // Then
        // Add your assertions here
    }
    
    func testFetchPublicRecord() throws {
        // Given
        let recordType = "TestRecord"
        
        // When
        cloudKitManager.fetchPublicRecord(recordType: recordType) { (records, error) in
            // Then
            // Add your assertions here
        }
    }
    
    func testFetchPrivateRecord() throws {
        // Given
        let recordType = "TestRecord"
        
        // When
        cloudKitManager.fetchPrivateRecord(recordType: recordType) { (records, error) in
            // Then
            // Add your assertions here
        }
    }
    
    func testFetchPrivateRecordByID() throws {
        // Given
        let recordID = CKRecord.ID(recordName: "TestRecordID")
        
        // When
        cloudKitManager.fetchPrivateRecord(recordID: recordID) { (record, error) in
            // Then
            // Add your assertions here
        }
    }
    
    // Add more test cases as needed
    
}
