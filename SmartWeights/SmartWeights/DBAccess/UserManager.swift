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

    func fetchUser(completion: @escaping (User?, Error?) -> Void){
        CKManager.fetchPrivateRecord(recordType: "User"){ records, error in
            guard let record = records?.first else {
                completion(nil, error)
                print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
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
        CKManager.fetchRecord(recordType: "User") { records, error in
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
}
