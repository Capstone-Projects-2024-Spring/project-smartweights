import Foundation
import CloudKit

// AGGREGATE MODEL
class Model: ObservableObject {
    
    private var db = CKContainer.default().privateCloudDatabase
//    @Published private var tasksDictionary: [CKRecord.ID: TaskItem] = [:]
    
//    var tasks: [TaskItem] {
//        tasksDictionary.values.compactMap { $0 }
//    }
    
    func addTask(taskItem: TaskItem) async {
        do{
            let _ = try await db.save(taskItem.record)
            print("success")
        } catch{
            print("Error saving item: \(error)")
        }
     
    }
}
