//
//  LoginViewModel.swift
//  SmartWeights
//
//  Created by Daniel Eap on 3/22/24.
//

import Foundation
import CloudKit


class LoginViewModel: ObservableObject {
    

//TODO: functionality for creating a userRecord if not exists, by calling userManager.createUser()
    
//    func addUserRecordIfNotExists() {
//        // Fetch the current user's record ID
//        userRecordManager.fetchCurrentUserRecordID { [weak self] (recordID, error) in
//            if let error = error {
//                print("Error fetching current user record ID: \(error)")
//            } else if let recordID = recordID {
//                // Create a reference to the current user's record
//                let userRecordReference = CKRecord.Reference(recordID: recordID, action: .none)
//                
//                // Check if a user record already exists
//                self?.CKManager.fetchUserRecord { (userRecord, error) in
//                    if let error = error {
//                        print("Error fetching user record: \(error)")
//                    } else if let userRecord = userRecord {
//                        // If a user record already exists, update it
//                        self?.updateUserRecord(userRecord, with: userRecordReference)
//                    } else {
//                        // If a user record doesn't exist, create a new one
//                        self?.createNewUserRecord(with: userRecordReference)
//                    }
//                }
//            }
//        }
//    }
//    
//    private func updateUserRecord(_ userRecord: CKRecord, with userRecordReference: CKRecord.Reference) {
//        // Update the existing user record with the new user reference
//        userRecord[UserRecordKeys.Users.rawValue] = userRecordReference
//        
//        CKManager.saveRecord(userRecord) { (savedRecord, error) in
//            if let error = error {
//                print("Error updating user record: \(error)")
//            } else {
//                print("User record updated successfully")
//            }
//        }
//    }
//    
//    private func createNewUserRecord(with userRecordReference: CKRecord.Reference) {
//        // Create a new user record with the provided user reference
//        let newUser = User(firstName: "John", lastName: "Doe", latestLogin: Date(), Users: userRecordReference)
//        
//        // Save the new user record
//        CKManager.saveRecord(newUser.record) { (savedRecord, error) in
//            if let error = error {
//                print("Error creating user record: \(error)")
//            } else {
//                print("User record created successfully")
//            }
//        }
//    }
    
}
