//
//  UserFitnessDataManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/3/24.
//

import Foundation
import CloudKit

/// Keys for the UserFitnessData record in CloudKit.
enum UserFitnessDataRecordKeys: String {
    case type = "UserFitnessData"
    case age
    case height
    // case user
    case weight
}

/// Model representing user fitness data.
struct UserFitnessDataModel {
    var recordId: CKRecord.ID?
    var age: Int64
    var height: Int64
    // var user: CKRecord.Reference
    var weight: Int64
}

extension UserFitnessDataModel {
    /// Converts the UserFitnessDataModel to a CKRecord.
    var record: CKRecord {
        let record = CKRecord(recordType: UserFitnessDataRecordKeys.type.rawValue)
        record[UserFitnessDataRecordKeys.age.rawValue] = age
        record[UserFitnessDataRecordKeys.height.rawValue] = height
        // record[UserFitnessDataRecordKeys.user.rawValue] = user
        record[UserFitnessDataRecordKeys.weight.rawValue] = weight
        return record
    }
}

/// Manager class for handling user fitness data in the CloudKit database.
class UserFitnessDataDBManager: ObservableObject {
    @Published var userFitness: UserFitnessDataModel?
    let CKManager = CloudKitManager()
    var userFitnessDataExists: Bool = false
    
    init() {
        fetchUserFitnessData { userFitness, error in
            if let error = error {
                print("Error fetching user fitness data: \(error.localizedDescription)")
                return
            }
            // guard let userFitness = userFitness else {
            //     print("No user fitness data found")
            //     return
            // }
            // self.userFitness = userFitness
        }
    }
    
    /// Creates user fitness data in the CloudKit database.
    func createUserFitnessData() {
        if userFitnessDataExists {
            print("User fitness data exists, not creating")
            return
        }
        let userFitness = UserFitnessDataModel(age: 0, height: 0, weight: 0)
        let userFitnessRecord = userFitness.record
        CKManager.savePrivateItem(record: userFitnessRecord)
        userFitnessDataExists = true
    }
    
    /// Fetches user fitness data from the CloudKit database.
    /// - Parameter completion: A closure to be called when the fetch operation is complete. The closure takes two parameters: the fetched UserFitnessDataModel and an optional Error.
    func fetchUserFitnessData(completion: @escaping (UserFitnessDataModel?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "UserFitnessData") { records, error in
            if let error = error {
                // Handle the case where there was an error fetching the records
                print("Error fetching user fitness data: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let record = records?.first else {
                // Handle the case where no records were found
                self.userFitnessDataExists = false
                print("No user fitness data record found")
                completion(nil, nil)
                return
            }
            
            self.userFitnessDataExists = true
            let age = record[UserFitnessDataRecordKeys.age.rawValue] as? Int64 ?? 0
            let height = record[UserFitnessDataRecordKeys.height.rawValue] as? Int64 ?? 0
            let weight = record[UserFitnessDataRecordKeys.weight.rawValue] as? Int64 ?? 0
            
            let userFitnessData = UserFitnessDataModel(age: age, height: height, weight: weight)
            completion(userFitnessData, nil)
        }
    }
}
