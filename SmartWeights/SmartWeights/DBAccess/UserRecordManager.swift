import CloudKit
import SwiftUI

class UserRecordManager : ObservableObject {
    
    let CKManager = CloudKitManager()
    @Published var userRecord: CKRecord.Reference?
    @Published var userRecords: [CKRecord] = []
    @Published var permissionStatus: Bool = false
    init(){
        
        fetchCurrentUserRecordID { error in
            if let error = error {
                print("Error checking user record existence: \(error)")
            }
        }
        fetchAllUserRecords { records, error in
            if let error = error {
                print("Error fetching user records: \(error)")
            } else if let records = records {
                self.userRecords = records
            }
        }
        userRecordExistsInUsers { exists, error in
            if let error = error {
                print("Error checking user record existence: \(error)")
            }
        }
        requestPermission()
  
    }
    func requestPermission(){
        CKContainer.default().requestApplicationPermission([.userDiscoverability]){
            [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async{
                if returnedStatus == .granted{
                    self?.permissionStatus = true
                }
            }
        }
    }
    // func fetchCurrentUserRecordID() {
    //     CKContainer.default().fetchUserRecordID { [weak self] (recordID, error) in
    //         DispatchQueue.main.async{
    //             if let recordID = recordID {
    //                 let userRecordReference = CKRecord.Reference(recordID: recordID, action: .none)
    //                 self?.userRecord = userRecordReference
    //             }
    //         }
    //     }
        
    // }
    func fetchCurrentUserRecordID(completion: @escaping (Error?) -> Void) {
    CKContainer.default().fetchUserRecordID { [weak self] (recordID, error) in
        DispatchQueue.main.async{
            if let recordID = recordID {
                let userRecordReference = CKRecord.Reference(recordID: recordID, action: .none)
                self?.userRecord = userRecordReference
                completion(nil)
            } else if let error = error {
                completion(error)
            }
        }
    }
}
//    func addUser(firstName: String, lastName: String) {
//        fetchCurrentUserRecordID { [weak self] error in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let userRecord = self?.userRecord {
//                let database = CKContainer.default().privateCloudDatabase
//                let predicate = NSPredicate(format: "%K == %@", UserRecordKeys.Users.rawValue, userRecord)
//                let query = CKQuery(recordType: UserRecordKeys.type.rawValue, predicate: predicate)
//                
//                database.perform(query, inZoneWith: nil) { (records, error) in
//                    if let error = error {
//                        print("Error fetching user record: \(error)")
//                    } else if let records = records, !records.isEmpty {
//                        print("User record exists and has a reference to the Users record")
//                    } else {
//                        print("User record does not exist or does not have a reference to the Users record")
//                    }
//                }
//            }
//        }
//    }
//    func addUser(firstName: String, lastName: String) {
//        fetchCurrentUserRecordID { [weak self] error in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let userRecord = self?.userRecord {
//                let database = CKContainer.default().privateCloudDatabase
//                let predicate = NSPredicate(format: "%K == %@", UserRecordKeys.Users.rawValue, userRecord)
//                let query = CKQuery(recordType: UserRecordKeys.type.rawValue, predicate: predicate)
//                
//                database.fetch(withQuery: query, inZoneWith: nil, desiredKeys: nil, resultsLimit: Int.max) { result in
//                    switch result {
//                    case .failure(let error):
//                        print("Error fetching user record: \(error)")
//                    case .success((let matchResults, _)):
//                        if !matchResults.isEmpty {
//                            print("User record exists and has a reference to the Users record")
//                        } else {
//                            print("User record does not exist or does not have a reference to the Users record")
//                        }
//                    }
//                }
//            }
//        }
//    }
   
        
        func userRecordExistsInUsers(completion: @escaping (Bool, Error?) -> Void) {
            guard let userRecord = userRecord else {
                completion(false, nil) // userRecord not fetched yet
                return
            }
            
            let database = CKContainer.default().publicCloudDatabase
            let predicate = NSPredicate(format: "Users == %@", userRecord)
            let query = CKQuery(recordType: "User", predicate: predicate)
            
            database.perform(query, inZoneWith: nil) { (records, error) in
                if let error = error {
                    completion(false, error)
                } else if let records = records, !records.isEmpty {
                    completion(true, nil) // userRecord exists in Users record type
                    print("exists")
                    print("ExistsRecord: \(records)")
                } else {
                    completion(false, nil) // userRecord does not exist in Users record type
                    print("does not exist")
                }
            }
        }
        func fetchAllUserRecords(completion: @escaping ([CKRecord]?, Error?) -> Void) {
    let predicate = NSPredicate(value: true) // This predicate matches all records
    let query = CKQuery(recordType: "User", predicate: predicate)
    
    CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
        DispatchQueue.main.async {
            completion(records, error)
        }
    }
}
//    private func createUser(first: String, last: String) -> CKRecord{
//        let newUserRecord = CKRecord(recordType: "User")
//        newUserRecord["firstName"] = first
//        newUserRecord["lastName"] = last
//        newUserRecord["latestLogin"] = Date()
//        newUserRecord["Users"] = userRecord
//        return newUserRecord
//    }
}
struct TestView : View {
    
    @StateObject private var vm = UserRecordManager()
       @State private var itemName = ""
       @State private var userRecordExists: Bool = false // State to track if the userRecord exists
       

       var body: some View {
           VStack {
               Text("User Record: \(vm.userRecord?.recordID.recordName ?? "Not available")")
               Text("Status: \(vm.CKManager.isSignedInToiCloud)")
               Button("addUser") {
                   // vm.addUser(firstName: "smart", lastName: "weights")
                   vm.userRecordExistsInUsers { exists, error in
                       if let error = error {
                           print("Error checking user record existence: \(error)")
                       } else {
                           userRecordExists = exists
                            if !userRecordExists {
                                 let newUser = CKRecord(recordType: "User")
                                 newUser["Users"] = vm.userRecord
                                 newUser["firstName"] = "smart"
                                 vm.CKManager.saveItem(record: newUser)
                                 print("did save")
                            }else{
                                print ("user record exists, not saving")
                            }
                       }
                   }
                   
                //    vm.CKManager.saveItem(record: newUser)
                   print("userRecord \(vm.userRecords)")
               }
               List(vm.userRecords, id: \.recordID) { record in
                Text(record["firstName"] as? String ?? "No name")
            }
               
           }
           
       }
}
