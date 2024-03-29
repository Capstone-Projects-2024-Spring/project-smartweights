import CloudKit
/// `CloudKitManager` is a singleton class that manages the CloudKit container and databases.
class CloudKitManager {
     /// The shared singleton instance of `CloudKitManager`.
    static let shared = CloudKitManager()
//    let containerIdentifier = "iCloud.SmartWeights"
    let container: CKContainer
    let publicDatabase: CKDatabase
    let privateDatabase: CKDatabase
    
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
//    @Published var userName: String = ""
//    @Published var permissionStatus: Bool = false
    @Published var text: String = ""
//    @Published var userRecord: CKRecord.Reference?
    
    /// Initializes the `CloudKitManager` singleton instance.
    init() {
//        container = CKContainer(identifier: containerIdentifier)
        container = CKContainer.default()
        publicDatabase = container.publicCloudDatabase
        privateDatabase = container.privateCloudDatabase
        getiCloudStatus()
    }
    
    
    private func getiCloudStatus(){
        CKContainer.default().accountStatus{[weak self] returnedStatus, returnedError in
            DispatchQueue.main.async{
                switch returnedStatus{
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.localizedDescription
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.localizedDescription
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.localizedDescription
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.localizedDescription
                }
            }
            
        }
    }
    enum CloudKitError: LocalizedError{
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    func saveItem(record: CKRecord){
        CKContainer.default().publicCloudDatabase.save(record){[weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")
            DispatchQueue.main.async{
                self?.text = ""
            }
        }
    }
    func savePrivateItem(record: CKRecord){
        CKContainer.default().privateCloudDatabase.save(record){[weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")
            DispatchQueue.main.async{
                self?.text = ""
            }
        }
    }
    func fetchRecord(recordType: String, user: CKRecord.Reference, completion: @escaping ([CKRecord]?, Error?) -> Void)  {
        // var fetchedRecords: [CKRecord] = []
        
        let predicate = NSPredicate(format: "user == %@", user)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print("Error fetching record: \(error.localizedDescription)")
                  completion(nil, error)
                return
            }
            
            guard let records = records else {
                print("No records found")
                completion(nil, nil)
                return
            }
            completion(records, nil)
            // fetchedRecords = records
        }
        
        // return fetchedRecords
    }
    func fetchPrivateItem(recordType: String, user: CKRecord.Reference, completion: @escaping (CKRecord?, Error?) -> Void) {
        let predicate = NSPredicate(format: "user == %@", user)
        let query = CKQuery(recordType: recordType, predicate: predicate)

        privateDatabase.perform(query, inZoneWith: nil) { records, error in
            DispatchQueue.main.async {
                completion(records?.first, error)
            }
        }
    }
    
}
