//
//  UserFeedbackDataManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/3/24.
//

import Foundation
import CloudKit

// dateRecorded, dumbbellWeight, formValue, reps, sets, speedValue, user

enum UserFeedbackDataRecordKeys: String{
    case type = "UserFeedbackData"
    case dateRecorded
    case dumbbellWeight
    case formValue
    case reps
    case sets
    case speedValue
    case user
}

struct UserFeedbackDataModel {
    var recordId: CKRecord.ID?
    var dateRecorded: Date
    var dumbbellWeight: Int64
    var formValue: Int64
    var reps: Int64
    var sets: Int64
    var speedValue: Int64
    var user: CKRecord.Reference
}

extension UserFeedbackDataModel {
    var record : CKRecord{
        let record = CKRecord(recordType: UserFeedbackDataRecordKeys.type.rawValue)
        record[UserFeedbackDataRecordKeys.dateRecorded.rawValue] = dateRecorded
        record[UserFeedbackDataRecordKeys.dumbbellWeight.rawValue] = dumbbellWeight
        record[UserFeedbackDataRecordKeys.formValue.rawValue] = formValue
        record[UserFeedbackDataRecordKeys.reps.rawValue] = reps
        record[UserFeedbackDataRecordKeys.sets.rawValue] = sets
        record[UserFeedbackDataRecordKeys.speedValue.rawValue] = speedValue
        record[UserFeedbackDataRecordKeys.user.rawValue] = user
        return record
    }
}

class UserFeedbackDataManager : ObservableObject{
    @Published var userFeedback: UserFeedbackDataModel?
    let CKManager = CloudKitManager()
    
    func createUserFeedback(dateRecorded: Date, dumbbellWeight: Int64, formValue: Int64, reps: Int64, sets: Int64, speedValue: Int64, user: CKRecord.Reference){
        let userFeedback = UserFeedbackDataModel(dateRecorded: dateRecorded, dumbbellWeight: dumbbellWeight, formValue: formValue, reps: reps, sets: sets, speedValue: speedValue, user: user)
        let userFeedbackRecord = userFeedback.record
        CKManager.savePrivateItem(record: userFeedbackRecord)
    }
}
