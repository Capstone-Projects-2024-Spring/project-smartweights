# Design API


# Hardware Software

## Class: MPU6050
Class for reading gyro rates and acceleration data from an MPU-6050 module via I2C.

<details>



- `read_accel_data() → tuple[float, float, float]`: Read the accelerometer data, in a (x, y, z) tuple.
- `read_accel_range() → int`: Reads the accelerometer range setting.
- `read_gyro_data() → tuple[float, float, float]`: Read the gyroscope data, in a (x, y, z) tuple.
- `read_gyro_range() → int`: Reads the gyroscope range setting.
- `read_temperature() → float`: Reads the temperature, in Celsius, of the onboard temperature sensor.
- `sleep() → None`: Places MPU-6050 in sleep mode (low power consumption).
- `wake() → None`: Wake up the MPU-6050.
- `who_am_i() → int`: Returns the address of the MPU-6050.
- `write_accel_range(range: int) → None`: Sets the accelerometer range setting.
- `write_gyro_range(range: int) → None`: Sets the gyroscope range setting.
- `write_lpf_range(range: int) → None`: Sets low pass filter range.

</details>


## Class: main
A class that is responsible for advertising data via Bluetooth


<details>



- `advertising_payload(limited_disc=False, br_edr=False, name=None, services=None, appearance=0)`: Generate a payload for advertising.
- `decode_field(payload, adv_type)`: Decode a field from an advertising payload.
- `decode_name(payload)`: Decode the local name from an advertising payload.
- `decode_services(payload)`: Decode a list of UUIDs from an advertising payload.
- `demo()`: Run a demonstration.
  
</details>

## Class: MPU Data

<details>

Class to get accelerometer and gyroscope data.

- `__init__(id: str)`: The ID of the MPU6050 sensor.
- `get_accel_data() → tuple`: Get the accelerometer data.
- `get_gyro_data() → tuple`: Get the gyroscope data.

</details>

## Class: BLEcentral

BLEcentral is a class that manages a central role in a Bluetooth Low Energy (BLE) connection. It conforms to `NSObject`, `CBCentralManagerDelegate`, `CBPeripheralDelegate`, and `ObservableObject`.


<details>



### Overview

This class is responsible for scanning for, connecting to, and disconnecting from peripherals.

**Note:** This class specifically looks for peripherals named “MPU6050-1” and “MPU6050-2”.

### Initializers

 `init()`
Initializes the central manager and starts scanning for peripherals with the specified service UUIDs.

### Instance Properties

- `MPU6050_1Accelerations: [[Int]]`
- `MPU6050_1Gyros: [[Int]]`
- `MPU6050_1_Accel: [Int]`
- `MPU6050_1_All_Accelerations: [[Int]]`
- `MPU6050_1_All_Gyros: [[Int]]`
- `MPU6050_1_Gyro: [Int]`
- `MPU6050_2Accelerations: [[Int]]`
- `MPU6050_2Gyros: [[Int]]`
- `MPU6050_2_Accel: [Int]`
- `MPU6050_2_All_Accelerations: [[Int]]`
- `MPU6050_2_All_Gyros: [[Int]]`
- `MPU6050_2_Gyro: [Int]`
- `MPU_1_Connected: Bool`: A boolean that indicates whether MPU6050-1 is connected.
- `MPU_2_Connected: Bool`: A boolean that indicates whether MPU6050-2 is connected.
- `collectDataToggle: Bool`: A boolean that toggles whether the app should collect data from the peripherals.
- `isConnected: Bool`
- `listOfPeripherals: [Any]`
- `peripheralData: [AnyHashable : Any]`

### Instance Methods

- `func centralManager(CBCentralManager, didConnect: CBPeripheral)`: Discovers services on the peripheral.
- `func centralManager(CBCentralManager, didDisconnectPeripheral: CBPeripheral, error: Error?)`: Scans for peripherals with the specified service UUIDs.
- `func centralManager(CBCentralManager, didDiscover: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber)`: Connects to the peripheral with the specified service UUID.
- `func centralManager(CBCentralManager, didFailToConnect: CBPeripheral, error: Error?)`: Discovers the characteristics of the service on the peripheral.
- `func centralManagerDidUpdateState(CBCentralManager)`: Scans for devices with the AccelServiceUUID.
- `func peripheral(CBPeripheral, didDiscoverCharacteristicsFor: CBService, error: Error?)`: Discovers the characteristics of the service on the peripheral.
- `func peripheral(CBPeripheral, didDiscoverServices: Error?)`: Discovers the characteristics of the service on the peripheral.
- `func peripheral(CBPeripheral, didUpdateValueFor: CBCharacteristic, error: Error?)`: Gets the updated data from the characteristic.


</details>


# Classes

## Class: FormCriteria

<details>

`FormCriteria` is a class that contains the criteria for determining the form of the user during a workout.

### Initializers

- `init()`: Initializes a new instance of `FormCriteria`.

### Instance Properties

- `var dumbbellDangerousCheck: [[Int]]`
- `var elbowDangerousCheck: [[Int]]`
- `var goodFormPhrases: [String]`
- `var listOfDumbbellAverage: [Double]`
- `var listOfElbowFlareForwardBackAverage: [Double]`
- `var listOfElbowFlareUpDownAverage: [Double]`
- `var listOfElbowSwingAverage: [Double]`
- `var listOfWristLeftRightAverage: [Double]`
- `var listOfWristUpDownAverage: [Double]`
- `var workoutAnalysis: [String : Double]`

### Instance Methods

- `func UpdateWorkoutAnalysis(totalSets: Int, dumbbellArray: [[Int]], elbowArray: [[Int]]) -> [String : Double]`: Updates the workout analysis based on the data collected during the workout.
- `func averageElbowFlareForwardBack(array: [[Int]]) -> Double`: Calculates the average elbow flare of the user during a set.
- `func averageElbowFlareUpDown(array: [[Int]]) -> Double`: Calculates the average elbow flare of the user during a set.
- `func averageElbowSwing(array: [[Int]], append: Bool) -> Double`: Calculates the average elbow swing of the user during a set.
- `func averageUpDownAcceleration(array: [[Int]], append: Bool) -> Double`: Calculates the average up and down acceleration of the dumbbell during a set.
- `func averageWristLeftRightRotation(array: [[Int]]) -> Double`: Calculates the average left and right rotation of the wrist during a set.
- `func averageWristUpDownRotation(array: [[Int]]) -> Double`: Calculates the average up and down rotation of the wrist during a set.
- `func dangerousForm(dumbbellData: [Int], elbowData: [Int]) -> Bool`: Checks if the user is moving too fast and is in a dangerous position.
- `func getRandomGoodFormPhrase() -> String`: Gets a random good form phrase.
- `func giveFeedback(dumbbellArray: [[Int]], elbowArray: [[Int]]) -> (String, String, String, String)`: Provides feedback to the user based on the data collected during the workout.
- `func overallDumbbellTwisting(totalSets: Int) -> (Double, Double)`: Calculates the overall average of the left and right and up and down rotation of the wrist for the entire workout.
- `func overallWorkoutElbowFlare(totalSets: Int) -> (Double, Double)`: Calculates the overall average of the elbow flare for the entire workout.
- `func overallWorkoutElbowSwing(totalSets: Int) -> Double`: Calculates the overall average of the elbow swing for the entire workout.
- `func overallWorkoutUpDownAverage(totalSets: Int) -> Double`: Calculates the overall average of the up and down acceleration of the dumbbell for the entire workout.
- `func resetListofData()`: Clears the data for the next workout.

</details>


## Class: WorkoutViewModel

<details>

View model to handle the workout data.

### Initializers

`init(ble: BLEcentral, formCriteria: FormCriteria, coreDataManager: CoreDataManager)`

Initialize the view model.

### Instance Properties

- `WorkoutState: WorkoutStateEnum`
- `alertMessage: String`
- `ble: BLEcentral`
- `coreDataManager: CoreDataManager`
- `countdown: Int`
- `countdownActive: Bool`
- `countdownPlayer: AVAudioPlayer!`
- `currentMotivationalPhrase: String`
- `currentSets: Int`
- `feedback: (String, String, String, String)`
- `feedbackDataForSets: [(String, String, String, String)]`
- `formCriteria: FormCriteria`
- `hasWorkoutStarted: Bool`
- `hours: Int`
- `inputNode: AVAudioInputNode!`
- `inputtedCountdown: String`
- `inputtedReps: String`
- `inputtedSets: String`
- `inputtedWeights: String`
- `isListening: Bool`
- `isWorkingOut: Bool`
- `isWorkoutPaused: Bool`
- `minutes: Int`
- `player: AVAudioPlayer!`
- `progress: Double`
- `progressInterval: Double`
- `recordingFormat: AVAudioFormat!`
- `seconds: Int`
- `showGraphPopover: Bool`
- `showingAlert: Bool`
- `showingWorkoutSheet: Bool`
- `storeModel: storeViewModel`
- `timer: Timer?`
- `timerIsActive: Bool`
- `totalSets: Int`
- `workoutAnalysis: [String : Double]`
- `workoutAnalysisForSets: [[String : Double]]`
- `workoutInProgress: Bool`
- `workoutInProgressPublisher: AnyPublisher`
- `var workoutNum: Int64`
- `let workoutPageViewModel: WorkoutPageViewModel`

### Instance Methods

- `func checkDangerousFormWhileWorkingOut()`: Function to check for dangerous form while working out.
- `func countdownSound()`: Function to play the countdown sound when the workout is about to start.
- `func finalset()`: Function to finish the workout.
- `func finishSet()`: Function to finish the current set.
- `func finishWorkout()`: Function to finish the workout.
- `func isInputZeroOrInvalid() -> Bool`: Function to check if any input is zero or invalid.
- `func isValidInput(String) -> Bool`: Function to check if the input is valid.
- `func nextset()`: Function to start the next set.
- `func pauseTimer()`: Function to pause the workout timer.
- `func playSound()`: Function to play the alarm sound.
- `func resetTimer()`: Function to reset the workout timer.
- `func resetWorkoutState()`: Function to reset the workout state.
- `func restartTimer()`: Function to restart the workout timer.
- `func resumeTimer()`: Function to resume the workout timer.
- `func simpleCountdown()`: Function to start the countdown clock for between sets.
- `func startCountdown()`: Function to start the countdown clock.
- `func startListening()`: Function to start listening for voice commands.
- `func startTimer()`: Function to start the workout timer.
- `func startWorkout()`: Function to start the workout.
- `func stopCountdownSound()`: Function to stop the countdown sound.
- `func stopSound()`: Function to stop the alarm sound.
- `func stopTimer()`: Function to stop the workout timer.
- `func stringToInt(String) -> Int?`: Function to convert a string to an integer.
- `func validateAndStartCountdown(sets: String, reps: String, weights: String)`: Function to validate the user input and start the countdown.

### Enumerations

- `enum WorkoutStateEnum`: An enumeration representing the state of the workout.
  
</details>

## Class: allFeedbackViewModel

<details>

View model for the all feedback page.

**Note:** This view model is used to get the data for the all feedback page.

### Initializers

#### `init(coreDataManager: CoreDataManager)`

Initialize the view model.

### Instance Properties

- `WorkoutSets: [[String : Any]]`
- `coreDataManager: CoreDataManager`
- `date: Date`
- `workoutNum: Int64`
- `workoutSessions: [[String : Any]]`

### Instance Methods

- `func updateData(date: Date)`: Update the data for the page.

</details>

## Class: storeViewModel

<details>

ViewModel for the pet store and user transactions.

### Topics

#### Initializers
- `init()`

#### Instance Properties
- `var backgroundItemDBManager: BackgroundItemDBManager`
- `let categories: [String]`
- `var clothingItemDBManager: ClothingItemDBManager`
- `var foodItemDBManager: FoodItemDBManager`
- `var inventory: InventoryModel?`
- `var inventoryDBManager: InventoryDBManager`
- `var items: [SellingItem]` — Items available in store.
- `var petItemDBManager: PetItemDBManager`
- `var selectedCategory: String`
- `var showAlert: Bool`
- `var sortByPrice: Bool`
- `var userCur: Int`
- `var userDBManager: UserDBManager`

#### Instance Methods
- `func addFundtoUser(price: Int)`
- `func purchaseItem(item: SellingItem)` — Function to handle item purchase.
- `func sortItems(items: [SellingItem], sortByPrice: Bool) -> [SellingItem]` — Display items based on selected sorting method.
- `func subtractFunds(price: Int)` — Function to return amount of currency after item is bought.
- `func updateCurrency()`

### Default Implementations

#### ObservableObject Implementations

### Relationships

#### Conforms To
- `Combine.ObservableObject`
  
</details>

## Class: Challenge

<details>

Challenge class containing information regarding achievements.

### Topics

#### Initializers
- `init(title: String, description: String, image: Image, achievementIdentifier: String, currentProgress: Int, isCompleted: Bool)`

#### Instance Properties
- `var achievementIdentifier: String`
- `var currentProgress: Int`
- `var description: String`
- `var id: UUID`
- `var image: Image`
- `var isCompleted: Bool`
- `var title: String`

### Default Implementations

#### ObservableObject Implementations

### Relationships

#### Conforms To
- `Combine.ObservableObject`
- `Swift.Identifiable`

</details>

## Class: ChallengesViewModel

<details>

ViewModel for achievements.

### Topics

#### Initializers
- `init()`

#### Instance Properties
- `var challenges: [Challenge]`

### Default Implementations

#### ObservableObject Implementations

### Relationships

#### Conforms To
- `Combine.ObservableObject`

</details>

## Class: GameCenterManager

<details>

GameCenterManager class to integrate Game Center into the application.

### Topics

#### Classes
- `class GameCenterDelegate` — GameCenterDelegate class for loading Game Center UI into game.

#### Structures
- `struct GameCenterConstants`

#### Instance Properties
- `var isAuthenticated: Bool`

#### Instance Methods
- `func authenticateLocalPlayer()` — GameCenterManager class function to authenticate.
- `func checkAchievementCompletion(identifier: String)` — GameCenterManager class function to check if an achievement is completed.
- `func fetchAllAchievementsProgress(completion: ([String : Double]?, Error?) -> Void)` — GameCenterManager class function that fetches all achievements and their completion percentages.
- `func reportAchievement(challenge: Challenge)` — GameCenterManager class function to report achievement.
- `func showGameCenterAchievements()` — GameCenterManager class function to display Game Center.
- `func updateAchievement(identifier: String, progressToAdd: Double)` — GameCenterManager class function to update achievement progress.

#### Type Properties
- `static let shared: GameCenterManager`

### Default Implementations

#### ObservableObject Implementations

### Relationships

#### Inherits From
- `ObjectiveC.NSObject`

#### Conforms To
- `Combine.ObservableObject`
- `ObjectiveC.NSObjectProtocol`
- `Swift.CVarArg`
- `Swift.CustomDebugStringConvertible`
- `Swift.CustomStringConvertible`
- `Swift.Equatable`
- `Swift.Hashable`

</details>

## Class: GameCenterManager.GameCenterDelegate

<details>
  
GameCenterDelegate class for loading and exiting Game Center.

### Topics

#### Instance Methods
- `func gameCenterViewControllerDidFinish(GKGameCenterViewController)`

### Relationships

#### Inherits From
- `ObjectiveC.NSObject`

#### Conforms To
- `GameKit.GKGameCenterControllerDelegate`
- `ObjectiveC.NSObjectProtocol`
- `Swift.CVarArg`
- `Swift.CustomDebugStringConvertible`
- `Swift.CustomStringConvertible`
- `Swift.Equatable`
- `Swift.Hashable`
  
</details>

## Class: MorePageViewModel

<details>

ViewModel for the profile page.

### Topics

#### Initializers
- `init()`

#### Instance Properties
- `var achievements: [Achievement]`
- `var balance: Int`
- `var screenshot: UIImage?`
- `var showingScreenshotSavedAlert: Bool`
- `var showingShareSheet: Bool`
- `var userDBManager: UserDBManager`

#### Instance Methods
- `func addToBalance(amount: Int)`
- `func claimAchievement(id: UUID)`
- `func getBalance()`
- `func image(UIImage, didFinishSavingWithError: Error?, contextInfo: UnsafeMutableRawPointer)`
- `func takeScreenshot()`

### Default Implementations

#### ObservableObject Implementations

### Relationships

#### Inherits From
- `ObjectiveC.NSObject`

#### Conforms To
- `Combine.ObservableObject`
- `ObjectiveC.NSObjectProtocol`
- `Swift.CVarArg`
- `Swift.CustomDebugStringConvertible`
- `Swift.CustomStringConvertible`
- `Swift.Equatable`
- `Swift.Hashable`
- 
</details>

## Class: fitnessPlanViewModel

<details>
  
The fitnessPlanViewModel class contains variables for a user’s fitness goals.

### Topics

#### Initializers
- `init()`

#### Instance Properties
- `var daysPerWeekGoal: Int`
- `var fitnessPlan: FitnessPlanModel?`
- `var fitnessPlanDBManager: FitnessPlanDBManager`
- `var hasPlan: Bool`
- `var notes: String`
- `var repGoal: Int`
- `var selectedDate: Date`
- `var setGoal: Int`
- `var weightGoal: Int`

#### Instance Methods
- `func clearAllInputs()` — viewModel function to reset all variables.
- `func updateFitnessPlan(daysPerWeekGoal: Int, weightGoal: Int, setGoal: Int, repGoal: Int, notes: String, selectedDate: Date)` — viewModel function to update the fitness plan by saving the draft variables to the viewModel variables.

### Default Implementations

#### ObservableObject Implementations

### Relationships

#### Conforms To
- `Combine.ObservableObject`
  
</details>

## Class: PetPageFunction

<details>

A class that manages the functionality of the pet page.

### Topics

### Initializers
- `init()`:

#### Instance Properties
- `var alertMessage: String`
- `var alertTitle: String`
- `var currentLevel: Int`
- `foodItemDBManager: FoodItemDBManager`
- `foodItems: [FoodItemModel]`
- `healthBar: Int`
- `var inventroyDBManager: Inventory DBManager`
- `var pet: PetModel?`
- `var petDBManager: PetDBManager`
- `var selectedFoodIndex: Int`
- `var showAlert: Bool`
- `var showCustomize: Bool`
- `var showFoodSelection: Bool`
- `var showShop: Bool`
- `var userDBManager: UserDBManager`
- `var userTotalXP: Int`

#### Initializers
- `func AddXP(value: Int)`: Adds XP to the user's total XP.
- `func handleFoodUse(selectedFoodIndex: Int)`: Handles the use of food items.
- `func increaseHealth(by: Int)`: Increase the health of the pet by a specified amount.
- `showAlert(title: String, message: String)`: Shows an alert with the specified title and message.
- `func updateXP()`: Updates the total XP of the user
  
</details>

## Class: CustomizeViewModel

<details>

### Topics

### Initializers
- `init()`:

#### Instance Properties
- `let accessories: [Accessory]`
- `var backgroundColor: Color`
- `let backgroundImages: [BackgroundImage]`
- `var equippedAccessory: Accessory?`
- `var equippedBackgroundImage: BackgroundImage?`
- `var equippedPet: Pet_selection?`
- `let pets: [Pet_selection]`
</details>












# Structures

## Structure: AttachSensors

<details>
Instructions on how to attach the sensors on the dumbbell and the elbow sleeve.

### Initializers

#### `init()`

### Instance Properties

- `var body: some View`

</details>

## Structure: OverallWorkoutData

<details>

OverallWorkoutData is a view that displays the overall feedback for the workout.

**Note:** This view displays the overall data for the workout.

### Initializers

#### `init(workoutAnalysisForSets: Binding<[[String : Double]]>, viewModel: WorkoutViewModel, totalSets: Int)`

### Instance Properties

- `var body: some View`: Represents the SwiftUI view of the structure.
- `var totalSets: Int`: Represents the total number of sets in the workout.
- `var viewModel: WorkoutViewModel`: Represents the view model associated with the workout.
- `var workoutAnalysisForSets: [[String : Double]]`: Represents the analysis data for each set of the workout.


</details>

## Structure: PostWorkoutData

<details>

PostWorkoutData is a view that displays the feedback for each set in the workout.

**Note:** This view displays both the data for the set and the overall data for the workout.

### Initializers

#### `init(viewModel: WorkoutViewModel, setIndex: Int, feedback: (String, String, String, String), workoutAnalysis: [String : Double])`

Initializes the PostWorkoutData view.

### Instance Properties

- `var body: some View`
- `let feedback: (String, String, String, String)`: Represents the feedback data for the set.
- `let setIndex: Int`: Represents the index of the set.
- `var viewModel: WorkoutViewModel`: Represents the view model associated with the workout.
- `let workoutAnalysis: [String : Double]`: Represents the overall workout analysis data.
- 
</details>

## Structure: RechargeSensors

<details>

Instructions on how to recharge the sensors.

### Initializers

#### `init()`

Initializes the RechargeSensors view.

### Instance Properties

- `var body: some View`

</details>


## Structure: WorkoutFeedback

<details>

View to show all data collected from the most recent workout.

**Note:** This view displays the feedback for each set in the workout and the overall data for the workout.

### Initializers

#### `init(viewModel: WorkoutViewModel, feedbackDataForSets: Binding<[(String, String, String, String)]>, workoutAnalysisForSets: Binding<[[String : Double]]>, totalSets: Binding<Int>)`

This initializer initializes the `WorkoutFeedback` view with the provided view model and feedback data for sets.

### Instance Properties

- `var body: some View`: Represents the SwiftUI view of the structure.
- `var feedbackDataForSets: [(String, String, String, String)]`: Represents the feedback data for each set in the workout.
- `var totalSets: Int`: Represents the total number of sets in the workout.
- `var viewModel: WorkoutViewModel`: Represents the view model associated with the workout.
- `var workoutAnalysisForSets: [[String : Double]]`: Represents the analysis data for each set of the workout.

</details>

## Structure: allFeedback

<details>

View for the all feedback page.

**Note:** This view is used to display all the feedback for the user.

### Initializers

#### `init(coreDataManager: CoreDataManager)`

Initializes the allFeedback view with the provided `CoreDataManager`.

### Instance Properties

- `var body: some View`: Represents the SwiftUI view of the structure.
- `var coreDataManager: CoreDataManager`: Represents the CoreDataManager associated with the view.
- `var viewModel: allFeedbackViewModel`: Represents the view model associated with the view.

</details>

## Structure: WorkoutMainPage

<details>

Main structure to display the workout page with integrated UI components.

### Overview

This structure is responsible for displaying the workout page, including the workout tab selection, workout details input form, and the workout feedback view.

### Topics

### Structures

- `struct CountdownView`
- `struct LineGraph`
- `struct WorkoutDetailsInputView`: Define a new view for the workout details input form

### Initializers

 `init(coreDataManager: CoreDataManager)`

Initialize the workout page with the BLE central manager and form criteria.

### Instance Properties

- `var backgroundItemDBManager: BackgroundItemDBManager`
- `var ble: BLEcentral`
- `var body: some View`
- `var clothingItemDBManager: ClothingItemDBManager`
- `var coreDataManager: CoreDataManager`
- `var formCriteria: FormCriteria`
- `var petItemDBManager: PetItemDBManager`
- `var storeModel: storeViewModel`
- `var viewModel: WorkoutViewModel`
- `var workoutPageViewModel: WorkoutPageViewModel`

### Enumerations

- `enum SetType`

</details>

## Structure: PetStore

<details>
Display view for the Pet Store depending on available items and prices.

### Topics

### Initializers
- `init()`
- `init(viewModel: storeViewModel)`

### Instance Properties
- `var body: some View`
- `var viewModel: storeViewModel`

### Default Implementations

#### View Implementations

### Relationships

#### Conforms To
SwiftUI.View
</details>

## Structure: ItemDetailView

<details>
ItemDetailView struct for previewing and purchasing an item.

### Topics

#### Initializers
- `init(item: SellingItem, viewModel: storeViewModel, userCur: Int)`

#### Instance Properties
- `var body: some View`
- `var item: SellingItem`
- `let userCur: Int`
- `var viewModel: storeViewModel`

### Default Implementations

#### View Implementations

### Relationships

#### Conforms To
- `SwiftUI.View`
</details>

## Structure: SellingItem
<details>
  
SellingItem struct that contains essential item attributes.

### Topics

#### Initializers
- `init(id: Int, name: String, category: String, price: String, image: Image, description: String, isBought: Bool)`

#### Instance Properties
- `var category: String`
- `var description: String`
- `var id: Int`
- `var image: Image`
- `var isBought: Bool`
- `var name: String`
- `var price: String`

### Relationships

#### Conforms To
- `Swift.Identifiable`
- `Swift.Sendable`
</details>


## Structure: ChallengesList
<details>

Struct containing all achievements in the application.

### Topics

#### Initializers
- `init(challenges: [Challenge], fetchGameCenterProgress: () -> Void)`

#### Instance Properties
- `var body: some View`
- `var challenges: [Challenge]`
- `var fetchGameCenterProgress: () -> Void`

#### Instance Methods
- `func refreshList()`

### Default Implementations

#### View Implementations

### Relationships

#### Conforms To
SwiftUI.View
</details>

## Structure: ChallengesTab
<details>

Struct containing the sorting and fetching of Game Center achievements.
### Topics

#### Initializers
- `init()`
- `init(challenges: [Challenge])`

#### Instance Properties
- `var body: some View`
- `var challenges: [Challenge]`

#### Instance Methods
- `func fetchGameCenterProgress()`

### Default Implementations

#### View Implementations

### Relationships

#### Conforms To
SwiftUI.View
</details>

## Structure: Achievement

<details>

Struct containing claiming functionality for achievements.

### Topics

#### Initializers
- `init(id: UUID, title: String, description: String, img: String, reward: Int, isClaimed: Bool)`

#### Instance Properties
- `var description: String`
- `var id: UUID`
- `var img: String`
- `var isClaimed: Bool`
- `var reward: Int`
- `var title: String`

#### Instance Methods
- `func claim()`

### Relationships

#### Conforms To
- `Swift.Identifiable`
- `Swift.Sendable`
</details>

## Structure: UserAchievement

<details>

UserAchievement struct for database information of achievements.

### Topics

#### Initializers
- `init(recordId: CKRecord.ID?, achievement: CKRecord.Reference, currentProgress: Int64, isCompleted: Int64)`

#### Instance Properties
- `var achievement: CKRecord.Reference`
- `var currentProgress: Int64`
- `var isCompleted: Int64`
- `var record: CKRecord` — Returns the CloudKit record representation of the user achievement.
- `var recordId: CKRecord.ID?`

### Relationships

#### Conforms To
- `Swift.Sendable`
</details>

## Structure: SettingsPageView

<details>

SettingsPageView struct for displaying user settings.

### Topics

#### Initializers
- `init()`
- `init(workoutNotificationsEnabled: Bool, notificationFrequency: String, email: String, firstName: String, lastName: String, userID: String, viewModel: fitnessPlanViewModel)`

#### Instance Properties
- `var body: some View`
- `let chestWidthsArray: [Int]`
- `let daysPerWeek: [Int]`
- `var email: String`
- `var firstName: String`
- `let forearmLengthsArray: [Int]`
- `var formattedDate: String` — struct function to print date with only month/date/year and prevent the time and time zone from displaying.
- `let frequencyOptions: [String]`
- `let heightFeetArray: [Int]`
- `let heightInchesArray: [Int]`
- `var lastName: String`
- `var notificationFrequency: String`
- `let reps: [Int]`
- `let sets: [Int]`
- `let upperArmLengthsArray: [Int]`
- `var userID: String`
- `var viewModel: fitnessPlanViewModel`
- `let weeks: [Int]`
- `let weight: [Int]`
- `let weightsArray: [Int]`
- `var workoutNotificationsEnabled: Bool`

### Default Implementations

#### View Implementations

### Relationships

#### Conforms To
- `SwiftUI.View`
</details>

## Structure: NotificationManager

<details>

NotificationManager struct to handle user notifications.

### Topics

#### Initializers
- `init()`

#### Type Properties
- `static var notificationFrequency: String`

#### Type Methods
- `static func cancelNotification()`
- `static func createNotificationContent() -> UNMutableNotificationContent`
- `static func requestAuthorization()`
- `static func scheduleWorkoutReminder()`
- `static func sendTestNotification()`
- `static func updateLastWorkoutTime()`

### Relationships

#### Conforms To
- `Swift.Sendable`
</details>

## Structure: ShareSheetView

<details>

ShareSheetView struct for displaying Apple UI in sharing feature.

### Topics

#### Initializers
- `init(items: [Any])`

#### Instance Properties
- `var items: [Any]`

#### Instance Methods
- `func makeUIViewController(context: Context) -> UIActivityViewController`
- `func updateUIViewController(UIActivityViewController, context: Context)`

### Default Implementations

#### UIViewControllerRepresentable Implementations

#### View Implementations

### Relationships

#### Conforms To
- `Swift.Sendable`
- `SwiftUI.UIViewControllerRepresentable`
- `SwiftUI.View`
</details>

## Structure: FitnessPlanPage

<details>
  
FitnessPlanPage struct that structures the view for a fitness planning page.

### Topics

#### Initializers
- `init()`
- `init(viewModel: fitnessPlanViewModel)`

#### Instance Properties
- `var body: some View`
- `let characterLimit: Int`
- `let daysPerWeek: [Int]`
- `let reps: [Int]`
- `let sets: [Int]`
- `var viewModel: fitnessPlanViewModel`
- `let weight: [Int]`

#### Instance Methods
- `func clearTemp()` — FitnessPlanPage struct function to reset temporary variables.

### Default Implementations

#### View Implementations

### Relationships

#### Conforms To
- `SwiftUI.View`
</details>

## Structure: FitnessPlanModel

<details>

FitnessPlanModel struct for database related information.

### Topics

#### Initializers
- `init(recordId: CKRecord.ID?, daysPerWeekGoal: Int64, dumbbellWeightGoal: Int64, setGoal: Int64, repGoal: Int64, notes: String, selectedDate: Date)`

#### Instance Properties
- `var daysPerWeekGoal: Int64`
- `var dumbbellWeightGoal: Int64`
- `var notes: String`
- `var record: CKRecord`
- `var recordId: CKRecord.ID?`
- `var repGoal: Int64`
- `var selectedDate: Date`
- `var setGoal: Int64`

### Relationships

#### Conforms To
- `Swift.Sendable`
</details>

## Structure: FoodItem

<details>
A stuct representing a food item.

### Topics

#### Initializers
- `init(id: UUID, name: String, quantity: Int, imageName: String)`

#### Instance Properties
- `var id: UUID`
- `var imageName: String`
- `var name: Sting`
- `var quantity: Int`
</details>

## Structure: Accessory

<details>

### Topics

#### Initializers
- `init(id: UUID, name: String, imageName: String)`

#### Instance Properties
- `var id: UUID`
- `var imageName: String`
- `var name: String`

</details>

## Structure: BackgroundImage

<details>

### Topics

#### Initializers
- `init(id: UUID, name: String. imageName: String)`

#### Instance Properties
- `var id: UUID`
- `var imageName: String`
- `var name: String`

</details>

## Structure: Pet_selection

<details>

### Topics

#### Initializers
- `init(id: UUID, name: String, imageName: String)`

#### Instance Properties
- `var id: UUID`
- `var imageName: String`
- `var name: String`

</details>

## Structure: Customize_page
<details>
The view for customizing the pet's appearance.

### Topics

#### Initializers
- `init()`

#### Instance Properties
- `var body: some View`
- `var onBack: (() -> Void)?`
- `var presentationMode: Binding<PresentationMode>`
- `var viewModel: CustomizeViewModel`

</details>

# Stucture: CustomProgressView
<details>
A custom progress view that displays the progress value and label.

### Topics

#### Initializers
- `init(value: Int, maxValue: Int, label: String, displayMode: CustomProgressView.DisplayMode, foregroundColor: Color, backgroundColor: Color)`

#### Instance Properties
- `var backgroundColor: Color`
- `var body: some View`
- `var displayMode: DisplayMode`
- `var foregroundColor: Color`
- `var label: String`
- `var maxValue: Int`
- `var value: Int`

#### Enumerations
- `enum DisplayMode`: The display mode for the progress value and health bar.

</details>

## Structure: FoodSelectionView

<details>
A view representing the food selection view.

### Topics

#### Initializers
- `init(presentationMode: Environment<Binding<PresentationMode>>, foodItems: Binding<[FoodItemModel]>, selectedFoodIndex: Binding<Int>)`

#### Instance Properties
- `var body: some View`
- `var foodItems: [FoodItemModel]`
- `var presentationMode: Binding<PresentationMode>`
- `var selectionFoodIndex: Int`

</details>

## Structure: HamburgerMenu

<details>
A view representing a hamburger menu with options to navigate to different pages.

### Topics

#### Initializers
- `init(navigateToShop: () -> Void, navigateToCustomize: () -> Void)`

#### Instance Properties
- `var body: some View`
- `var navigateToCustomize: () -> Void`
- `var navigateToShop: () -> Void`

</details>

## Structure: Pet_Page

<details>
A view representing the pet page.

### Topics

#### Initializers
- `init()`
- `init(viewModel: PetPageFunction)`

#### Instance Properties
- `var body: some View`
- `var viewModel: PetPageFunction`

</details>


## Structure: LoginView
<details>
The view for the login screen of the SmartWeights app

### Topics

#### Initializers
- `int()`
- `int(coreDataManager: CoreDataManager, colorScheme: Enviroment<ColorScheme>, email: String, firstName: String, lastName: String, userID: String, userDBManager: UserDBManager, petDBManager: PetDBManager, foodItemDBManager: FoodItemDBManager, petItemDBManager: PetItemDBManager)`

#### Instance Properties
- `var body: some View`
- `var colorScheme: ColorScheme`
- `var coreDataManager: CoreDataManager`
- `var email: String`
- `var firstName: String`
- `var foodItemDBManager: FoodItemDBManager`
- `var lastName: String`
- `var petDBManager: PetDBManager`
- `var petItemDBManager: PetItemDBManager`
- `var userDBManager: UserDBManager`
- `var userID: String`
</details>


## Structure: CarouselButton
<details>
Contains parameters for the additional page carousel buttons, which are used in the NavigationCarousel struct.

### Initializers
- `init(name: String, icon: String, link: AnyView)`

### Instance Properties
- `let icon: String`
- `var id: String`
- `let link: AnyView`
- `let name: String`
</details>


## Structure: Homepage
<details>
The homepage of the SmartWeights app.

### Initializers
- `init(tabBar: TabBar, coreDataManager: CoreDataManager)`

### Instance Properties
- `var body: some View`
- `var coreDataManager: CoreDataManager`
- `var showTutorial: Bool`
- `let tabBar: TabBar`
</details>


## Structure: NavigationCarousel
<details>
Creates the additional button carousel.

### Initializers
- `init(coreDataManager: CoreDataManager, buttons: [CarouselButton], iconColor: Color, bgColor: Color, textColor: Color)`

### Instance Properties
- `let bgColor: Color`
- `var body: some View`
- `let buttons: [CarouselButton]`
- `var coreDataManager: CoreDataManager`
- `let iconColor: Color`
- `let textColor: Color`
</details>


## Structure: StartWorkoutButton
<details>
The start workout button, located on the home page.

### Initializers
- `init(tabBar: TabBar)`

### Instance Properties
- `var body: some View`
- `var tabBar: TabBar`
</details>


## Structure: TabBar
<details>
Struct TabBar implements the Tab enumeration and TabView to create a navigable tab bar.

### Initializers
- `init(coreDataManager: CoreDataManager)`

### Instance Properties
- `var body: some View`
- `var coreDataManager: CoreDataManager`

### Instance Methods
- `func changeTab(to: Tab)`
</details>


## Structure: TutorialPopup
<details>
Tutorial pop up for new users.

### Initializers
- `init(show: Binding<Bool>, showTutorial: Bool)`

### Instance Properties
- `var body: some View`
- `var show: Bool`
- `var showTutorial: Bool`
</details>


## Structure: VideoCard
<details>
Video card used in the VideoCarousel struct.

### Initializers
- `init(videoId: String, title: String, description: String)`

### Instance Properties
- `var body: some View`
- `var description: String`
- `var id: String`
- `var title: String`
- `var videoId: String`
</details>


## Structure: VideoCarousel
<details>
Carousel of VideoCard objects

### Initializers
- `init(videoCards: [VideoCard])`

### Instance Properties
- `var body: some View`
- `var videoCards: [VideoCard]`
</details>


## Structure: VideoView
<details>
Embedded YouTube videos via WebKit library and UIViewRepresentable protocol.

### Initializers
- `init(videoId: String)`

### Instance Properties
- `let videoId: String`

### Instance Methods
- `func makeUIView(context: Context) -> WKWebView`
- `func updateUIView(WKWebView, context: Context)`
</details>
