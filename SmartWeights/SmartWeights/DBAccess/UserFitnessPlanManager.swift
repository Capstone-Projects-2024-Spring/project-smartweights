//
//  UserFitnessPlanManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/3/24.
//

import Foundation
import CloudKit

/// Enum defining the keys for the UserFitnessPlan record type.
enum UserFitnessPlanRecordKeys: String {
    case type = "UserFitnessPlan"
    case numberWorkoutDays
    // case user
    case weightGoal
}

/// Struct representing the UserFitnessPlan model.
struct UserFitnessPlanModel {
    var recordId: CKRecord.ID?
    var numberWorkoutDays: Int64
    // var user: CKRecord.Reference
    var weightGoal: Int64
}

extension UserFitnessPlanModel {
    /// Computed property that returns a CKRecord representation of the UserFitnessPlan model.
    var record: CKRecord {
        let record = CKRecord(recordType: UserFitnessPlanRecordKeys.type.rawValue)
        record[UserFitnessPlanRecordKeys.numberWorkoutDays.rawValue] = numberWorkoutDays
        // record[UserFitnessPlanRecordKeys.user.rawValue] = user
        record[UserFitnessPlanRecordKeys.weightGoal.rawValue] = weightGoal
        return record
    }
}

/// Class responsible for managing the UserFitnessPlan in the database.
class UserFitnessPlanDBManager: ObservableObject {
    @Published var userFitnessPlan: UserFitnessPlanModel?
    let CKManager = CloudKitManager()
    
    /// Creates a new UserFitnessPlan record in the database.
    /// - Parameters:
    ///   - numberWorkoutDays: The number of workout days for the user's fitness plan.
    ///   - weightGoal: The weight goal for the user's fitness plan.
    func createUserFitnessPlan(numberWorkoutDays: Int64, weightGoal: Int64) {
        let userFitnessPlan = UserFitnessPlanModel(numberWorkoutDays: numberWorkoutDays, weightGoal: weightGoal)
        let userFitnessPlanRecord = userFitnessPlan.record
        CKManager.savePrivateItem(record: userFitnessPlanRecord)
    }
}
