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
    @Published var fitnessPlan: FitnessPlanModel?
    let CKManager = CloudKitManager()
    var fitnessPlanExists: Bool = false


    init() {
        fetchFitnessPlan { fitnessPlan, error in
            if let error = error {
                print("Error fetching fitness plan: \(error.localizedDescription)")
                return
            }
        }
    }

    func createFitnessPlan(daysPerWeekGoal: Int64, dumbbellWeightGoal: Int64, setGoal: Int64, repGoal: Int64, notes: String, selectedDate: Date) {
        if fitnessPlanExists {
            print("Fitness plan already exists.")
            // Fetch the existing fitness plan
            CKManager.fetchPrivateRecord(recordType: "FitnessPlan") { records, error in
                if let error = error {
                    print("Error fetching fitness plan: \(error.localizedDescription)")
                    return
                }
                guard let record = records?.first else {
                    print("No fitness plan record found")
                    return
                }
                // Update the record
                record[FitnessPlanRecordKeys.daysPerWeekGoal.rawValue] = daysPerWeekGoal
                record[FitnessPlanRecordKeys.dumbbellWeightGoal.rawValue] = dumbbellWeightGoal
                record[FitnessPlanRecordKeys.setGoal.rawValue] = setGoal
                record[FitnessPlanRecordKeys.repGoal.rawValue] = repGoal
                record[FitnessPlanRecordKeys.notes.rawValue] = notes
                record[FitnessPlanRecordKeys.selectedDate.rawValue] = selectedDate
                // Save the updated record
                self.CKManager.savePrivateItem(record: record)
            }
        } else {
            let fitnessPlan = FitnessPlanModel(
                recordId: nil,
                daysPerWeekGoal: daysPerWeekGoal,
                dumbbellWeightGoal: dumbbellWeightGoal,
                setGoal: setGoal,
                repGoal: repGoal,
                notes: notes,
                selectedDate: selectedDate
            )
            let fitnessPlanRecord = fitnessPlan.record
            CKManager.savePrivateItem(record: fitnessPlanRecord)
            fitnessPlanExists = true
        }
    }

    func fetchFitnessPlan(completion: @escaping (FitnessPlanModel?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: FitnessPlanRecordKeys.type.rawValue) { records, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let record = records?.first else {
                completion(nil, nil)
                return
            }
            let fitnessPlan = FitnessPlanModel(
                recordId: record.recordID,
                daysPerWeekGoal: record[FitnessPlanRecordKeys.daysPerWeekGoal.rawValue] as? Int64 ?? 0,
                dumbbellWeightGoal: record[FitnessPlanRecordKeys.dumbbellWeightGoal.rawValue] as? Int64 ?? 0,
                setGoal: record[FitnessPlanRecordKeys.setGoal.rawValue] as? Int64 ?? 0,
                repGoal: record[FitnessPlanRecordKeys.repGoal.rawValue] as? Int64 ?? 0,
                notes: record[FitnessPlanRecordKeys.notes.rawValue] as? String ?? "",
                selectedDate: record[FitnessPlanRecordKeys.selectedDate.rawValue] as? Date ?? Date()
            )
            self.fitnessPlan = fitnessPlan
            self.fitnessPlanExists = true
            completion(fitnessPlan, nil)
        }
    }
}
