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
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            DispatchQueue.main.async{
                self?.text = ""
            }
        }
    }
}
