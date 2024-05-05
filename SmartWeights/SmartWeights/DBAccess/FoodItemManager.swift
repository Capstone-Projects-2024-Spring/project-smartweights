//
//  FoodItemManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/5/24.
//

import Foundation
import CloudKit

/// Keys used for accessing the fields in the CloudKit record for a food item.
enum FoodItemRecordKeys: String {
    case type = "FoodItem"
    case name
    case quantity
    case imageName
}

/// Model representing a food item.
struct FoodItemModel {
    var recordId: CKRecord.ID?
    var name: String
    var quantity: Int64
    var imageName: String
}

extension FoodItemModel {
    /// Converts the food item model to a CloudKit record.
    var record: CKRecord {
        let record = CKRecord(recordType: FoodItemRecordKeys.type.rawValue)
        record[FoodItemRecordKeys.name.rawValue] = name
        record[FoodItemRecordKeys.quantity.rawValue] = quantity
        record[FoodItemRecordKeys.imageName.rawValue] = imageName
        return record
    }
}

/// Manager class for handling food item database operations.
class FoodItemDBManager: ObservableObject{
    @Published var foodItems: [FoodItemModel] = []
    let CKManager = CloudKitManager()
    var foodItemExists: Bool = false

    /// Initializes the FoodItemDBManager and fetches the food items from the database.
    static let shared = FoodItemDBManager()

    init() {
        fetchFoodItems { foodItems, error in
            if let error = error {
                print("Error fetching food items: \(error.localizedDescription)")
                return
            }
            guard let foodItems = foodItems else {
                print("No food items found")
                self.createInitialFoodItems()
                return
            }
            self.foodItems = foodItems
        }
    }
    
    /// Fetches all food items from the database.
    func fetchFoodItems(completion: @escaping ([FoodItemModel]?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: FoodItemRecordKeys.type.rawValue) { records, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let records = records else {
                DispatchQueue.main.async{
                    self.foodItemExists = false
                    print("No food items found.")
                    completion(nil, nil)
                }
                return
            }
            var foodItems: [FoodItemModel] = []
            for record in records {
                let foodItem = FoodItemModel(recordId: record.recordID, name: record[FoodItemRecordKeys.name.rawValue] as? String ?? "", quantity: record[FoodItemRecordKeys.quantity.rawValue] as? Int64 ?? 0, imageName: record[FoodItemRecordKeys.imageName.rawValue] as? String ?? "")
                foodItems.append(foodItem)
            }
            DispatchQueue.main.async {
                self.foodItems = foodItems
                completion(foodItems, nil)
                self.foodItemExists = true
            }
          
        }
    }
    
    /// Creates initial food items in the database.
    func createInitialFoodItems(){
        let foodItems = [
            FoodItemModel(recordId: nil, name: "Apple", quantity: 0, imageName: "Apple"),
            FoodItemModel(recordId: nil, name: "Orange", quantity: 0, imageName: "Orange"),
            FoodItemModel(recordId: nil, name: "Juice", quantity: 0, imageName: "Juice"),
        ]
        for foodItem in foodItems {
            createFoodItem(name: foodItem.name, quantity: 0){
                error in
                if let error = error {
                    print("Error creating food item: \(error.localizedDescription)")
                }
                DispatchQueue.main.async{
                    self.foodItems.append(foodItem)
                }
            }
        }
    }
    
    /// Creates a new food item in the database.
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
                let foodItem = FoodItemModel(recordId: nil, name: name, quantity: quantity, imageName: name)
                let foodItemRecord = foodItem.record
                DispatchQueue.main.async{
                    self.foodItems.append(foodItem)
                }
                self.CKManager.savePrivateItem(record: foodItemRecord)
            }
        }
    }
    
    /// Fetches a specific food item from the database based on its name.
    func fetchSpecificFoodItem(name: String, completion: @escaping (FoodItemModel?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: FoodItemRecordKeys.type.rawValue, fieldName: "name", fieldValue: name) { records, error in
            guard let record = records?.first else {
                completion(nil, error)
                return
            }
            let foodItem = FoodItemModel(recordId: record.recordID, name: record[FoodItemRecordKeys.name.rawValue] as? String ?? "", quantity: record[FoodItemRecordKeys.quantity.rawValue] as? Int64 ?? 0, imageName: record[FoodItemRecordKeys.imageName.rawValue] as? String ?? "")
            print(" food item abcd HERE HERE: \(foodItem)")
            completion(foodItem, nil)
        }
    }
    
    /// Fetches the quantity of a specific food item from the database.
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
    
    /// Updates the quantity of the food item by adding the specified quantity to the existing quantity.
    func updateQuantity_add(name: String, quantity: Int64, completion: @escaping (Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "FoodItem",fieldName:"name", fieldValue: name) { records, error in
            if let error = error {
                completion(error)
                return
            }
            
            var record: CKRecord
            if let existingRecord = records?.first {
                record = existingRecord
            } else {
                record = CKRecord(recordType: "FoodItem")
                record["name"] = name as CKRecordValue
                record["imageName"] = name as CKRecordValue
            }
            
            let existingQuantity = record["quantity"] as? Int64 ?? 0
            let newQuantity = existingQuantity + quantity
            record["quantity"] = NSNumber(value: newQuantity) as CKRecordValue
            DispatchQueue.main.async{
                // Update the quantity of the food item in the local array
                self.foodItems = self.foodItems.map { foodItem in
                    if foodItem.name == name {
                        var newFoodItem = foodItem
                        newFoodItem.quantity = newQuantity
                        return newFoodItem
                    }
                    return foodItem
                }
            }
            self.CKManager.savePrivateItem(record: record)
            completion(nil)
        }
    }
    
    /// Updates the quantity of the food item by replacing the existing quantity with the specified new quantity.
    func updateQuantity(name: String, newQuantity: Int64, completion: @escaping (Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: FoodItemRecordKeys.type.rawValue, fieldName: "name", fieldValue: name) { records, error in
             if let error = error {
                completion(error)
                return
            }
            
            var record: CKRecord
            if let existingRecord = records?.first {
                record = existingRecord
            } else {
                record = CKRecord(recordType: "FoodItem")
                record["name"] = name as CKRecordValue
                record["imageName"] = name as CKRecordValue
            }
            record[FoodItemRecordKeys.quantity.rawValue] = NSNumber(value: newQuantity)
            DispatchQueue.main.async{
                self.foodItems = self.foodItems.map { foodItem in
                    if foodItem.name == name {
                        var newFoodItem = foodItem
                        newFoodItem.quantity = newQuantity
                        return newFoodItem
                    }
                    return foodItem
                }
            }
            self.CKManager.savePrivateItem(record: record)
            completion(nil)
        }
    }
    
    /// Updates the quantity of the specified food item by replacing the existing quantity with the specified new quantity.
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

    func getFoodItems() -> [FoodItemModel] {
        return self.foodItems
    }
}
