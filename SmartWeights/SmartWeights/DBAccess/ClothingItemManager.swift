//
//  ClothingItemManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/10/24.
//

import Foundation
import CloudKit


enum ClothingItemRecordKeys: String {
    case type = "ClothingItem"
    case isActive
    case imageName
}

struct ClothingItemModel {
    var recordId: CKRecord.ID?
    var isActive: Int64
    var imageName: String
}

extension ClothingItemModel {
    var record: CKRecord {
        let record = CKRecord(recordType: ClothingItemRecordKeys.type.rawValue)
        record[ClothingItemRecordKeys.isActive.rawValue] = isActive
        record[ClothingItemRecordKeys.imageName.rawValue] = imageName
        return record
    }
}

class ClothingItemDBManager : ObservableObject{
    static let shared = ClothingItemDBManager()
    @Published var clothingItems: [ClothingItemModel] = []
    let CKManager = CloudKitManager()
    var clothingItemExists: Bool = false
    @Published var activeClothing: String = ""
    
    init() {
        fetchClothingItems { clothingItems, error in
            if let error = error {
                print("Error fetching clothing items: \(error.localizedDescription)")
                return
            }
            // guard let clothingItems = clothingItems else {
            //     print("No clothing items found")
            //     return
            // }
            // self.clothingItems = clothingItems
        }
    }
    //gets all
    func fetchClothingItems(completion: @escaping ([ClothingItemModel]?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: ClothingItemRecordKeys.type.rawValue) { records, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let records = records else {
                DispatchQueue.main.async{
                    self.clothingItemExists = false
                    print("No clothing items found.")
                    completion(nil, nil)
                }
                return
            }
            var clothingItems: [ClothingItemModel] = []
            for record in records {
                let clothingItem = ClothingItemModel(recordId: record.recordID, isActive: record[ClothingItemRecordKeys.isActive.rawValue] as! Int64, imageName: record[ClothingItemRecordKeys.imageName.rawValue] as! String)
                clothingItems.append(clothingItem)
                if clothingItem.isActive == 1 {
                    DispatchQueue.main.async {
                        self.activeClothing = clothingItem.imageName
                    }
                }
            
            }
            DispatchQueue.main.async {
                completion(clothingItems, nil)
                self.clothingItems = clothingItems
                self.clothingItemExists = true

            }
        }
    }
    func fetchSpecificClothingItem(imageName: String, completion: @escaping (ClothingItemModel?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: ClothingItemRecordKeys.type.rawValue, fieldName: "imageName", fieldValue: imageName) { records, error in
            guard let record = records?.first else {
                print("No specific pet items found.")
                completion(nil, error)
                return
            }
            let isActive = record[ClothingItemRecordKeys.isActive.rawValue] as! Int64   
            let imageName = record[ClothingItemRecordKeys.imageName.rawValue] as! String
            let clothingItem = ClothingItemModel(recordId: record.recordID, isActive: isActive, imageName: imageName)
            completion(clothingItem, nil)
            
        }
    }
    func createClothingItem(imageName: String, completion: @escaping (Error?) -> Void) {
        fetchSpecificClothingItem(imageName: imageName){ clothingItem, error in
            if clothingItem != nil{
                completion(nil)
                return
            }else{
                let newClothingItem = ClothingItemModel(recordId: nil, isActive: 0, imageName: imageName)
                let newClothingItemRecord = newClothingItem.record
                DispatchQueue.main.async {
                    self.clothingItems.append(newClothingItem)
                }
                self.CKManager.savePrivateItem(record: newClothingItemRecord)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func setActiveClothingItem(imageName: String, completion: @escaping (String, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "ClothingItem") { records, error in
            if let error = error {
                completion("", error)
                return
            }
            
            guard let records = records else {
                print("No pet items found.")
                completion("", nil)
                return
            }
            let dispatchGroup = DispatchGroup()
            for record in records {
                dispatchGroup.enter()
                if record["imageName"] as! String == imageName {
                    record["isActive"] = 1
                    DispatchQueue.main.async {
                        self.activeClothing = imageName
                    }
                } else {
                    record["isActive"] = 0
                }
                self.CKManager.savePrivateItem(record: record)
                dispatchGroup.leave()
                
            }
            dispatchGroup.notify(queue: .main) {
                completion(self.activeClothing, nil)
            }
        }
    }

    //unequips all clothing items
    func setUnactiveAllClothingItems(completion: @escaping (Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "ClothingItem") { records, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let records = records else {
                print("No pet items found.")
                completion(nil)
                return
            }
            let dispatchGroup = DispatchGroup()
            for record in records {
                dispatchGroup.enter()
                record["isActive"] = 0
                self.CKManager.savePrivateItem(record: record)
                dispatchGroup.leave()
            }
            DispatchQueue.main.async {
                self.activeClothing = ""
            }
            dispatchGroup.notify(queue: .main) {
                completion(nil)
            }
        }
    }
    func g_getActiveClothing() -> String{
        // print("GETTING ACTIVE CLOTHING: \(self.activeClothing)")
        return self.activeClothing
    }
    func getActiveClothing(completion : @escaping (String, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "ClothingItem", fieldName: "isActive", fieldValue: 1) { records, error in
            guard let record = records?.first else {
                completion("", error)
                return
            }
            DispatchQueue.main.async {
                let imageName = record["imageName"] as! String
                completion(imageName, nil)
            }
        }
    }

}
