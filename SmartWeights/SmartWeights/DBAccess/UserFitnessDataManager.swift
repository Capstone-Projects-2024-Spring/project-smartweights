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
    case user
    case weight
}

struct UserFitnessDataModel {
    var recordId: CKRecord.ID?
    var age: Int64
    var height: Int64
    var user: CKRecord.Reference
    var weight: Int64
}


extension UserFitnessDataModel {
    var record : CKRecord{
        let record = CKRecord(recordType: UserFitnessDataRecordKeys.type.rawValue)
        record[UserFitnessDataRecordKeys.age.rawValue] = age
        record[UserFitnessDataRecordKeys.height.rawValue] = height
        record[UserFitnessDataRecordKeys.user.rawValue] = user
        record[UserFitnessDataRecordKeys.weight.rawValue] = weight
        return record
    }
}

class UserFitnessDataManager : ObservableObject{
    @Published var userFitness: UserFitnessDataModel?
    let CKManager = CloudKitManager()
    
    func createUserFitness(age: Int64, height: Int64, user: CKRecord.Reference, weight: Int64){
        let userFitness = UserFitnessDataModel(age: age, height: height, user: user, weight: weight)
        let userFitnessRecord = userFitness.record
        CKManager.savePrivateItem(record: userFitnessRecord)
    }
}
