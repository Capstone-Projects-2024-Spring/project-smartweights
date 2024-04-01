//import CloudKit
//
//struct Test {
//    let name: String
//    let description: String
//}
//
//class Manager {
//    let container = CKContainer(identifier: "iCloud.SmartWeights" )
////    let database = CKContainer.default().publicCloudDatabase
//    let database: CKDatabase
//        
//        init() {
//            self.database = container.privateCloudDatabase
//        }
//    func saveItem(_ item: Test, completion: @escaping (Error?) -> Void) {
//        let record = CKRecord(recordType: "Item")
//        record.setValue(item.name, forKey: "name")
//        record.setValue(item.description, forKey: "description")
//        
//        database.save(record) { (record, error) in
//            DispatchQueue.main.async {
//                completion(error)
//            }
//        }
//    }
//}
import Foundation
import CloudKit


enum ItemModelRecordKeys: String{
    case type = "Item"
    case name
    case description
}
struct ItemModel {
    var recordId: CKRecord.ID?
    var name: String
    var description: String
}
extension ItemModel {
    var record : CKRecord{
        let record = CKRecord(recordType: ItemModelRecordKeys.type.rawValue)
        record[ItemModelRecordKeys.name.rawValue] = name
        record[ItemModelRecordKeys.description.rawValue] = description
        return record
    }
}

