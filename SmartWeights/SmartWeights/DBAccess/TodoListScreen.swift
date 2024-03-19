import SwiftUI

struct TodoListScreen: View {
    
    @StateObject private var model = Model()
    @State private var taskTitle: String = ""
   
    
    var body: some View {
        VStack {
            TextField("Enter task", text: $taskTitle)
                .textFieldStyle(.roundedBorder)
//                .onSubmit {
//                    // add validation TODO
//                    let taskItem = TaskItem(title: taskTitle, dateAssigned: Date())
//                    Task {
//                        try await model.addTask(taskItem: taskItem)
//                    }
//                }
            Button("Add Item") {
                let taskItem = TaskItem(title: taskTitle, dateAssigned: Date())
                Task {
                    try await model.addTask(taskItem: taskItem)
                }
            }
            
            // segmented control
          
        }
        .padding()
    }
}
