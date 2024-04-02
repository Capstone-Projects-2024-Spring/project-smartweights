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
    let CKManager = CloudKitManager()
    
    
}
