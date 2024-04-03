//
//  UserFitnessPlanManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/3/24.
//

import Foundation
import CloudKit

// numberWorkoutDays, user, weightGoal

enum UserFitnessPlanRecordKeys: String{
    case type = "UserFitnessPlan"
    case numberWorkoutDays
    // case user
    case weightGoal
}

struct UserFitnessPlanModel {
    var recordId: CKRecord.ID?
    var numberWorkoutDays: Int64
    // var user: CKRecord.Reference
    var weightGoal: Int64
}

extension UserFitnessPlanModel {
    var record : CKRecord{
        let record = CKRecord(recordType: UserFitnessPlanRecordKeys.type.rawValue)
        record[UserFitnessPlanRecordKeys.numberWorkoutDays.rawValue] = numberWorkoutDays
        // record[UserFitnessPlanRecordKeys.user.rawValue] = user
        record[UserFitnessPlanRecordKeys.weightGoal.rawValue] = weightGoal
        return record
    }
}

class UserFitnessPlanDBManager : ObservableObject{
    @Published var userFitnessPlan: UserFitnessPlanModel?
    let CKManager = CloudKitManager()
    
    func createUserFitnessPlan(numberWorkoutDays: Int64, weightGoal: Int64){
        let userFitnessPlan = UserFitnessPlanModel(numberWorkoutDays: numberWorkoutDays, weightGoal: weightGoal)
        let userFitnessPlanRecord = userFitnessPlan.record
        CKManager.savePrivateItem(record: userFitnessPlanRecord)
    }
}
