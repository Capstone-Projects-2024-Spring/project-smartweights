# Database Integration

# Cloud Database

## Class: CloudKitManager

<details>
<summary>
Manages the CloudKit container and databases, providing methods to interact with CloudKit.
</summary>
Acts as the main entry point to CloudKit for any of the classes that will interact with records. This class provides the base methods for CRUD operations.

### Properties
- `static let shared = CloudKitManager()`: The shared singleton instance of `CloudKitManager`.
- `let container: CKContainer`: The CloudKit container.
- `let publicDatabase: CKDatabase`: The public CloudKit database.
- `let privateDatabase: CKDatabase`: The private CloudKit database.
- `@Published var isSignedInToiCloud: Bool`: Indicates whether the user is signed in to iCloud.
- `@Published var error: String`: Any error occurred during CloudKit operations.
- `@Published var text: String`: Additional text data.

### Methods
- `init()`: Initializes the `CloudKitManager` singleton instance.
- `private func getiCloudStatus()`: Retrieves the iCloud account status and updates the `isSignedInToiCloud` property accordingly.
- `func saveItem(record: CKRecord)`: Saves a record to the public database.
- `func savePrivateItem(record: CKRecord, completion: @escaping (Error?) -> Void)`: Saves a record to the private database with a completion handler.
- `private func p_saveRecord(record: CKRecord, usePrivateDatabase: Bool)`: Private method to save a record to the specified database.
- `private func p_fetchRecord(recordType: String, usePrivateDatabase: Bool, fieldName: String?, fieldValue: Any?, completion: @escaping ([CKRecord]?, Error?) -> Void)`: Private method to fetch records from the specified database.
- `func fetchPublicRecord(recordType: String, fieldName: String, fieldValue: Any?, completion: @escaping ([CKRecord]?, Error?) -> Void)`: Fetches public records from the CloudKit database based on a specified field name and value.
- `func fetchPublicRecord(recordType: String, completion: @escaping ([CKRecord]?, Error?) -> Void)`: Fetches public records from the CloudKit database of a specified record type.
- `func fetchPrivateRecord<T>(recordType: String, fieldName: String, fieldValue: T, completion: @escaping ([CKRecord]?, Error?) -> Void)`: Fetches private records from the CloudKit database based on a specified field name and value.
- `func fetchPrivateRecord(recordType: String, completion: @escaping ([CKRecord]?, Error?) -> Void)`: Fetches private records from the CloudKit database of a specified record type.
- `func fetchPrivateRecord(recordID: CKRecord.ID, completion: @escaping (CKRecord?, Error?) -> Void)`: Fetches a single private record from the CloudKit database by its ID.

### Enums
#### Enum: CloudKitError

Enumerates CloudKit errors.

- `case iCloudAccountNotFound`: iCloud account not found error.
- `case iCloudAccountNotDetermined`: iCloud account not determined error.
- `case iCloudAccountRestricted`: iCloud account restricted error.
- `case iCloudAccountUnknown`: Unknown iCloud account error.

</details>

## Class: BackgroundItemDBManager

<details>
<summary>Manages the background items stored in the CloudKit database and provides methods to interact with them.</summary>

### Properties
- `static let shared: BackgroundItemDBManager`: The shared singleton instance of `BackgroundItemDBManager`.
- `@Published var backgroundItems: [BackgroundItemModel]`: The array of background items.
- `let CKManager: CloudKitManager`: The CloudKit manager instance.
- `var backgroundItemExists: Bool`: Indicates if background items exist in the database.
- `@Published var activeBackground: String`: The name of the currently active background item.

### Methods
- `init()`: Initializes the `BackgroundItemDBManager` instance.
- `func fetchBackgroundItems(completion: @escaping ([BackgroundItemModel]?, Error?) -> Void)`: Fetches background items from the CloudKit database.
- `func fetchSpecifcBackgroundItem(imageName: String, completion: @escaping (BackgroundItemModel?, Error?) -> Void)`: Fetches a specific background item by its image name.
- `func createBackgroundItem(imageName: String, completion: @escaping (Error?) -> Void)`: Creates a new background item in the database.
- `func setActiveBackgroundItem(imageName: String, completion: @escaping (String, Error?) -> Void)`: Sets a background item as active.
- `func setUnactiveAllBackgroundItems(completion: @escaping (Error?) -> Void)`: Sets all background items as inactive.
- `func g_getActiveBackground() -> String`: Returns activeBackground.

### Enums

#### Enum: BackgroundItemRecordKeys

Enumerates the keys used for storing background item data in CloudKit.

- `case type = "BackgroundItem"`: Represents the record type for background items in CloudKit.
- `case isActive`: Represents the key for the 'isActive' property in CloudKit records.
- `case imageName`: Represents the key for the 'imageName' property in CloudKit records.

### Structs

#### Struct: BackgroundItemModel

Represents a background item with its properties.

- `var recordId: CKRecord.ID?`: The record ID of the background item.
- `var isActive: Int64`: Indicates whether the background item is active or not.
- `var imageName: String`: The name of the image associated with the background item.

#### Extension: BackgroundItemModel

Provides an extension to `BackgroundItemModel` for generating a CKRecord representation.

- `var record: CKRecord`: Generates and returns a CKRecord representation of the background item.


### Observability
This class conforms to the `ObservableObject` protocol.

</details>

## Class: ClothingItemDBManager

<details>
<summary>Manages the clothing items stored in the CloudKit database and provides methods to interact with them.</summary>

### Properties
- `static let shared: ClothingItemDBManager`: The shared singleton instance of `ClothingItemDBManager`.
- `@Published var clothingItems: [ClothingItemModel]`: The array of clothing items.
- `let CKManager: CloudKitManager`: The CloudKit manager instance.
- `var clothingItemExists: Bool`: Indicates if clothing items exist in the database.
- `@Published var activeClothing: String`: The name of the currently active clothing item.

### Methods
- `init()`: Initializes the `ClothingItemDBManager` instance.
- `func fetchClothingItems(completion: @escaping ([ClothingItemModel]?, Error?) -> Void)`: Fetches clothing items from the CloudKit database. Upon completion, sets the `clothingItems` property.
- `func fetchSpecificClothingItem(imageName: String, completion: @escaping (ClothingItemModel?, Error?) -> Void)`: Fetches a specific clothing item by its image name.
- `func createClothingItem(imageName: String, completion: @escaping (Error?) -> Void)`: Creates a new clothing item in the database.
- `func setActiveClothingItem(imageName: String, completion: @escaping (String, Error?) -> Void)`: Sets a clothing item as active. Upon completion, sets the `activeClothing` property.
- `func setUnactiveAllClothingItems(completion: @escaping (Error?) -> Void)`: Sets all clothing items as inactive.
- `func g_getActiveClothing() -> String`: Returns activeClothing.
- `func getActiveClothing(completion: @escaping (String, Error?) -> Void)`: Fetches the active clothing item from the database.

### Enums
#### Enum: ClothingItemRecordKeys

Enumerates the keys used for storing clothing item data in CloudKit.

- `case type = "ClothingItem"`: Represents the record type for clothing items in CloudKit.
- `case isActive`: Represents the key for the 'isActive' property in CloudKit records.
- `case imageName`: Represents the key for the 'imageName' property in CloudKit records.

### Structs
#### Struct: ClothingItemModel

Represents a clothing item with its properties.

- `var recordId: CKRecord.ID?`: The record ID of the clothing item.
- `var isActive: Int64`: Indicates whether the clothing item is active or not.
- `var imageName: String`: The name of the image associated with the clothing item.

#### Extension: ClothingItemModel

Provides an extension to `ClothingItemModel` for generating a CKRecord representation.

- `var record: CKRecord`: Generates and returns a CKRecord representation of the clothing item.


### Observability
This class conforms to the `ObservableObject` protocol.
</details>


## Class: FitnessPlanDBManager

<details>
<summary>Manages fitness plans stored in the CloudKit database and provides methods to interact with them.</summary>

### Properties
- `@Published var fitnessPlan: FitnessPlanModel?`: The fitness plan model.
- `let CKManager: CloudKitManager`: The CloudKit manager instance.
- `var fitnessPlanExists: Bool`: Indicates whether a fitness plan exists in the database.

### Methods
- `init()`: Initializes the `FitnessPlanDBManager` instance.
- `func createFitnessPlan(daysPerWeekGoal: Int64, dumbbellWeightGoal: Int64, setGoal: Int64, repGoal: Int64, notes: String, selectedDate: Date)`: Creates or updates a fitness plan in the database.
- `func fetchFitnessPlan(completion: @escaping (FitnessPlanModel?, Error?) -> Void)`: Fetches the fitness plan from the CloudKit database.

### Enums
#### Enum: FitnessPlanRecordKeys

Enumerates the keys used for storing fitness plan data in CloudKit.

- `case type = "FitnessPlan"`: Represents the record type for fitness plans in CloudKit.
- `case daysPerWeekGoal`: Represents the key for the 'daysPerWeekGoal' property in CloudKit records.
- `case dumbbellWeightGoal`: Represents the key for the 'dumbbellWeightGoal' property in CloudKit records.
- `case setGoal`: Represents the key for the 'setGoal' property in CloudKit records.
- `case repGoal`: Represents the key for the 'repGoal' property in CloudKit records.
- `case notes`: Represents the key for the 'notes' property in CloudKit records.
- `case selectedDate`: Represents the key for the 'selectedDate' property in CloudKit records.

### Structs
#### Struct: FitnessPlanModel

Represents a fitness plan with its properties.

- `var recordId: CKRecord.ID?`: The record ID of the fitness plan.
- `var daysPerWeekGoal: Int64`: The goal for the number of days per week.
- `var dumbbellWeightGoal: Int64`: The goal for the dumbbell weight.
- `var setGoal: Int64`: The goal for the number of sets.
- `var repGoal: Int64`: The goal for the number of reps.
- `var notes: String`: Any additional notes for the fitness plan.
- `var selectedDate: Date`: The selected date for the fitness plan.

#### Extension: FitnessPlanModel

Provides an extension to `FitnessPlanModel` for generating a CKRecord representation.

- `var record: CKRecord`: Generates and returns a CKRecord representation of the fitness plan.


### Observability
This class conforms to the `ObservableObject` protocol.
</details>


## Class: FoodItemDBManager

<details>
<summary>Manages food items and their interactions with the CloudKit database.</summary>

### Properties
- `static let shared = FoodItemDBManager()`: The shared singleton instance of `FoodItemDBManager`.
- `@Published var foodItems: [FoodItemModel]`: An array of food items.
- `let CKManager = CloudKitManager()`: The CloudKit manager.
- `var foodItemExists: Bool`: Indicates whether food items exist.

### Methods
- `init()`: Initializes the `FoodItemDBManager` singleton instance.
- `func fetchFoodItems(completion: @escaping ([FoodItemModel]?, Error?) -> Void)`: Fetches all food items from the CloudKit database.
- `func createInitialFoodItems()`: Creates initial food items if none exist.
- `func createFoodItem(name: String, quantity: Int64, completion: @escaping (Error?) -> Void)`: Creates a new food item with the given name and quantity.
- `func fetchSpecificFoodItem(name: String, completion: @escaping (FoodItemModel?, Error?) -> Void)`: Fetches a specific food item by its name.
- `func fetchQuantity(name: String, completion: @escaping (Int64?, Error?) -> Void)`: Fetches the quantity of a specific food item by its name.
- `func updateQuantity_add(name: String, quantity: Int64, completion: @escaping (Error?) -> Void)`: Updates the quantity of a food item by adding the specified quantity.
- `func updateQuantity(name: String, newQuantity: Int64, completion: @escaping (Error?) -> Void)`: Updates the quantity of a food item with the specified quantity.
- `func updateQuantity(foodItem: FoodItemModel, newQuantity: Int64, completion: @escaping (Error?) -> Void)`: Updates the quantity of a food item.
- `func getFoodItems() -> [FoodItemModel]`: Returns foodItems.

### Enums
#### Enum: FoodItemRecordKeys

Enumerates the keys used for food item records in CloudKit.

- `case type = "FoodItem"`: Record type key.
- `case name`: Name key.
- `case quantity`: Quantity key.
- `case imageName`: Image name key.

### Struct: FoodItemModel

Represents a food item.

#### Properties
- `var recordId: CKRecord.ID?`: The record ID.
- `var name: String`: The name of the food item.
- `var quantity: Int64`: The quantity of the food item.
- `var imageName: String`: The name of the image associated with the food item.

#### Extension: 

Provides an extension to `FoodItemModel` for generating a CKRecord representation.

- `var record: CKRecord`: Generates and returns a CKRecord representation of the food item.


### Observability
This class conforms to the `ObservableObject` protocol.

</details>


## Class: PetItemDBManager

<details>
<summary>Manages pet items and their interactions with the CloudKit database.</summary>

### Properties
- `static let shared = PetItemDBManager()`: The shared singleton instance of `PetItemDBManager`.
- `@Published var petItems: [PetItemModel]`: An array of pet items.
- `let CKManager = CloudKitManager()`: The CloudKit manager.
- `var petItemExists: Bool`: Indicates whether pet items exist.
- `@Published var activePet: String`: The name of the active pet.

### Methods
- `init()`: Initializes the `PetItemDBManager` singleton instance.
- `func g_getActivePet() -> String`: Returns activePet.
- `func fetchPetItems(completion: @escaping ([PetItemModel]?, Error?) -> Void)`: Fetches all pet items from the CloudKit database.
- `func fetchSpecificPetItem(imageName: String, completion: @escaping (PetItemModel?, Error?) -> Void)`: Fetches a specific pet item by its image name.
- `func createPetItem(imageName: String, completion: @escaping (Error?) -> Void)`: Creates a new pet item with the given image name.
- `func createDefaultPet()`: Creates a default pet if none exist.
- `func setActivePetItem(imageName: String, completion: @escaping (String, Error?) -> Void)`: Sets the active pet item by its image name.
- `func getActivePet(completion: @escaping (String, Error?) -> Void)`: Retrieves the active pet.

### Struct: PetItemModel

Represents a pet item.

#### Properties
- `var recordId: CKRecord.ID?`: The record ID.
- `var isActive: Int64`: Indicates whether the pet item is active.
- `var petName: String`: The name of the pet.
- `var imageName: String`: The name of the image associated with the pet.

#### Methods
- `var record: CKRecord`: Converts the `PetItemModel` to a `CKRecord` object.

### Enums
#### Enum: PetItemRecordKeys

Enumerates the keys used for pet item records in CloudKit.

- `case type = "PetItem"`: Record type key.
- `case isActive`: Active state key.
- `case petName`: Pet name key.
- `case imageName`: Image name key.

### Observability
This class conforms to the `ObservableObject` protocol.

</details>

## Class: PetDBManager

<details>
<summary>Manages pet data and interactions with the CloudKit database.</summary>

### Properties
- `static let shared = PetDBManager()`: The shared singleton instance of `PetDBManager`.
- `@Published var pet: PetModel?`: The pet model.
- `let CKManager = CloudKitManager()`: The CloudKit manager.
- `var petExists: Bool`: Indicates whether a pet exists.
- `@Published var totalXP: Int64`: The total experience points (XP) of the pet.
- `@Published var level: Int64`: The level of the pet.
- `@Published var health: Int64`: The health of the pet.

### Methods
- `init()`: Initializes the `PetDBManager` singleton instance and fetches the pet from the database.
- `func createPet()`: Creates a new pet in the database.
- `func fetchPet(completion: @escaping (PetModel?, Error?) -> Void)`: Fetches the pet from the database.
- `func getHealth() -> Int`: Returns health.
- `func getXP(completion: @escaping (Int64?, Error?) -> Void)`: Retrieves the total XP of the pet.
- `func getXP() -> Int`: Returns totalXP.
- `func getLevel() -> Int`: Returns level.
- `func getLevel(completion: @escaping (Int64?, Error?) -> Void)`: Retrieves the level of the pet.
- `func getPet() -> PetModel?`: Returns pet.
- `func updateUserXP(newXP: Int64, completion: @escaping (Error?) -> Void)`: Updates the user's XP.
- `func updateUserLevel(newLevel: Int64, completion: @escaping (Error?) -> Void)`: Updates the user's level.
- `func updatePetHealth(newHealth: Int64, completion: @escaping (Error?) -> Void)`: Updates the pet's health.


### Struct: PetModel

Represents a pet.

#### Properties
- `var recordId: CKRecord.ID?`: The record ID.
- `var health: Int64`: The health of the pet.
- `var level: Int64`: The level of the pet.
- `var petImage: CKAsset?`: The image of the pet.
- `var totalXP: Int64`: The total XP of the pet.

#### Methods
- `var record: CKRecord`: Converts the `PetModel` to a `CKRecord` object.

### Enums
#### Enum: PetRecordKeys

Enumerates the keys used for pet records in CloudKit.

- `case type = "Pet"`: Record type key.
- `case health`: Health key.
- `case level`: Level key.
- `case petImage`: Pet image key.
- `case totalXP`: Total XP key.

### Observability
This class conforms to the `ObservableObject` protocol.

</details>

## Class: UserDBManager

<details>
<summary>Manages user data and interactions with the CloudKit database.</summary>

### Properties
- `@Published var user: User?`: The user model.
- `@Published var userRecord: CKRecord.Reference?`: The user record reference.
- `var userExists: Bool`: Indicates whether a user exists.
- `let CKManager = CloudKitManager()`: The CloudKit manager.

### Methods
- `init()`: Initializes the `UserDBManager` and fetches the current user record ID and user data.
- `func fetchCurrentUserRecordID(completion: @escaping (Error?) -> Void)`: Fetches the record ID of the current user.
- `func createUser(firstName: String?, lastName: String?, email: String?)`: Creates a new user with the given information.
- `func fetchUser(completion: @escaping (User?, Error?) -> Void)`: Fetches the user data from the database.
- `func getCurrency(completion: @escaping (Int64?, Error?) -> Void)`: Retrieves the currency value of the user.
- `func updateCurrency(newCurrency: Int64, completion: @escaping (Error?) -> Void)`: Updates the currency value of the user.
- `func getName(completion: @escaping (String?, Error?) -> Void)`: Retrieves the full name of the user.
- `func updateName(newFirstName: String?, newLastName: String?, completion: @escaping (Error?) -> Void)`: Updates the first name and/or last name of the user.

### Struct: User

Represents a user.

#### Properties
- `var recordId: CKRecord.ID?`: The record ID.
- `var firstName: String`: The first name of the user.
- `var lastName: String`: The last name of the user.
- `var latestLogin: Date`: The latest login date of the user.
- `var currency: Int64`: The currency of the user.
- `var email: String`: The email of the user.

#### Methods
- `var record: CKRecord`: Converts the `User` to a `CKRecord` object.

### Enums
#### Enum: UserRecordKeys

Enumerates the keys used for user records in CloudKit.

- `case type = "User"`: Record type key.
- `case firstName`: First name key.
- `case lastName`: Last name key.
- `case latestLogin`: Latest login key.
- `case currency`: Currency key.
- `case email`: Email key.

### Observability
This class conforms to the `ObservableObject` protocol.

</details>


