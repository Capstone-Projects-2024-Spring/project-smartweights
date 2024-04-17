//
//  FitnessPlanManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/17/24.
//

import Foundation
import CloudKit

enum FitnessPlanRecordKeys: String {
    case type = "FitnessPlan"
    case daysPerWeekGoal
    case dumbbellWeightGoal
    case setGoal
    case repGoal
    case notes
    case selectedDate
}

struct FitnessPlanModel {
    var recordId: CKRecord.ID?
    var daysPerWeekGoal: Int64
    var dumbbellWeightGoal: Int64
    var setGoal: Int64
    var repGoal: Int64
    var notes: String
    var selectedDate: Date
}

extension FitnessPlanModel {
    var record: CKRecord {
        let record = CKRecord(recordType: FitnessPlanRecordKeys.type.rawValue)
        record[FitnessPlanRecordKeys.daysPerWeekGoal.rawValue] = daysPerWeekGoal
        record[FitnessPlanRecordKeys.dumbbellWeightGoal.rawValue] = dumbbellWeightGoal
        record[FitnessPlanRecordKeys.setGoal.rawValue] = setGoal
        record[FitnessPlanRecordKeys.repGoal.rawValue] = repGoal
        record[FitnessPlanRecordKeys.notes.rawValue] = notes
        record[FitnessPlanRecordKeys.selectedDate.rawValue] = selectedDate
        return record
    }
}

class FitnessPlanDBManager: ObservableObject{
    
}