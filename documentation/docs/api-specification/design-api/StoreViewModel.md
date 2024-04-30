`Class`

# storeViewModel

```swift
class storeViewModel
```
## Topics

### Initializers
```swift
init()
```
### Instance Properties
```swift
var backgroundItemDBManager: BackgroundItemDBManager
let categories: [String]
var clothingItemDBManager: ClothingItemDBManager
var foodItemDBManager: FoodItemDBManager
var inventory: InventoryModel?
var inventoryDBManager: InventoryDBManager
var items: [SellingItem] // Items available in the store.
var petItemDBManager: PetItemDBManager
var selectedCategory: String
var showAlert: Bool
var sortByPrice: Bool
var userCur: Int
var userDBManager: UserDBManager
```

### Instance Methods
```swift
func addFundtoUser(price: Int)
func purchaseItem(item: SellingItem) // Function to handle item purchase.
func sortItems(items: [SellingItem], sortByPrice: Bool) -> [SellingItem] // Display items based on selected sorting method.
func subtractFunds(price: Int) // Function to return amount of currency after item is bought.
Function to return amount of currrency after item is bought
func updateCurrency()
```

### Relationships
#### Conforms To

Combine.ObservableObject

