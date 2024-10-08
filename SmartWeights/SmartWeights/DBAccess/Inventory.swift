//
//  Inventory.swift
//  SmartWeights
//
//  Created by Daniel Eap on 3/27/24.
//

///TODO: Repurpose to call the FoodItems, PetItems, BackgroundItems and ClothingItems all into this one class
/// example: var foodItemsToInstantiate ["Apple", "Orange", "Juice], pass this into create food function with quantity 0


import Foundation
import CloudKit

/// Enum defining the keys used in the InventoryModel record.
enum InventoryModelRecordKeys: String {
    case type = "Inventory"
    case activeBackground
    case activePetClothing
    case background
    case clothing
    case food
    case pets
    // case user
}

/// Struct representing the InventoryModel.
struct InventoryModel {
    var recordId: CKRecord.ID?
    var activeBackground: CKRecord.Reference?
    var activePetClothing: CKRecord.Reference?
    var background: [CKRecord.Reference]
    var clothing: [CKRecord.Reference]
    var food: [CKRecord.Reference]
    var pets: [CKRecord.Reference]
    // var user: CKRecord.Reference
}

extension InventoryModel {
    /// Computed property that returns the CKRecord representation of the InventoryModel.
    var record: CKRecord {
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
        // record[InventoryModelRecordKeys.user.rawValue] = user
        return record
    }
}

/// Class responsible for managing the InventoryModel in the database.
class InventoryDBManager: ObservableObject {
    @Published var inventory: InventoryModel?
    let CKManager = CloudKitManager()
    var inventoryExists: Bool = false
    
    /// Initializes the InventoryDBManager and fetches the inventory from the database.
    init() {
        fetchInventory { inventory, error in
            if let error = error {
                print("Error fetching inventory: \(error.localizedDescription)")
                return
            }
            // guard let inventory = inventory else {
            //     print("No inventory found.")
            //     return
            // }
            // self.inventory = inventory
            // self.inventoryExists = true
        }
    }
    
    /// Creates a new inventory in the database.
    func createInventory() {
        if inventoryExists {
            print("Inventory already exists.")
            return
        }
        
        let inventory = InventoryModel(activeBackground: nil, activePetClothing: nil, background: [], clothing: [], food: [], pets: [])
        let inventoryRecord = inventory.record
        // Save the record to the database
        CKManager.savePrivateItem(record: inventoryRecord)
        inventoryExists = true
    }
    
   
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
           
           

            self.inventory = InventoryModel(recordId: record.recordID, activeBackground: activeBackground, activePetClothing: activePetClothing, background: background ?? [], clothing: clothing ?? [], food: food ?? [], pets: pets ?? [])
            completion(self.inventory, nil)
        }
    }
    // ...
    // Rest of the code
    // ...
}

//class InventoryManager: ObservableObject{
//    
//    let foodItemDBManager = FoodItemDBManager()
//    
//    func fetchFoodItems(){
//        foodItemDBManager.fetchFoodItems(completion: <#T##([FoodItemModel]?, (any Error)?) -> Void#>)
//    }
//}
