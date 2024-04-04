import CloudKit

enum PetRecordKeys: String {
    case type = "Pet"
    case health
    case level
    case petImage
    case totalXP
    // case user
}

struct PetModel {
    var recordId: CKRecord.ID?
    var health: Int64
    var level: Int64
    var petImage: CKAsset?
    var totalXP: Int64
    // var user: CKRecord.Reference
}

extension PetModel {
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

class PetDBManager: ObservableObject{
    @Published var pet: PetModel?
    let CKManager = CloudKitManager()
    var petExists: Bool = false
    func createPet(){
        if petExists {
            print("Pet already exists.")
            return
        }

        let pet = PetModel(health: 100, level: 1, petImage: nil, totalXP: 0)
        let petRecord = pet.record
        CKManager.savePrivateItem(record: petRecord)
        petExists = true
    }

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

            let pet = PetModel(recordId: record.recordID, health: health, level: level, petImage: petImage, totalXP: totalXP)
            completion(pet, nil)
            self.petExists = true
        }
    }
}
