//
//  PetItemManager.swift
//  SmartWeights
//
//  Created by Daniel Eap on 4/6/24.
//

import Foundation
import CloudKit

enum PetItemRecordKeys: String {
    case type = "PetItem"
    case isActive
    case petName
    case imageName
}

struct PetItemModel {
    var recordId: CKRecord.ID?
    var isActive: Int64
    var petName: String
    var imageName: String
}

extension PetItemModel {
    var record: CKRecord {
        let record = CKRecord(recordType: PetItemRecordKeys.type.rawValue)
        record[PetItemRecordKeys.isActive.rawValue] = isActive
        record[PetItemRecordKeys.petName.rawValue] = petName
        record[PetItemRecordKeys.imageName.rawValue] = imageName
        return record
    }
}


class PetItemDBManager: ObservableObject{
    @Published var petItems: [PetItemModel] = []
    let CKManager = CloudKitManager()
    var petItemExists: Bool = false
    @Published var activePet: String = ""
    init() {
        fetchPetItems { petItems, error in
            if let error = error {
                print("Error fetching pet items: \(error.localizedDescription)")
                return
            }
            // guard let petItems = petItems else {
            //     print("No pet items found")
            //     return
            // }
            // self.petItems = petItems
        }
    }
    //gets all
    func fetchPetItems(completion: @escaping ([PetItemModel]?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: PetItemRecordKeys.type.rawValue) { records, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let records = records else {
                self.petItemExists = false
                print("No pet items found.")
                completion(nil, nil)
                return
            }
            var petItems: [PetItemModel] = []
            for record in records {
                let isActive = record[PetItemRecordKeys.isActive.rawValue] as! Int64
                let petName = record[PetItemRecordKeys.petName.rawValue] as! String
                let imageName = record[PetItemRecordKeys.imageName.rawValue] as! String
                
                let petItem = PetItemModel(recordId: record.recordID, isActive: isActive, petName: petName, imageName: imageName)
                petItems.append(petItem)
                
                if isActive == 1 {
                    self.activePet = imageName
                }
            }
            completion(petItems, nil)
            self.petItemExists = true
        }
    }
    func fetchSpecificPetItem(imageName: String, completion: @escaping (PetItemModel?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: PetItemRecordKeys.type.rawValue, fieldName: "imageName",  fieldValue: imageName) { records, error in
            guard let record = records?.first else {
                completion(nil, error)
                return
            }   
            let isActive = record[PetItemRecordKeys.isActive.rawValue] as! Int64
            let petName = record[PetItemRecordKeys.petName.rawValue] as! String
            let imageName = record[PetItemRecordKeys.imageName.rawValue] as! String
            
            let petItem = PetItemModel(recordId: record.recordID, isActive: isActive, petName: petName, imageName: imageName)
            completion(petItem, nil)
            // self.petItemExists = true
        }
    }
    func createPetItem(imageName: String, completion : @escaping (Error?) -> Void) {
        fetchSpecificPetItem(imageName: imageName) { petItem, error in
            // if let error = error {
            //     completion(error)
            //     return
            // }
            if petItem != nil {
                // If the pet item exists, do not create a new one
                print("Pet item already exists")
                completion(nil)
                return
            }else{
                // If the pet item does not exist, create a new one
                let petItem = PetItemModel(recordId: nil, isActive: 0, petName: imageName, imageName: imageName)
                let petItemRecord = petItem.record
                self.petItems.append(petItem)
                self.CKManager.savePrivateItem(record: petItemRecord)
            }
        }
    }
    // goes through all pet items and sets the active pet item to 1 and the rest to 0 
    func setActivePetItem(imageName: String, completion: @escaping (String, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "PetItem") { records, error in
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
                if record["imageName"] as? String == imageName {
                    record["isActive"] = 1 as CKRecordValue
                    self.activePet = imageName
                } else {
                    record["isActive"] = 0 as CKRecordValue
                }
                self.CKManager.savePrivateItem(record: record)
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main) {
                completion(self.activePet, nil)
            }
        }
    }
    func getActivePet(completion : @escaping (String, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "PetItem", fieldName: "isActive", fieldValue: 1) { records, error in
            guard let record = records?.first else {
                completion("", error)
                return
            }
            let imageName = record["imageName"] as! String
            completion(imageName, nil)
        }
    }
}