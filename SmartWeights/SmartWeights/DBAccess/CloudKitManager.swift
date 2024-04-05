/// `CloudKitManager` is a singleton class that manages the CloudKit container and databases.
///
import CloudKit
import SwiftUI
class CloudKitManager {
    /// The shared singleton instance of `CloudKitManager`.
    static let shared = CloudKitManager()
    
    let container: CKContainer
    let publicDatabase: CKDatabase
    let privateDatabase: CKDatabase
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var text: String = ""
    
    /// Initializes the `CloudKitManager` singleton instance.
    init() {
        container = CKContainer.default()
        publicDatabase = container.publicCloudDatabase 
        privateDatabase = container.privateCloudDatabase
        getiCloudStatus()
    }
    
    /// Retrieves the iCloud account status and updates the `isSignedInToiCloud` property accordingly.
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
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
    
    /// Enum representing CloudKit errors.
    enum CloudKitError: LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
    /// Saves a record to the public database.
    /// - Parameter record: The record to be saved.
    func saveItem(record: CKRecord) {
        p_saveRecord(record: record, usePrivateDatabase: false)
    }
    
    /// Saves a record to the private database.
    /// - Parameter record: The record to be saved.
    func savePrivateItem(record: CKRecord) {
        p_saveRecord(record: record, usePrivateDatabase: true)
    }
    
    /// Private method to save a record to the specified database.
    /// - Parameters:
    ///   - record: The record to be saved.
    ///   - usePrivateDatabase: A flag indicating whether to use the private database or not.
    private func p_saveRecord(record: CKRecord, usePrivateDatabase: Bool) {
        // switch to private database if specified
        let database = usePrivateDatabase ? privateDatabase : publicDatabase
        database.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")
            DispatchQueue.main.async {
                self?.text = ""
            }
        }
    }
    
    /// Private method to fetch records from the specified database.
    /// - Parameters:
    ///   - recordType: The type of records to fetch.
    ///   - usePrivateDatabase: A flag indicating whether to use the private database or not.
    ///   - user: An optional user reference to filter the records.
    ///   - completion: A closure to be called with the fetched records or an error.
    private func p_fetchRecord(recordType: String, usePrivateDatabase: Bool, fieldName: String? = nil, fieldValue: String? = nil, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let predicate: NSPredicate
        // set the predicate to user if not nil, otherwise true
        if let fieldName = fieldName, let fieldValue = fieldValue {
            predicate = NSPredicate(format: "%K == %@", fieldName, fieldValue)
        } else {
            predicate = NSPredicate(value: true)
        }
        // switch to private database if specified
        let database = usePrivateDatabase ? privateDatabase : publicDatabase
        // query the database with recordType, predicate being user if not nil, and no desired keys
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
                    // compactMap to get the records from the matchResults
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

  
    /// Fetches public records from the CloudKit database based on a specified field name and value.
    /// - Parameters:
    ///   - recordType: The type of record to fetch.
    ///   - fieldName: The name of the field to filter the records by.
    ///   - fieldValue: The value of the field to filter the records by.
    ///   - completion: The completion handler that is called when the fetch operation is complete. It returns an array of fetched CKRecords and an optional error.
    func fetchPublicRecord(recordType: String, fieldName: String, fieldValue: String, completion: @escaping ([CKRecord]?, Error?) -> Void)  {
        p_fetchRecord(recordType: recordType, usePrivateDatabase: false, fieldName: fieldName, fieldValue: fieldValue, completion: completion)
    }

    /// Fetches public records from the CloudKit database of a specified record type.
    /// - Parameters:
    ///   - recordType: The type of record to fetch.
    ///   - completion: The completion handler that is called when the fetch operation is complete. It returns an array of fetched CKRecords and an optional error.
    func fetchPublicRecord(recordType: String, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        p_fetchRecord(recordType: recordType, usePrivateDatabase: false, fieldName: nil, fieldValue: nil, completion: completion)
    }

    /// Fetches private records from the CloudKit database based on a specified field name and value.
    /// - Parameters:
    ///   - recordType: The type of record to fetch.
    ///   - fieldName: The name of the field to filter the records by.
    ///   - fieldValue: The value of the field to filter the records by.
    ///   - completion: The completion handler that is called when the fetch operation is complete. It returns an array of fetched CKRecords and an optional error.
    func fetchPrivateRecord(recordType: String, fieldName: String, fieldValue: String, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        p_fetchRecord(recordType: recordType, usePrivateDatabase: true, fieldName: fieldName, fieldValue: fieldValue, completion: completion)
    }

    /// Fetches private records from the CloudKit database of a specified record type.
    /// - Parameters:
    ///   - recordType: The type of record to fetch.
    ///   - completion: The completion handler that is called when the fetch operation is complete. It returns an array of fetched CKRecords and an optional error.
    func fetchPrivateRecord(recordType: String, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        p_fetchRecord(recordType: recordType, usePrivateDatabase: true, fieldName: nil, fieldValue: nil, completion: completion)
    }
}
    
    
    
    
    
    // possible deprecated funcs
    /*private func getiCloudStatus(){
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
    func requestPermission(){
        CKContainer.default().requestApplicationPermission([.userDiscoverability]){
            [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async{
                if returnedStatus == .granted{
                    self?.permissionStatus = true
                }
            }
        }
    }*/
    



struct testview : View{
    
    var cloudKitManager = CloudKitManager.shared
    @State var record = CKRecord(recordType: "Test")
    @State var user = CKRecord.Reference(recordID: CKRecord.ID(recordName: "Test"), action: .none)
    var foodItemDBManager = FoodItemDBManager()
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
            Button("Fetch food items"){
                foodItemDBManager.fetchFoodItems { foodItems, error in
                    if let error = error {
                        print("Error fetching food items: \(error.localizedDescription)")
                        return
                    }
                    guard let foodItems = foodItems else {
                        print("No food items found")
                        return
                    }
                    print("Food items HERE: \(foodItems)")
                }
            }
            Button("Fetch food item Orange"){
                foodItemDBManager.fetchSpecificFoodItem(name: "Orange"){ foodItem, error in
                    if let error = error {
                        print("Error fetching food item: \(error.localizedDescription)")
                        return
                    }
                    guard let foodItem = foodItem else {
                        print("No food item found")
                        return
                    }
                    print("Food item: \(foodItem)")
                }
            }
        }
    }
    // preview
    struct testview_Previews: PreviewProvider {
        static var previews: some View {
            testview()
        }
    }
}

