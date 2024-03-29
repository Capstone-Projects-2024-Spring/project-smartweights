//
//  Inventory.swift
//  SmartWeights
//
//  Created by Daniel Eap on 3/27/24.
//

import Foundation
import CloudKit



// activeBackground, activePetClothing, background, clothing, currency, food, pets, user
enum InventoryModelRecordKeys: String{
    case type = "Inventory"
    case activeBackground
    case activePetClothing
    case background
    case clothing
    case currency
    case food
    case pets
    case user
}
struct InventoryModel {
    var recordId: CKRecord.ID?
    var activeBackground: CKRecord.Reference?
    var activePetClothing: CKRecord.Reference?
    var background: [CKRecord.Reference]
    var clothing: [CKRecord.Reference]
    var currency: Int64
    var food: [CKRecord.Reference]
    var pets: [CKRecord.Reference]
    var user: CKRecord.Reference
}
extension InventoryModel {
    var record : CKRecord{
        let record = CKRecord(recordType: InventoryModelRecordKeys.type.rawValue)
        record[InventoryModelRecordKeys.activeBackground.rawValue] = activeBackground
        record[InventoryModelRecordKeys.activePetClothing.rawValue] = activePetClothing
        record[InventoryModelRecordKeys.background.rawValue] = background
        record[InventoryModelRecordKeys.clothing.rawValue] = clothing
        record[InventoryModelRecordKeys.currency.rawValue] = currency
        record[InventoryModelRecordKeys.food.rawValue] = food
        record[InventoryModelRecordKeys.pets.rawValue] = pets
        record[InventoryModelRecordKeys.user.rawValue] = user
        return record
    }
}

class InventoryDBManager : ObservableObject{
    let CKManager = CloudKitManager()
//    var userM = UserRecordManager()
    //user userM to get userReference
    func createInventory(userR : CKRecord.Reference){
        //        userM.fetchCurrentUserRecordID { error in
        //            if let error = error {
        //                print("Error fetching current user record ID: \(error)")
        //                return
        //            } else {
        //                print("successful call fetchCurrentUserRecordID: ")
        //            }
        //        }
        
        let inventory = InventoryModel(activeBackground: nil, activePetClothing: nil, background: [], clothing: [], currency: 0, food: [], pets: [], user: userR)
        let inventoryRecord = inventory.record
        // Save the record to the database
        CKManager.savePrivateItem(record: inventoryRecord)
        
    }
}
