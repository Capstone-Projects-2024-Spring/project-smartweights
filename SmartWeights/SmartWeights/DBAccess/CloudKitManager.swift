import CloudKit
import SwiftUI
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
    func saveItem(record: CKRecord) {
        p_saveRecord(record: record, usePrivateDatabase: false)
    }

    func savePrivateItem(record: CKRecord) {
        p_saveRecord(record: record, usePrivateDatabase: true)
    }

    private func p_saveRecord(record: CKRecord, usePrivateDatabase: Bool) {
        let database = usePrivateDatabase ? CKContainer.default().privateCloudDatabase : CKContainer.default().publicCloudDatabase
        database.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")
            DispatchQueue.main.async {
                self?.text = ""
            }
        }
    }
    // fetch record, user reference is optional,
    private func p_fetchRecord(recordType: String, usePrivateDatabase: Bool, user: CKRecord.Reference? = nil, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let predicate: NSPredicate
        if let user = user {
            predicate = NSPredicate(format: "user == %@", user)
        } else {
            predicate = NSPredicate(value: true)
        }
        // if usePrivateDatabase is true, use private database, else use public database
        let database = usePrivateDatabase ? privateDatabase : publicDatabase
        let query = CKQuery(recordType: recordType, predicate: predicate)
        database.fetch(withQuery: query, inZoneWith: nil, desiredKeys: nil, resultsLimit: CKQueryOperation.maximumResults) { (result: Result<(matchResults: [(CKRecord.ID, Result<CKRecord, Error>)], queryCursor: CKQueryOperation.Cursor?), Error>) in
            switch result {
            case .failure(let error):
                print("Error fetching record: \(error.localizedDescription)")
                completion(nil, error)
            case .success((let matchResults, _)):
                if matchResults.isEmpty {
                    print("No records found")
                    completion(nil, nil)
                } else {
                    let records = matchResults.compactMap { (recordID, recordResult) in
                        do {
                            return try recordResult.get()
                        } catch {
                            print("Error getting record: \(error.localizedDescription)")
                            return nil
                        }
                    }
                    completion(records, nil)
                }
            }
        }
    }
    // fetch record with user reference
    func fetchPublicRecord(recordType: String, user: CKRecord.Reference, completion: @escaping ([CKRecord]?, Error?) -> Void)  {
        p_fetchRecord(recordType: recordType, usePrivateDatabase: false, user: user, completion: completion)
    }
    // fetch record without user reference
    func fetchPublicRecord(recordType: String, completion: @escaping ([CKRecord]?, Error?) -> Void)  {
        p_fetchRecord(recordType: recordType, usePrivateDatabase: false, user: nil, completion: completion)
    }
    // fetch private record with user reference
    func fetchPrivateRecord(recordType: String, user: CKRecord.Reference, completion: @escaping ([CKRecord]?, Error?) -> Void)  {
        p_fetchRecord(recordType: recordType, usePrivateDatabase: true, user: user, completion: completion)
    }

    // fetch private record without user reference
    func fetchPrivateRecord(recordType: String, completion: @escaping ([CKRecord]?, Error?) -> Void)  {
        p_fetchRecord(recordType: recordType, usePrivateDatabase: true, user: nil, completion: completion)
    }
    
}


struct testview : View{
    
    var cloudKitManager = CloudKitManager.shared
    @State var record = CKRecord(recordType: "Test")
    @State var user = CKRecord.Reference(recordID: CKRecord.ID(recordName: "Test"), action: .none)
    var body: some View{
        VStack{
            Button("Save"){
                cloudKitManager.saveItem(record: record)
            }
            Button("Fetch"){
                cloudKitManager.fetchPrivateRecord(recordType: "Inventory"){ records, error in
                    if let error = error {
                        print("Error fetching record: \(error.localizedDescription)")
                    }
                    guard let records = records else {
                        print("No records found")
                        return
                    }
                    print("Records: \(records)")
                }
            }
        }
    }
}

