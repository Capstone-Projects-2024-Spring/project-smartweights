////
////  PetModel.swift
////  SmartWeights
////
////  Created by Daniel Eap on 3/15/24.
////
//
//import Foundation
//import CloudKit
//
//struct PetModel: Hashable {
//    var health: Int64
//    var level: Int64
//    var totalXP: Int64
//}
//
//enum PetRecordKeys: String {
//    case type = "Pet"
//    case health
//    case level
//    case totalXP
//}
//
//extension PetModel {
//    var record: CKRecord {
//        let record = CKRecord(recordType: PetRecordKeys.type.rawValue)
//        record[PetRecordKeys.health.rawValue] = health
//        record[PetRecordKeys.level.rawValue] = level
//        record[PetRecordKeys.totalXP.rawValue] = totalXP
//        return record
//    }
//}
