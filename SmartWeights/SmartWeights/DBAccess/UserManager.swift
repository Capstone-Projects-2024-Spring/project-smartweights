//
//  UserManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/2/24.
//

import Foundation
import CloudKit


enum UserRecordKeys: String{
    case type = "User"
    case firstName
    case lastName
    case latestLogin
    case currency
    case Users
}
struct User {
    var recordId: CKRecord.ID?
    var firstName: String
    var lastName: String
    var latestLogin: Date
    var currency: Int64
    var Users: CKRecord.Reference
}
extension User {
    var record : CKRecord{
        let record = CKRecord(recordType: UserRecordKeys.type.rawValue)
        record[UserRecordKeys.firstName.rawValue] = firstName
        record[UserRecordKeys.lastName.rawValue] = lastName
        record[UserRecordKeys.latestLogin.rawValue] = latestLogin
        record[UserRecordKeys.currency.rawValue] = currency
        record[UserRecordKeys.Users.rawValue] = Users
        return record
    }
}

class UserDBManager : ObservableObject{
    @Published var user: User?
    @Published var userRecord: CKRecord.Reference?
    let CKManager = CloudKitManager()
    
    // func fetchUser(completion: @escaping (User?, Error?) -> Void) {
    //     CKManager.fetchRecord(recordType: UserRecordKeys.type.rawValue) { records, error in
    //         guard let record = records?.first else {
    //             completion(nil, error)
    //             print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
    //             return
    //         }
    
    //         let firstName = record[UserRecordKeys.firstName.rawValue] as? String ?? ""
    //         let lastName = record[UserRecordKeys.lastName.rawValue] as? String ?? ""
    //         let latestLogin = record[UserRecordKeys.latestLogin.rawValue] as? Date ?? Date()
    //         let currency = record[UserRecordKeys.currency.rawValue] as? Int64 ?? 0
    //         let users = record[UserRecordKeys.Users.rawValue] as? CKRecord.Reference ?? CKRecord.Reference(recordID: CKRecord.ID(recordName: ""), action: .none)
    
    //         let user = User(recordId: record.recordID, firstName: firstName, lastName: lastName, latestLogin: latestLogin, currency: currency, Users: users)
    //         completion(user, nil)
    //     }
    // }
    
    init(){
        fetchCurrentUserRecordID { error in
            if let error = error {
                print("Error fetching current user record ID: \(error.localizedDescription)")
            }
        }
    }
    // this function grabs the record name of the current user found in the "Users" record type
    func fetchCurrentUserRecordID(completion: @escaping (Error?) -> Void) {
        CKManager.container.fetchUserRecordID { [weak self] (recordID, error) in
            DispatchQueue.main.async{
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
    
    func createUser(firstName: String?, lastName: String?){
        let user = User(recordId: nil, firstName: firstName ?? "", lastName: lastName ?? "", latestLogin: Date(), currency: 0, Users: userRecord!)
        let userRecord = user.record
        CKManager.savePrivateItem(record: userRecord)
    }
    
    func fetchUser(completion: @escaping (User?, Error?) -> Void){
        CKManager.fetchPrivateRecord(recordType: "User"){ records, error in
            if let error = error {
                // Handle the case where there was an error fetching the records
                print("Error fetching user: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let record = records?.first else {
                // Handle the case where no records were found
                print("No user record found")
                completion(nil, nil)
                return
            }
            
            // Handle the case where a record was found
            let firstName = record[UserRecordKeys.firstName.rawValue] as? String ?? ""
            let lastName = record[UserRecordKeys.lastName.rawValue] as? String ?? ""
            let latestLogin = record[UserRecordKeys.latestLogin.rawValue] as? Date ?? Date()
            let currency = record[UserRecordKeys.currency.rawValue] as? Int64 ?? 0
            let users = record[UserRecordKeys.Users.rawValue] as? CKRecord.Reference ?? CKRecord.Reference(recordID: CKRecord.ID(recordName: ""), action: .none)
            
            self.user = User(recordId: record.recordID, firstName: firstName, lastName: lastName, latestLogin: latestLogin, currency: currency, Users: users)
            completion(self.user, nil)
            
        }
    }
    
    
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
    
    //     function to help check if User (not Users) exists already
    func userRecordExistsInUsers(completion: @escaping (Bool, Error?) -> Void) {
        guard let userRecord = userRecord else {
            completion(false, nil) // userRecord not fetched yet
            return
        }
        
        let database = CKContainer.default().publicCloudDatabase
        let predicate = NSPredicate(format: "Users == %@", userRecord)
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                completion(false, error)
            } else if let records = records, !records.isEmpty {
                completion(true, nil) // userRecord exists in Users record type
                print("exists")
                print("ExistsRecord: \(records)")
                //                return true
            } else {
                completion(false, nil) // userRecord does not exist in Users record type
                print("does not exist")
                //                return false
            }
        }
    }
    
    
}

