//import Foundation
//
//class AddItemViewModel {
//    let cloudKitManager: Manager
//    
//    init(cloudKitManager: Manager) {
//        self.cloudKitManager = cloudKitManager
//    }
//    
//    func saveItemToCloud(_ test: Test, completion: @escaping (Error?) -> Void) {
//        cloudKitManager.saveItem(test) { error in
//            completion(error)
//        }
//    }
//}
import CloudKit

class ItemViewModel: ObservableObject {
//    @Published var items: [ItemModel] = []
//    
//    func addItem(name: String, description: String) {
//        let newItem = ItemModel(name: name, description: description)
//        items.append(newItem)
//        
//        CKContainer.default().fetchUserRecordID { (recordID, error) in
//            if let error = error {
//                print("Error fetching user record ID: \(error)")
//                return
//            }
//            
//            guard let recordID = recordID else {
//                print("Error: No user is authenticated")
//                return
//            }
//            
//            let ownerName = recordID.recordName
//            let record_ID = CKRecord.ID(recordName: UUID().uuidString, zoneID: CKRecordZone.ID(zoneName: "_defaultZone", ownerName: ownerName))
//            let record = CKRecord(recordType: "Item", recordID: record_ID)
//            record["name"] = name as CKRecordValue
//            record["description"] = description as CKRecordValue
//            
//            let database = CKContainer(identifier: "iCloud.SmartWeights").privateCloudDatabase
//            
//            database.save(record) { (_, error) in
//                if let error = error {
//                    print("Error saving record: \(error)")
//                } else {
//                    print("Record saved successfully")
//                }
//            }
//        }
//    }
    private var db = CKContainer.default().privateCloudDatabase
    
    func addItem(itemModel: ItemModel) async {
        do{
            let _ = try await db.save(itemModel.record)
            print("Item saved successfully")
        } catch{
            print("Error saving item: \(error)")
        }
      
    }
}


