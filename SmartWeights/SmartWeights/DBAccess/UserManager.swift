//
//  UserManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/2/24.
//

import Foundation
import CloudKit

/// Enum defining the keys for the User record type.
enum UserRecordKeys: String {
    case type = "User"
    case firstName
    case lastName
    case latestLogin
    case currency
    case email
    // case Users
}

/// Struct representing a User.
struct User {
    var recordId: CKRecord.ID?
    var firstName: String
    var lastName: String
    var latestLogin: Date
    var currency: Int64
    var email: String
    // var Users: CKRecord.Reference
}

extension User {
    /// Computed property that returns the CKRecord representation of the User.
    var record: CKRecord {
        let record = CKRecord(recordType: UserRecordKeys.type.rawValue)
        record[UserRecordKeys.firstName.rawValue] = firstName
        record[UserRecordKeys.lastName.rawValue] = lastName
        record[UserRecordKeys.latestLogin.rawValue] = latestLogin
        record[UserRecordKeys.currency.rawValue] = currency
        record[UserRecordKeys.email.rawValue] = email
        // record[UserRecordKeys.Users.rawValue] = Users
        return record
    }
}

/// Class responsible for managing User records in the database.
class UserDBManager: ObservableObject {
    @Published var user: User?
    @Published var userRecord: CKRecord.Reference?
    var userExists: Bool = false
    let CKManager = CloudKitManager()
    
    /// Initializes the UserDBManager and fetches the current user record ID and user data.
    init() {
        fetchCurrentUserRecordID { error in
            if let error = error {
                print("Error fetching current user record ID: \(error.localizedDescription)")
            }
        }
        fetchUser { user, error in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
            }
        }
    }
    
    /// Fetches the record ID of the current user.
    func fetchCurrentUserRecordID(completion: @escaping (Error?) -> Void) {
        CKManager.container.fetchUserRecordID { [weak self] (recordID, error) in
            DispatchQueue.main.async {
                if let recordID = recordID {
                    let userRecordReference = CKRecord.Reference(recordID: recordID, action: .none)
                    self?.userRecord = userRecordReference
                    completion(nil)
                } else if let error = error {
                    completion(error)
                }
            }
        }
    }
    
    /// Creates a new user with the given information.
    func createUser(firstName: String?, lastName: String?, email: String?) {
        if userExists {
            print("User already exists, not creating new user")
            return
        }
        
        let user = User(recordId: nil, firstName: firstName ?? "", lastName: lastName ?? "", latestLogin: Date(), currency: 0, email: email ?? "")
        let userRecord = user.record
        CKManager.savePrivateItem(record: userRecord)
        userExists = true
    }
    
    /// Fetches the user data from the database.
    func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "User") { records, error in
            if let error = error {
                // Handle the case where there was an error fetching the records
                print("Error fetching user: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let record = records?.first else {
                // Handle the case where no records were found
                self.userExists = false
                print("No user record found")
                completion(nil, nil)
                return
            }
            
            // Handle the case where a record was found
            
            let firstName = record[UserRecordKeys.firstName.rawValue] as? String ?? ""
            let lastName = record[UserRecordKeys.lastName.rawValue] as? String ?? ""
            let latestLogin = record[UserRecordKeys.latestLogin.rawValue] as? Date ?? Date()
            let currency = record[UserRecordKeys.currency.rawValue] as? Int64 ?? 0
            let email = record[UserRecordKeys.email.rawValue] as? String ?? ""
            // let users = record[UserRecordKeys.Users.rawValue] as? CKRecord.Reference ?? CKRecord.Reference(recordID: CKRecord.ID(recordName: ""), action: .none)
            
            self.user = User(recordId: record.recordID, firstName: firstName, lastName: lastName, latestLogin: latestLogin, currency: currency, email: email)
            completion(self.user, nil)
            self.userExists = true
        }
    }
    
    /// Retrieves the currency value of the user.
    func getCurrency(completion: @escaping (Int64?, Error?) -> Void) {
        if let user = user {
            completion(user.currency, nil)
        } else {
            fetchUser { user, error in
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(self.user?.currency, nil)
                }
            }
        }
    }
    
    /// Updates the currency value of the user.
    func updateCurrency(newCurrency: Int64, completion: @escaping (Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "User") { records, error in
            guard let record = records?.first else {
                print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                completion(error)
                return
            }
            
            let currencyValue = NSNumber(value: newCurrency)
            record[UserRecordKeys.currency.rawValue] = currencyValue as CKRecordValue
            self.CKManager.savePrivateItem(record: record)
            completion(nil)
        }
    }
    
    /// Retrieves the full name of the user.
    func getName(completion: @escaping (String?, Error?) -> Void) {
        if let user = user {
            let name = "\(user.firstName) \(user.lastName)"
            completion(name, nil)
        } else {
            fetchUser { user, error in
                if let error = error {
                    completion(nil, error)
                } else {
                    let name = "\(self.user?.firstName ?? "") \(self.user?.lastName ?? "")"
                    completion(name, nil)
                }
            }
        }
    }
    
    /// Updates the first name and/or last name of the user.
    func updateName(newFirstName: String?, newLastName: String?, completion: @escaping (Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "User") { records, error in
            guard let record = records?.first else {
                print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                completion(error)
                return
            }
            
            if let newFirstName = newFirstName {
                record[UserRecordKeys.firstName.rawValue] = newFirstName as CKRecordValue?
            }
            if let newLastName = newLastName {
                record[UserRecordKeys.lastName.rawValue] = newLastName as CKRecordValue?
            }
            self.CKManager.savePrivateItem(record: record)
            completion(nil)
        }
    }
    
    /// Checks if the user record exists in the "Users" record type.
//    func userRecordExistsInUsers(completion: @escaping (Bool, Error?) -> Void) {
//        guard let userRecord = userRecord else {
//            completion(false, nil) // userRecord not fetched yet
//            return
//        }
//        
//        let database = CKContainer.default().publicCloudDatabase
//        let predicate = NSPredicate(format: "Users == %@", userRecord)
//        let query = CKQuery(recordType: "User", predicate: predicate)
//        
//        database.perform(query, inZoneWith: nil) { (records, error) in
//            if let error = error {
//                completion(false, error)
//            } else if let records = records, !records.isEmpty {
//                completion(true, nil) // userRecord exists in Users record type
//                print("exists")
//                print("ExistsRecord: \(records)")
//            } else {
//                completion(false, nil) // userRecord does not exist in Users record type
//                print("does not exist")
//            }
//        }
//    }
}
