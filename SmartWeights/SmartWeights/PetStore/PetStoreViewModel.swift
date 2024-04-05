
import SwiftUI
import CloudKit
/// StoreViewModel class with items list and needed variables.

class storeViewModel: ObservableObject {
    
//    var cloudKitManager = CloudKitManager()
    var inventoryDBManager = InventoryDBManager()
    var userDBManager = UserDBManager()
    var foodItemDBManager = FoodItemDBManager()
    
    /// Items available in store.
    @Published var items = [
        SellingItem(id: 1, name: "Dog", category: "Pets", price: "500", image: Image("dog"), description: "The best companion!"),
        SellingItem(id: 2, name: "Cat", category: "Pets", price: "500", image: Image("cat"), description: "Has 9 lives!"),
        SellingItem(id: 3, name: "Dinosaur", category: "Pets", price: "700", image: Image("dinosaur"), description: "Only 250 million years old!"),
        SellingItem(id: 4, name: "Orange", category: "Foods", price: "10", image: Image("orange"), description: "Gives 20 health. MAX: 10"),
        SellingItem(id: 5, name: "Apple", category: "Foods", price: "10", image: Image("apple"), description: "Gives 10 health. MAX: 10"),
        SellingItem(id: 6, name: "Juice", category: "Foods", price: "20", image: Image("juice"), description: "Gives 10 health. MAX: 10"),
        SellingItem(id: 7, name: "Jetpack", category: "Backgrounds", price: "400", image: Image("jetpack"), description: "Walking is overrated."),
        SellingItem(id: 8, name: "Flag", category: "Backgrounds", price: "200", image: Image("flag"), description: "Works great in the wind!"),
        SellingItem(id: 9, name: "Sand Castle", category: "Backgrounds", price: "300", image: Image("sandcastle"), description: "Watch out for waves!"),
        SellingItem(id: 10, name: "Floral Glasses", category: "Outfits", price: "250", image: Image("glasses"), description: "100% UV Protection."),
        SellingItem(id: 11, name: "Pet Chain", category: "Outfits", price: "200", image: Image("chain"), description: "Fashionably tasteful.")
    ]
    
    @Published var showAlert = false
    @Published var sortByPrice = false // used for sorting
    @Published var selectedCategory = "Pets" // Default
    let categories = ["Pets", "Foods", "Backgrounds", "Outfits"]
    @Published var userCur = 0 // Default currency
    var inventory: InventoryModel?
    
    init() {
        updateCurrency()
    }

    func updateCurrency() {
        userDBManager.getCurrency { (currency, error) in
            if let error = error {
                print("Error getting currency: \(error.localizedDescription)")
            } else if let currency = currency {
                DispatchQueue.main.async {
                    self.userCur = Int(currency)
                }
            }
        }
    }

    /// Display items based on selected sorting method.
    func sortItems(items: [SellingItem], sortByPrice: Bool) -> [SellingItem] {
        if sortByPrice {
            return items.sorted { (item1, item2) in
                let price1 = Int(item1.price) ?? 0
                let price2 = Int(item2.price) ?? 0
                return price1 < price2
            }
        } else {
            return items.sorted { $0.name < $1.name }
        }
    }
    /// Function to return amount of currrency after item is bought
    func subtractFunds(price: Int) {
        print("Subtracting \(price) from \(userCur)")
       
        
        print("userCur: \(self.userCur - price)")
        userDBManager.updateCurrency(newCurrency: Int64(userCur-price)){
            error in
            if let error = error {
                print("Error updating currency: \(error.localizedDescription)")
            }
        }
        return userCur = userCur - price
    }
    
    /// Function to handle item purchase
        func purchaseItem(item: SellingItem) {
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                if item.category != "Foods" {
                    items[index].isBought = true
                }
                subtractFunds(price: Int(item.price) ?? 0)
                foodItemDBManager.createFoodItem(name: item.name, quantity: 1) { error in
                    if let error = error {
                        print("Error creating food item: \(error.localizedDescription)")
                    }
                }
            }
        }
    
    
    func addFundtoUser(price: Int) {
        print("Adding \(price) to \(userCur)")
       
        
        print("userCur: \(self.userCur + price)")
        userDBManager.updateCurrency(newCurrency: Int64(userCur+price)){
            error in
            if let error = error {
                print("Error updating currency: \(error.localizedDescription)")
            }
        }
        return userCur = userCur + price
    }
}

