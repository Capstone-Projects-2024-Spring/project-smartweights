import CloudKit
/// `CloudKitManager` is a singleton class that manages the CloudKit container and databases.
class CloudKitManager {
     /// The shared singleton instance of `CloudKitManager`.
    static let shared = CloudKitManager()
    let containerIdentifier = "iCloud.SmartWeights"
    let container: CKContainer
    let publicDatabase: CKDatabase
    let privateDatabase: CKDatabase
    /// Initializes the `CloudKitManager` singleton instance.
    private init() {
        container = CKContainer(identifier: containerIdentifier)
        publicDatabase = container.publicCloudDatabase
        privateDatabase = container.privateCloudDatabase
    }
    
  
}