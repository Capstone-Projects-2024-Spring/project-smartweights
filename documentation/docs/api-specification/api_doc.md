# Classes

## Class: FormCriteria

<details open>

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

<details open>

View model to handle the workout data.

### Initializers

#### `init(ble: BLEcentral, formCriteria: FormCriteria, coreDataManager: CoreDataManager)`

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

<details open>

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

<details open>

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

## Class: GameCenterManager

<details open>

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
<details open>
  
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

# Hardware Software

## Class: MPU6050
Class for reading gyro rates and acceleration data from an MPU-6050 module via I2C.

<details open>



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


<details open>



- `advertising_payload(limited_disc=False, br_edr=False, name=None, services=None, appearance=0)`: Generate a payload for advertising.
- `decode_field(payload, adv_type)`: Decode a field from an advertising payload.
- `decode_name(payload)`: Decode the local name from an advertising payload.
- `decode_services(payload)`: Decode a list of UUIDs from an advertising payload.
- `demo()`: Run a demonstration.
  
</details>

## Class: MPU Data

<details open>

Class to get accelerometer and gyroscope data.

- `__init__(id: str)`: The ID of the MPU6050 sensor.
- `get_accel_data() → tuple`: Get the accelerometer data.
- `get_gyro_data() → tuple`: Get the gyroscope data.

</details>

## Class: BLEcentral

BLEcentral is a class that manages a central role in a Bluetooth Low Energy (BLE) connection. It conforms to `NSObject`, `CBCentralManagerDelegate`, `CBPeripheralDelegate`, and `ObservableObject`.


<details open>



### Overview

This class is responsible for scanning for, connecting to, and disconnecting from peripherals.

**Note:** This class specifically looks for peripherals named “MPU6050-1” and “MPU6050-2”.

### Initializers

### `init()`
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









# Structures

# Structure: AttachSensors

<details open>
Instructions on how to attach the sensors on the dumbbell and the elbow sleeve.

## Initializers

### `init()`

## Instance Properties

- `var body: some View`

</details>

# Structure: OverallWorkoutData

<details open>

OverallWorkoutData is a view that displays the overall feedback for the workout.

**Note:** This view displays the overall data for the workout.

## Initializers

#### `init(workoutAnalysisForSets: Binding<[[String : Double]]>, viewModel: WorkoutViewModel, totalSets: Int)`

## Instance Properties

- `var body: some View`: Represents the SwiftUI view of the structure.
- `var totalSets: Int`: Represents the total number of sets in the workout.
- `var viewModel: WorkoutViewModel`: Represents the view model associated with the workout.
- `var workoutAnalysisForSets: [[String : Double]]`: Represents the analysis data for each set of the workout.


</details>

# Structure: PostWorkoutData

<details open>

PostWorkoutData is a view that displays the feedback for each set in the workout.

**Note:** This view displays both the data for the set and the overall data for the workout.

## Initializers

### `init(viewModel: WorkoutViewModel, setIndex: Int, feedback: (String, String, String, String), workoutAnalysis: [String : Double])`

Initializes the PostWorkoutData view.

## Instance Properties

- `var body: some View`
- `let feedback: (String, String, String, String)`: Represents the feedback data for the set.
- `let setIndex: Int`: Represents the index of the set.
- `var viewModel: WorkoutViewModel`: Represents the view model associated with the workout.
- `let workoutAnalysis: [String : Double]`: Represents the overall workout analysis data.
- 
</details>

# Structure: RechargeSensors

<details open>

Instructions on how to recharge the sensors.

## Initializers

### `init()`

Initializes the RechargeSensors view.

## Instance Properties

- `var body: some View`


# Structure: WorkoutFeedback

<details open>

View to show all data collected from the most recent workout.

**Note:** This view displays the feedback for each set in the workout and the overall data for the workout.

## Initializers

### `init(viewModel: WorkoutViewModel, feedbackDataForSets: Binding<[(String, String, String, String)]>, workoutAnalysisForSets: Binding<[[String : Double]]>, totalSets: Binding<Int>)`

This initializer initializes the `WorkoutFeedback` view with the provided view model and feedback data for sets.

## Instance Properties

- `var body: some View`: Represents the SwiftUI view of the structure.
- `var feedbackDataForSets: [(String, String, String, String)]`: Represents the feedback data for each set in the workout.
- `var totalSets: Int`: Represents the total number of sets in the workout.
- `var viewModel: WorkoutViewModel`: Represents the view model associated with the workout.
- `var workoutAnalysisForSets: [[String : Double]]`: Represents the analysis data for each set of the workout.

</details>

# Structure: allFeedback

<details open>

View for the all feedback page.

**Note:** This view is used to display all the feedback for the user.

## Initializers

### `init(coreDataManager: CoreDataManager)`

Initializes the allFeedback view with the provided `CoreDataManager`.

## Instance Properties

- `var body: some View`: Represents the SwiftUI view of the structure.
- `var coreDataManager: CoreDataManager`: Represents the CoreDataManager associated with the view.
- `var viewModel: allFeedbackViewModel`: Represents the view model associated with the view.

</details>

# Structure: WorkoutMainPage

<details open>

Main structure to display the workout page with integrated UI components.

## Overview

This structure is responsible for displaying the workout page, including the workout tab selection, workout details input form, and the workout feedback view.

## Topics

### Structures

- `struct CountdownView`
- `struct LineGraph`
- `struct WorkoutDetailsInputView`: Define a new view for the workout details input form

### Initializers

### `init(coreDataManager: CoreDataManager)`

Initialize the workout page with the BLE central manager and form criteria.

## Instance Properties

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

## Enumerations

- `enum SetType`

</details>

# Structure: PetStore

<details open>
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

# Structure: SellingItem
<details open>
  
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


# Structure: ChallengesList
<details open>

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

# Structure: ChallengesTab
<details open>

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







