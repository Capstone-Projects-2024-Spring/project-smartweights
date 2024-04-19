import CloudKit

/// Enum representing the keys used in the Pet record.
enum PetRecordKeys: String {
    case type = "Pet"
    case health
    case level
    case petImage
    case totalXP
    // case user
}

/// Struct representing the Pet model.
struct PetModel {
    var recordId: CKRecord.ID?
    var health: Int64
    var level: Int64
    var petImage: CKAsset?
    var totalXP: Int64
    // var user: CKRecord.Reference
}

extension PetModel {
    /// Computed property that returns the CKRecord representation of the Pet model.
    var record: CKRecord {
        let record = CKRecord(recordType: PetRecordKeys.type.rawValue)
        record[PetRecordKeys.health.rawValue] = health
        record[PetRecordKeys.level.rawValue] = level
        record[PetRecordKeys.petImage.rawValue] = petImage
        record[PetRecordKeys.totalXP.rawValue] = totalXP
        // record[PetRecordKeys.user.rawValue] = user
        return record
    }
}

/// Class responsible for managing the Pet database operations.
class PetDBManager: ObservableObject {
    @Published var pet: PetModel?
    let CKManager = CloudKitManager()
    var petExists: Bool = false
    
    /// Initializes the PetDBManager and fetches the pet from the database.
    init() {
        fetchPet { pet, error in
            if let error = error {
                print("Error fetching pet: \(error.localizedDescription)")
                return
            }
            // guard let pet = pet else {
            //     print("No pet found")
            //     return
            // }
            // self.pet = pet
        }
    }
    
    /// Creates a new pet in the database.
    func createPet() {
        if petExists {
            print("Pet already exists.")
            return
        }

        let pet = PetModel(health: 100, level: 1, petImage: nil, totalXP: 0)
        let petRecord = pet.record
        CKManager.savePrivateItem(record: petRecord)
        petExists = true
    }

    /// Fetches the pet from the database.
    /// - Parameter completion: A closure to be called when the fetch operation is complete.
    func fetchPet(completion: @escaping (PetModel?, Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "Pet") { records, error in
            if let error = error {
                print("Error fetching pet: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let record = records?.first else {
                self.petExists = false
                print("No pet record found")
                completion(nil, nil)
                return
            }
            let health = record[PetRecordKeys.health.rawValue] as? Int64 ?? 0
            let level = record[PetRecordKeys.level.rawValue] as? Int64 ?? 0
            let petImage = record[PetRecordKeys.petImage.rawValue] as? CKAsset
            let totalXP = record[PetRecordKeys.totalXP.rawValue] as? Int64 ?? 0

            self.pet = PetModel(recordId: record.recordID, health: health, level: level, petImage: petImage, totalXP: totalXP)
            completion(self.pet, nil)
            self.petExists = true
        }
    }
    func getXP(completion: @escaping (Int64?, Error?) -> Void){
        if let pet = pet {
            completion(pet.totalXP, nil)
        } else {
            fetchPet { pet, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let pet = pet else {
                    completion(nil, nil)
                    return
                }
                completion(self.pet?.totalXP, nil)
            }
        }
    }
    func updateUserXP(newXP: Int64, completion: @escaping (Error?) -> Void) {
        CKManager.fetchPrivateRecord(recordType: "Pet") { records, error in
            guard let record = records?.first else {
                print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                completion(error)
                return
            }
            
            let currentXP = NSNumber(value: newXP)
            record[PetRecordKeys.totalXP.rawValue] = currentXP as CKRecordValue
            self.CKManager.savePrivateItem(record: record)
            completion(nil)
        }
    }
    
    func updateUserXP(newXP: Int64, completion: @escaping (Error?) -> Void) {
        DispatchQueue.main.async {
            self.pet?.totalXP = newXP  // Update local model first for immediate UI update
        }
        
        guard let petRecordId = self.pet?.recordId else {
            completion(NSError(domain: "PetErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing pet record ID"]))
            return
        }

        CloudKitManager.shared.fetchPrivateRecord(recordID: petRecordId) { [weak self] record, error in
            guard let record = record else {
                completion(error ?? NSError(domain: "PetErrorDomain", code: -2, userInfo: [NSLocalizedDescriptionKey: "Could not fetch record"]))
                return
            }

            record[PetRecordKeys.totalXP.rawValue] = newXP as CKRecordValue
            CloudKitManager.shared.savePrivateItem(record: record) { saveError in
                completion(saveError)  // Notify of any error during save
            }
        }
    }
    
    func updatePetHealth(newHealth: Int64, completion: @escaping (Error?) -> Void) {
        guard let petRecordId = pet?.recordId else {
            let error = NSError(domain: "PetErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing pet record ID"])
            print(error.localizedDescription)
            completion(error)
            return
        }

        CloudKitManager.shared.fetchPrivateRecord(recordID: petRecordId) { [weak self] record, error in
            guard let record = record else {
                let fetchError = error ?? NSError(domain: "PetErrorDomain", code: -2, userInfo: [NSLocalizedDescriptionKey: "Could not fetch record"])
                print(fetchError.localizedDescription)
                completion(fetchError)
                return
            }

            record[PetRecordKeys.health.rawValue] = newHealth as CKRecordValue
            CloudKitManager.shared.savePrivateItem(record: record) { saveError in
                if let saveError = saveError {
                    print("Failed to update pet HP: \(saveError.localizedDescription)")
                } else {
                    self?.pet?.health = newHealth // Update local pet model
                    print("Pet HP updated to \(newHealth).")
                }
                completion(saveError)
            }
        }
    }


    
}
