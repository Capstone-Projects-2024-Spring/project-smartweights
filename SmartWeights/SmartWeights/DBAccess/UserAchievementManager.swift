import CloudKit

/// Keys used to access the fields in the UserAchievement record.
enum UserAchievementRecordKeys: String {
    case type = "UserAchievement"
    case achievement
    case currentProgress
    case isCompleted
    // case user
}

/// Represents a user achievement.
struct UserAchievement {
    var recordId: CKRecord.ID?
    var achievement: CKRecord.Reference
    var currentProgress: Int64
    var isCompleted: Int64
    // var user: CKRecord.Reference

    //potential implementation just to have isCompleted be a boolean
    //  var isCompletedInt: Int64

    // var isCompleted: Bool {
    //     get { return isCompletedInt != 0 }
    //     set { isCompletedInt = newValue ? 1 : 0 }
    // }
}

extension UserAchievement {
    /// Returns the CloudKit record representation of the user achievement.
    var record: CKRecord {
        let record = CKRecord(recordType: UserAchievementRecordKeys.type.rawValue)
        record[UserAchievementRecordKeys.achievement.rawValue] = achievement
        record[UserAchievementRecordKeys.currentProgress.rawValue] = currentProgress
        record[UserAchievementRecordKeys.isCompleted.rawValue] = isCompleted
        // record[UserAchievementRecordKeys.user.rawValue] = user
        return record
    }
}

/// Manages the user achievements in the database.
class UserAchievementDBManager: ObservableObject {
    @Published var userAchievement: UserAchievement?
    let CKManager = CloudKitManager()

    /// Creates a new user achievement and saves it to the database.
    /// - Parameter achievement: The reference to the achievement.
    func createUserAchievement(achievement: CKRecord.Reference) {
        let userAchievement = UserAchievement(achievement: achievement, currentProgress: 0, isCompleted: 0)
        let userAchievementRecord = userAchievement.record
        CKManager.savePrivateItem(record: userAchievementRecord)
    }
}
