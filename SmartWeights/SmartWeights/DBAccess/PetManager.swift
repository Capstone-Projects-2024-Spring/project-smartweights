import CloudKit

enum PetRecordKeys: String {
    case type = "Pet"
    case health
    case level
    case petImage
    case totalXP
    case user
}

struct PetModel {
    var recordId: CKRecord.ID?
    var health: Int64
    var level: Int64
    var petImage: CKAsset?
    var totalXP: Int64
    var user: CKRecord.Reference
}

extension PetModel {
    var record: CKRecord {
        let record = CKRecord(recordType: PetRecordKeys.type.rawValue)
        record[PetRecordKeys.health.rawValue] = health
        record[PetRecordKeys.level.rawValue] = level
        record[PetRecordKeys.petImage.rawValue] = petImage
        record[PetRecordKeys.totalXP.rawValue] = totalXP
        record[PetRecordKeys.user.rawValue] = user
        return record
    }
}

class PetDBManager: ObservableObject{
    @Published var pet: PetModel?
    let CKManager = CloudKitManager()

    func createPet(){
        let pet = PetModel(health: 100, level: 1, petImage: nil, totalXP: 0, user: CKRecord.Reference(recordID: CKRecord.ID(recordName: ""), action: .none))
        let petRecord = pet.record
        CKManager.savePrivateItem(record: petRecord)
    }
}
