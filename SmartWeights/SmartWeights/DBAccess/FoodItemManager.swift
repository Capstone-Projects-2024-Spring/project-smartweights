//
//  FoodItemManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/5/24.
//

import Foundation
import CloudKit

enum FoodItemRecordKeys: String {
    case type = "FoodItem"
    case name
    case quantity
}

struct FoodItemModel {
    var recordId: CKRecord.ID?
    var name: String
    var quantity: Int64
}

extension FoodItemModel {
    var record: CKRecord {
        let record = CKRecord(recordType: FoodItemRecordKeys.type.rawValue)
        record[FoodItemRecordKeys.name.rawValue] = name
        record[FoodItemRecordKeys.quantity.rawValue] = quantity
        return record
    }
}

class FoodItemDBManager: ObservableObject{
    @Published var foodItems: [FoodItemModel] = []
    let CKManager = CloudKitManager()
    var foodItemExists: Bool = false


    init() {
        fetchFoodItems { foodItems, error in
            if let error = error {
                print("Error fetching food items: \(error.localizedDescription)")
                return
            }
            // guard let foodItems = foodItems else {
            //     print("No food items found")
            //     return
            // }
            // self.foodItems = foodItems
        }
    }
    //gets all 
    func fetchFoodItems(completion: @escaping ([FoodItemModel]?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: FoodItemRecordKeys.type.rawValue) { records, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let records = records else {
                self.foodItemExists = false
                print("No food items found.")
                completion(nil, nil)
                return
            }
            var foodItems: [FoodItemModel] = []
            for record in records {
                let foodItem = FoodItemModel(recordId: record.recordID, name: record[FoodItemRecordKeys.name.rawValue] as? String ?? "", quantity: record[FoodItemRecordKeys.quantity.rawValue] as? Int64 ?? 0)
                foodItems.append(foodItem)
            }
            completion(foodItems, nil)
            self.foodItemExists = true
        }
    }

    func createFoodItem(name: String, quantity: Int64, completion: @escaping (Error?) -> Void) {
            fetchSpecificFoodItem(name: name) { foodItem, error in
                if let error = error {
                    completion(error)
                    return
                }
                if foodItem != nil {
                    // If the food item exists, do not create a new one
                    print("Food item already exists")
                    completion(nil)
                    return
                }else{
                    // If the food item does not exist, create a new one
                    let foodItem = FoodItemModel(recordId: nil, name: name, quantity: quantity)
                    let foodItemRecord = foodItem.record
                    self.foodItems.append(foodItem)
                    self.CKManager.savePrivateItem(record: foodItemRecord)
                }
            }
          
  
    }
    

    func fetchSpecificFoodItem(name: String, completion: @escaping (FoodItemModel?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: FoodItemRecordKeys.type.rawValue, fieldName: "name", fieldValue: name) { records, error in
            guard let record = records?.first else {
                completion(nil, error)
                return
            }
            let foodItem = FoodItemModel(recordId: record.recordID, name: record[FoodItemRecordKeys.name.rawValue] as? String ?? "", quantity: record[FoodItemRecordKeys.quantity.rawValue] as? Int64 ?? 0)
            print(" food item abcd HERE HERE: \(foodItem)")
            completion(foodItem, nil)
        }
    }
    func fetchQuantity(name: String, completion: @escaping (Int64?, Error?) -> Void) {
        fetchSpecificFoodItem(name: name) { foodItem, error in
            if let error = error {
                completion(nil, error)
                return
            }
            completion(foodItem?.quantity, nil)
            print("food quantity: \(String(describing: foodItem?.quantity))")
        }
    }
    /// Updates the quantity of the food item.
    func updateQuantity(name: String, newQuantity: Int64, completion: @escaping (Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "FoodItem",fieldName:"name", fieldValue: name) { records, error in
            guard let record = records?.first else {
                print("Error fetching food item: \(error?.localizedDescription ?? "Unknown error")")
                completion(error)
                return
            }
            
            let quantityValue = NSNumber(value: newQuantity)
            record["quantity"] = quantityValue as CKRecordValue
            self.CKManager.savePrivateItem(record: record)
            completion(nil)
        }
    }
    func updateQuantity(foodItem: FoodItemModel, newQuantity: Int64, completion: @escaping (Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: FoodItemRecordKeys.type.rawValue) { records, error in
            guard let record = records?.first else {
                print("Error fetching food item: \(error?.localizedDescription ?? "Unknown error")")
                completion(error)
                return
            }
            record[FoodItemRecordKeys.quantity.rawValue] = NSNumber(value: newQuantity)
            self.CKManager.savePrivateItem(record: record)
            completion(nil)
        }
    }
    



}
