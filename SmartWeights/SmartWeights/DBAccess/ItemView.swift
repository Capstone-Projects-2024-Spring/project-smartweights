//import SwiftUI
//
//struct AddItemView: View {
//    @State private var name: String = ""
//    @State private var description: String = ""
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//    
//    let viewModel: AddItemViewModel
//    
//    init(viewModel: AddItemViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    var body: some View {
//        VStack {
//            TextField("Name", text: $name)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("Description", text: $description)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            
//            Button("Save") {
//                saveItem()
//            }
//            .padding()
//        }
//        .alert(isPresented: $showAlert) {
//            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//        }
//        .padding()
//    }
//    
//    func saveItem() {
//        guard !name.isEmpty && !description.isEmpty else {
//            alertMessage = "Name and description cannot be empty."
//            showAlert = true
//            return
//        }
//        
//        let newItem = Test(name: name, description: description)
//        viewModel.saveItemToCloud(newItem) { error in
//            if let error = error {
//                alertMessage = "Error saving item: \(error.localizedDescription)"
//                showAlert = true
//            } else {
//                alertMessage = "Item saved successfully!"
//                showAlert = true
//                // Optionally, you can dismiss the view or perform any other action here
//            }
//        }
//    }
//}
//
//struct AddItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemView(viewModel: AddItemViewModel(cloudKitManager: Manager()))
//    }
//}
import SwiftUI

struct ItemView: View {
    @StateObject private var viewModel = ItemViewModel()
    @State private var itemName = ""
    @State private var itemDescription = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $itemName)
            TextField("Description", text: $itemDescription)
            Button("Add Item") {
                let item = ItemModel(name: itemName, description: itemDescription)
                Task{
                    try await viewModel.addItem(itemModel: item)
                }
            }
            
//            List(viewModel.items, id: \.self) { item in
//                VStack(alignment: .leading) {
//                    Text(item.name)
//                        .font(.headline)
//                    Text(item.description)
//                        .font(.subheadline)
//                }
//            }
        }
        .padding()
    }
}
