//
//  UserFeedbackDataManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/3/24.
//

import Foundation
import CloudKit

/// Enum defining the keys for the UserFeedbackData record type.
enum UserFeedbackDataRecordKeys: String {
    case type = "UserFeedbackData"
    case dateRecorded
    case dumbbellWeight
    case formValue
    case reps
    case sets
    case speedValue
    // case user
}

/// Struct representing the UserFeedbackData model.
struct UserFeedbackDataModel {
    var recordId: CKRecord.ID?
    var dateRecorded: Date
    var dumbbellWeight: Int64
    var formValue: Int64
    var reps: Int64
    var sets: Int64
    var speedValue: Int64
    // var user: CKRecord.Reference
}

extension UserFeedbackDataModel {
    /// Computed property that returns a CKRecord representation of the UserFeedbackData model.
    var record: CKRecord {
        let record = CKRecord(recordType: UserFeedbackDataRecordKeys.type.rawValue)
        record[UserFeedbackDataRecordKeys.dateRecorded.rawValue] = dateRecorded
        record[UserFeedbackDataRecordKeys.dumbbellWeight.rawValue] = dumbbellWeight
        record[UserFeedbackDataRecordKeys.formValue.rawValue] = formValue
        record[UserFeedbackDataRecordKeys.reps.rawValue] = reps
        record[UserFeedbackDataRecordKeys.sets.rawValue] = sets
        record[UserFeedbackDataRecordKeys.speedValue.rawValue] = speedValue
        // record[UserFeedbackDataRecordKeys.user.rawValue] = user
        return record
    }
}

/// Class responsible for managing user feedback data in the database.
class UserFeedbackDataDBManager: ObservableObject {
    @Published var userFeedback: UserFeedbackDataModel?
    let CKManager = CloudKitManager()
    
    /// Creates a new user feedback record in the database.
    /// - Parameters:
    ///   - dateRecorded: The date when the feedback was recorded.
    ///   - dumbbellWeight: The weight of the dumbbell used.
    ///   - formValue: The value representing the form of the exercise.
    ///   - reps: The number of repetitions performed.
    ///   - sets: The number of sets performed.
    ///   - speedValue: The value representing the speed of the exercise.
    func createUserFeedback(dateRecorded: Date, dumbbellWeight: Int64, formValue: Int64, reps: Int64, sets: Int64, speedValue: Int64) {
        let userFeedback = UserFeedbackDataModel(dateRecorded: dateRecorded, dumbbellWeight: dumbbellWeight, formValue: formValue, reps: reps, sets: sets, speedValue: speedValue)
        let userFeedbackRecord = userFeedback.record
        CKManager.savePrivateItem(record: userFeedbackRecord)
    }
}
