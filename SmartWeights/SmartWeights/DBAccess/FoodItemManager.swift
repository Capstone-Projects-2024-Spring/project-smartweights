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
    func fetchFoodItems(completion: @escaping ([FoodItemModel]?, Error?) -> Void) {
        CKManager.fetchRecords(recordType: FoodItemRecordKeys.type.rawValue) { records, error in
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

}
