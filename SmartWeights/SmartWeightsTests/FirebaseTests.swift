//
//  FirebaseTests.swift
//  SmartWeightsTests
//
//  Created by Daniel Eap on 2/21/24.
//

import XCTest
@testable import SmartWeights

final class FirebaseTests: XCTestCase {

    var firestoreManager: FirestoreManager!
       
       override func setUp() {
           super.setUp()
           firestoreManager = FirestoreManager.shared
       }
       
       override func tearDown() {
           super.tearDown()
           firestoreManager = nil
       }
       
       // Test fetching all documents from a Firestore collection
    func testFetchAllDocumentsFromCollection() {
        // Define expected field values
        let expectedCurrency = 500
        let expectedUserId = 1
        let expectedDocumentId = "1GM4XmU4eehestCkDXbi"
        
        // Call the method to fetch documents
        firestoreManager.fetchMultipleDocuments(collection: "users") { documents, error in
            if let documents = documents {
                var documentFound = false
                // Iterate through the documents
                for document in documents {
                    // Extract the document ID
                    guard let documentId = document["documentId"] as? String else {
                        continue
                    }
                    // Check if the document ID matches the expected ID
                    if documentId == expectedDocumentId {
                        documentFound = true
                        // Assert field values of the document
                        let data = document["data"] as? [String: Any]
                        XCTAssertEqual(data?["currency"] as? Int, expectedCurrency)
                        XCTAssertEqual(data?["user_id"] as? Int, expectedUserId)
                        break // Exit the loop after finding the document
                    }
                }
                // Fail the test if the document with the specified ID is not found
                if !documentFound {
                    XCTFail("Document with ID '\(expectedDocumentId)' not found")
                }
            } else if let error = error {
                XCTFail("Error fetching documents: \(error)")
            }
        }
    }


}
