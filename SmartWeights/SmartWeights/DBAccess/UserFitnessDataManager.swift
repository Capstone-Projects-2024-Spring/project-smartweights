//
//  UserFitnessDataManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/3/24.
//

import Foundation
import CloudKit

// age, height, user, weight

enum UserFitnessDataRecordKeys: String{
    case type = "UserFitnessData"
    case age
    case height
    // case user
    case weight
}

struct UserFitnessDataModel {
    var recordId: CKRecord.ID?
    var age: Int64
    var height: Int64
    // var user: CKRecord.Reference
    var weight: Int64
}


extension UserFitnessDataModel {
    var record : CKRecord{
        let record = CKRecord(recordType: UserFitnessDataRecordKeys.type.rawValue)
        record[UserFitnessDataRecordKeys.age.rawValue] = age
        record[UserFitnessDataRecordKeys.height.rawValue] = height
        // record[UserFitnessDataRecordKeys.user.rawValue] = user
        record[UserFitnessDataRecordKeys.weight.rawValue] = weight
        return record
    }
}

class UserFitnessDataDBManager : ObservableObject{
    @Published var userFitness: UserFitnessDataModel?
    let CKManager = CloudKitManager()
    var userFitnessDataExists: Bool = false
    
    func createUserFitnessData(){
        let userFitness = UserFitnessDataModel(age: 0, height: 0, weight: 0)
        let userFitnessRecord = userFitness.record
        CKManager.savePrivateItem(record: userFitnessRecord)
        userFitnessDataExists = true
    }
    
    func fetchUserFitnessData(completion: @escaping (UserFitnessDataModel?, Error?) -> Void) {
         CKManager.fetchPrivateRecord(recordType: "UserFitnessData"){ records, error in
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

