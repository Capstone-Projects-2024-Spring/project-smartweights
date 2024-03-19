import Foundation
import CloudKit

enum TaskRecordKeys: String {
    case type = "TaskItem"
    case title
    case dateAssigned
    case isCompleted
}

struct TaskItem {
    
    var recordId: CKRecord.ID?
    let title: String
    let dateAssigned: Date
    var isCompleted: Bool = false
    
}

//extension TaskItem {
//    init?(record: CKRecord) {
//        guard let title = record[TaskRecordKeys.title.rawValue] as? String,
//              let dateAssigned = record[TaskRecordKeys.dateAssigned.rawValue] as? Date,
//              let isCompleted = record[TaskRecordKeys.isCompleted.rawValue] as? Bool else {
//            return nil
//        }
//        
//        self.init(recordId: record.recordID, title: title, dateAssigned: dateAssigned, isCompleted: isCompleted)
//    }
//}

extension TaskItem {
    
    var record: CKRecord {
        let record = CKRecord(recordType: TaskRecordKeys.type.rawValue)
        record[TaskRecordKeys.title.rawValue] = title
        record[TaskRecordKeys.dateAssigned.rawValue] = dateAssigned
        record[TaskRecordKeys.isCompleted.rawValue] = isCompleted
        return record
    }
    
}
