import CloudKit
/// `CloudKitManager` is a singleton class that manages the CloudKit container and databases.
class CloudKitManager {
     /// The shared singleton instance of `CloudKitManager`.
    static let shared = CloudKitManager()
    let containerIdentifier = "iCloud.SmartWeights"
    private let container: CKContainer
    private let publicDatabase: CKDatabase
    private let privateDatabase: CKDatabase
    /// Initializes the `CloudKitManager` singleton instance.
    private init() {
        container = CKContainer(identifier: containerIdentifier)
        publicDatabase = container.publicCloudDatabase
        privateDatabase = container.privateCloudDatabase
    }
    
    func getContainer() -> CKContainer {
        return container
    }
    func getPublicDatabase() -> CKDatabase {
        return container.publicCloudDatabase
    }
    func getPrivateDatabase() -> CKDatabase {
        return container.privateCloudDatabase
    }
}