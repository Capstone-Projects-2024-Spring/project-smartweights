//
//  BackgroundItemManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/10/24.
//

import Foundation
import CloudKit


enum BackgroundItemRecordKeys: String {
    case type = "BackgroundItem"
    case isActive
    case imageName
}

struct BackgroundItemModel {
    var recordId: CKRecord.ID?
    var isActive: Int64
    var imageName: String
}

extension BackgroundItemModel {
    var record: CKRecord {
        let record = CKRecord(recordType: BackgroundItemRecordKeys.type.rawValue)
        record[BackgroundItemRecordKeys.isActive.rawValue] = isActive
        record[BackgroundItemRecordKeys.imageName.rawValue] = imageName
        return record
    }
}

class BackgroundItemDBManager : ObservableObject{

    @Published var backgroundItems: [BackgroundItemModel] = []
    let CKManager = CloudKitManager()
    var backgroundItemExists: Bool = false
    @Published var activeBackground: String = ""
    
    init() {
        fetchBackgroundItems { backgroundItems, error in
            if let error = error {
                print("Error fetching background items: \(error.localizedDescription)")
                return
            }
            // guard let backgroundItems = backgroundItems else {
            //     print("No background items found")
            //     return
            // }
            // self.backgroundItems = backgroundItems
        }
        
    }
    //gets all
    func fetchBackgroundItems(completion: @escaping ([BackgroundItemModel]?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: BackgroundItemRecordKeys.type.rawValue) { records, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let records = records else {
                self.backgroundItemExists = false
                completion(nil, nil)
                return
            }
            var backgroundItems: [BackgroundItemModel] = []
            for record in records {
                let backgroundItem = BackgroundItemModel(recordId: record.recordID,  isActive: record[ClothingItemRecordKeys.isActive.rawValue] as! Int64, imageName: record[ClothingItemRecordKeys.imageName.rawValue] as! String)
                backgroundItems.append(backgroundItem)
                if backgroundItem.isActive == 1 {
                    self.activeBackground = backgroundItem.imageName
                }
            }
            completion(backgroundItems, nil)
            self.backgroundItemExists = true
            // self.backgroundItems = records.map { record in
            //     BackgroundItemModel(recordId: record.recordID, isActive: record[BackgroundItemRecordKeys.isActive.rawValue] as? Int64 ?? 0, imageName: record[BackgroundItemRecordKeys.imageName.rawValue] as? String ?? "")
            // }
            // completion(self.backgroundItems, nil)
        }
    }
    
    func fetchSpecifcBackgroundItem(imageName: String, completion: @escaping (BackgroundItemModel?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: BackgroundItemRecordKeys.type.rawValue, fieldName: "imageName", fieldValue: imageName) { records, error in
            guard let record = records?.first else {
                print("No specific background items found.")
                completion(nil, error)
                return
            }
            let isActive = record[BackgroundItemRecordKeys.isActive.rawValue] as! Int64
            let imageName = record[BackgroundItemRecordKeys.imageName.rawValue] as! String
            let backgroundItem = BackgroundItemModel(recordId: record.recordID, isActive: isActive, imageName: imageName)
            completion(backgroundItem, nil)
        }
    }
    
    
    func createBackgroundItem(imageName: String, completion: @escaping (Error?) -> Void) {
        fetchSpecifcBackgroundItem(imageName: imageName){ backgroundItem, error in
            
            if backgroundItem != nil {
                completion(nil)
                return
            }else{
                let newBackgroundItem = BackgroundItemModel(recordId: nil, isActive: 0, imageName: imageName)
                let newRecord = newBackgroundItem.record
                self.backgroundItems.append(newBackgroundItem)
                self.CKManager.savePrivateItem(record: newRecord)
                completion(nil)
            }
        
        }
    }
    func setActiveBackgroundItem(imageName: String, completion: @escaping (String, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "BackgroundItem"){ records, error in
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
            for record in records{
                dispatchGroup.enter()
                if record["imageName"] as! String == imageName {
                    record["isActive"] = 1
                    self.activeBackground = imageName
                }else{
                    record["isActive"] = 0
                }
                self.CKManager.savePrivateItem(record: record)
            }
            dispatchGroup.notify(queue: .main){
                completion(self.activeBackground, nil)
            }
        }
    }
    //unequips all clothing items
    func setUnactiveAllBackgroundItems(completion: @escaping (Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "BackgroundItem") { records, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let records = records else {
                print("No background items found.")
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
            dispatchGroup.notify(queue: .main) {
                completion(nil)
            }
        }
    }

    
}
