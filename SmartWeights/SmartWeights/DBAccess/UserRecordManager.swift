import CloudKit

class UserRecordManager {
    
    let cloudKitManager = CloudKitManager.shared
    lazy var privateDatabase = cloudKitManager.privateDatabase
    lazy var publicDatabase = cloudKitManager.publicDatabase
    func fetchUserRecord(for Name: String, completion: @escaping (CKRecord?, Error?) -> Void){
        let recordID = CKRecord.ID(recordName: Name)
        privateDatabase.fetch(withRecordID: recordID) { (record, error) in
            completion(record, error)
        }

    }
    func addUserRecord(completion: @escaping (CKRecord?, Error?) -> Void) {
        // let recordID = CKRecord.ID(recordName: nil) // Auto-generated record ID
        let userRecord = CKRecord(recordType: "User")
        userRecord["firstName"] = "John"
        userRecord["lastName"] = "Doe"
        
        privateDatabase.save(userRecord) { (record, error) in
            completion(record, error)
        }
    }
    func addPetRecord( completion: @escaping (CKRecord?, Error?) -> Void) {
        let petRecord = CKRecord(recordType: "Pet")
        petRecord["name"] = "Fido"
//        petRecord["user"] = user
        
        privateDatabase.save(petRecord) { (record, error) in
            completion(record, error)
        }
    }
    
}
