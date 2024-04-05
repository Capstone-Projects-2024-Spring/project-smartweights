//
//  Inventory.swift
//  SmartWeights
//
//  Created by Daniel Eap on 3/27/24.
//

import Foundation
import CloudKit



// activeBackground, activePetClothing, background, clothing, food, pets, user
enum InventoryModelRecordKeys: String{
    case type = "Inventory"
    case activeBackground
    case activePetClothing
    case background
    case clothing
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
    var food: [CKRecord.Reference]
    var pets: [CKRecord.Reference]
    var user: CKRecord.Reference
}
extension InventoryModel {
    var record : CKRecord{
        // let record = CKRecord(recordType: InventoryModelRecordKeys.type.rawValue)
        let record: CKRecord
        if let recordId = recordId {
            record = CKRecord(recordType: InventoryModelRecordKeys.type.rawValue, recordID: recordId)
        } else {
            record = CKRecord(recordType: InventoryModelRecordKeys.type.rawValue)
        }
        
        record[InventoryModelRecordKeys.activeBackground.rawValue] = activeBackground
        record[InventoryModelRecordKeys.activePetClothing.rawValue] = activePetClothing
        record[InventoryModelRecordKeys.background.rawValue] = background
        record[InventoryModelRecordKeys.clothing.rawValue] = clothing
        record[InventoryModelRecordKeys.food.rawValue] = food
        record[InventoryModelRecordKeys.pets.rawValue] = pets
        record[InventoryModelRecordKeys.user.rawValue] = user
        return record
    }
}

class InventoryDBManager : ObservableObject{
    @Published var inventory: InventoryModel?
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
        
        let inventory = InventoryModel(activeBackground: nil, activePetClothing: nil, background: [], clothing: [], food: [], pets: [], user: userR)
        let inventoryRecord = inventory.record
        // Save the record to the database
        CKManager.savePrivateItem(record: inventoryRecord)
        
    }
//    func fetchInventory(user: CKRecord.Reference, completion: @escaping (InventoryModel?, Error?) -> Void) {
//        CKManager.fetchPrivateRecord(recordType: "Inventory", user: user) { record, error in
//            guard let record = record else {
//                completion(nil, error)
//                print("Error fetching inventory: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            let activeBackground = record[InventoryModelRecordKeys.activeBackground.rawValue] as? CKRecord.Reference
//            let activePetClothing = record[InventoryModelRecordKeys.activePetClothing.rawValue] as? CKRecord.Reference
//            let background = record[InventoryModelRecordKeys.background.rawValue] as? [CKRecord.Reference]
//            let clothing = record[InventoryModelRecordKeys.clothing.rawValue] as? [CKRecord.Reference]
//            let food = record[InventoryModelRecordKeys.food.rawValue] as? [CKRecord.Reference]
//            let pets = record[InventoryModelRecordKeys.pets.rawValue] as? [CKRecord.Reference]
//            let user = record[InventoryModelRecordKeys.user.rawValue] as? CKRecord.Reference
//            
//            guard let userUnwrapped = user else {
//                print("User reference nil.")
//                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "User reference nil."]))
//                return
//            }
//            
//            self.inventory = InventoryModel(recordId: record.recordID, activeBackground: activeBackground, activePetClothing: activePetClothing, background: background ?? [], clothing: clothing ?? [], food: food ?? [], pets: pets ?? [], user: userUnwrapped)
//            completion(self.inventory, nil)
//            
//        }
//    }
    
    func fetchInventory(completion: @escaping (InventoryModel?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "Inventory") { records, error in
            guard let record = records?.first else {
                completion(nil, error)
                print("Error fetching inventory: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let activeBackground = record[InventoryModelRecordKeys.activeBackground.rawValue] as? CKRecord.Reference
            let activePetClothing = record[InventoryModelRecordKeys.activePetClothing.rawValue] as? CKRecord.Reference
            let background = record[InventoryModelRecordKeys.background.rawValue] as? [CKRecord.Reference]
            let clothing = record[InventoryModelRecordKeys.clothing.rawValue] as? [CKRecord.Reference]
            let food = record[InventoryModelRecordKeys.food.rawValue] as? [CKRecord.Reference]
            let pets = record[InventoryModelRecordKeys.pets.rawValue] as? [CKRecord.Reference]
            let user = record[InventoryModelRecordKeys.user.rawValue] as? CKRecord.Reference
            
            guard let userUnwrapped = user else {
                print("User reference nil.")
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "User reference nil."]))
                return
            }
            
            self.inventory = InventoryModel(recordId: record.recordID, activeBackground: activeBackground, activePetClothing: activePetClothing, background: background ?? [], clothing: clothing ?? [], food: food ?? [], pets: pets ?? [], user: userUnwrapped)
            completion(self.inventory, nil)
        }
    }
   
    
    
}
