---
sidebar_position: 1
---
# Unit tests
Unit tests are done with Swift's XCTest
Pico testing is done with MicroPython test library
Python unittest library is used for machine learning


## Front End

### Pet Page
<details open>
<summary> HandleFoodUse() </summary>

***Health increases after eating food***
- Test user is feeding their pets food
    - Input/User action
        - User clicks on food button to feed pet
    - Expected Result
        - handleFoodUse(selectedFoodIndex: Int) is called, health bar should increase


***Food quantity decreases after eating food***
- Test user is feeding their pets food
    - Input/User action
        - User clicks on food button to feed pet
    - Expected Result
        - handleFoodUse(selectedFoodIndex: Int) is called, food quantity should decrease

***Health should not exceed after eating food***
- Test user is feeding their pet with the pet's health bar full
    - Input/User action
        - User clicks on food button to feed pet
    - Expected Result
        - handleFoodUse(selectedFoodIndex: Int) is called, health bar bar should not exceed full

***Alert users of insufficient amount of food***
- Test user is feeding their pets with insufficient amount of food
    - Input/User action
        - User clicks on food button to feed pet
    - Expected Result
        - handleFoodUse(selectedFoodIndex: Int) is called, an alert pops up telling the user they have no more food

***Alert users that health is at max***
- Test user is feeding their pets the health already full
    - Input/User action
        - User clicks on food button to feed pet
    - Expected Result
        - handleFoodUse(selectedFoodIndex: Int) is called, an alert pops up telling the user that the health bar is already full
    
</details>

### Workout Main Page
<details open>
<summary> addProgress() </summary>

***Workout progress is updated after starting workout***
- Test user is starting their workout
    - Input/User action
        - User starts the workout
    - Expected Result
        - addProgress(data: Int) is called, the form and velocity progress bar changes
</details>

<details open>
<summary> resetProgress() </summary>

***Workout progress is reset after starting new workout***
- Test user is starting a new workout
    - Input/User action
        - User clicks the 'new workout' button
    - Expected Result
        - resetProgress() is called, the form and velocity progress bar is reset to zero
</details>

<details open>
<summary> startTimer() </summary>

***Workout timer is counting after starting the workout***
- Test user is starting the workout
    - Input/User action
        - User starts the working 
    - Expected Result
        - startTimer() is called, the workout timer starts counting
</details>

<details open>
<summary> resetTimer() </summary>

***Workout timer is reset after starting new workout***
- Test user is starting a new workout
    - Input/User action
        - User clicks the 'new workout' button
    - Expected Result
        - resetTimer() is called, the workout timer is reset to 00:00:00
</details>

### Workout Overall Progress Page

<details open>
<summary> updateShortDate() </summary>

***The date is updated when the user uses the calendar***
- Test user is selecting a date to obtain workout data from that day
    - Input/User action
        - User selects a date on the calendar
    - Expected Result
        - updateShortDate() is called, the date is updated and matches the format M/D/Y
</details>


### Pet Store Page

<details open>
<summary> sortItems() </summary>

***The shop is sorted by name A-Z***
- Test user clicks sort by name to get the items in alphabetical order
    - Input/User action
        - User clicks sort by name
    - Expected Result
        - sortItems(sortByPrice: false) is called, the items will be sorted in alphabetical order 

***The shop is sorted by price lowest-highest***
- Test user clicks sort by price to get the items from lowest to highest cost
    - Input/User action
        - User clicks sort by price
    - Expected Result
        - sortItems(sortedByPrice: true) is called, the items will be sorted by price
</details>



## Backend

### CloudKit DB 
<details>

- testConnectToCloudKit()
    - Test to see if the application can connect to CloudKit DB and find the correct container
    - Expected Result
        - Returns true if successful connection, else return false

- testFetchRecord()
    - Test to see if given input parameters can query the CloudKit DB and return a record
    - Expected Result
        - Returns true if record is not nil, else return false
- testFetchRecordAndCheckCurrency()
    - Test to see if given user record has a specified field value
    - Expected Result
        - Returns values of the record for the parameters match, else return false for no record returned or incorrect record
- testGetReference()
    - Test to see if given a reference value can query the CloudKit DB and return a referenced record  
    - Expected Result
        - Returns values of the record for the parameters, else return false for no record returned or incorrect record
- testAccountCreatedCloud()
    - Test to see if account credentials were stored after login button pressed
    - Expected Result 
        - Returns true if record return with correct ID, else return false
- testUpdateCurrency()
    - Test to see if after button press, updates the user's total currency after transaction and updates the DB
    - Expected Result
        - Returns the same currency as currently stored on local model from the DB, else return false if different value or no value returned
- testUploadImage()
    - Test to see if a CKAsset was successfully uploaded to CloudKit DB 
    - Expected Result 
        - Returns a successful entry, else false
- testFetchImage()
    - Test to see if can fetch a CKAsset from CloudKit DB
    - Expected Result
        - Returns a binary CKAsset, else false
</details>

### CoreData Local DB
<details>

- testAccountCreatedLocal()
    - Test to see if account credentials were created after login button pressed
    - Expected Result 
        - Returns true if file was created with credentials, else return false
- testInsertSensorData()
    - Test to see if data received from Pico can be inserted into CoreData DB
    - Expected Result 
        - Returns true if DB returns successful entry, else return false
- testFetchData()
    - Test to see if can retrieve data from DB
    - Expected Result
        - Returns true if DB returns an object of data, else return false

</details>

### Machine Learning

<details>

- testConvert()
    - Test to see if can take data from CoreData and convert to tensors
    - Returns true if tensor is created

</details>

### Hardware-Software 

<details>

- testBluetoothConnectionPico()
    - Test if Pico establishes a successful connection to mobile device acting as a server
    - Expected Result
        - Return true if connection before time out, else return false
- testBluetoothConnectionMobile()
    - Test if mobile device connects to pico, acting as a client
    - Expected Result
        - Return true if connection before time out, else return false
- testMultiSensorConnection()
    - Test if Pico can connect to another Pico
    - Expected Result 
        - Return true if successful message received, else return false
- testTransmitData()
    - Test if Pico can transmit data through the socket
    - Expected Result
        - Return true if data was sent through socket, else return false
- testReadData()
    - Test if mobile device received any data from the pico 
    - Expected Result
        - Return true if data contained specifically integers in specified structure, else return false
</details>






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

## Class: BLEcentral

<details open>

BLEcentral is a class that manages a central role in a Bluetooth Low Energy (BLE) connection. It conforms to `NSObject`, `CBCentralManagerDelegate`, `CBPeripheralDelegate`, and `ObservableObject`.


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

## Python

### Class: MPU6050
<details open>

Class for reading gyro rates and acceleration data from an MPU-6050 module via I2C.

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

### Class: main

<details open>

Class that is responsible for advertising data via bluetooth


- `advertising_payload(limited_disc=False, br_edr=False, name=None, services=None, appearance=0)`: Generate a payload for advertising.
- `decode_field(payload, adv_type)`: Decode a field from an advertising payload.
- `decode_name(payload)`: Decode the local name from an advertising payload.
- `decode_services(payload)`: Decode a list of UUIDs from an advertising payload.
- `demo()`: Run a demonstration.
  
</details>

### Class: MPU Data

<details open>

Class to get accelerometer and gyroscope data.

- `__init__(id: str)`: The ID of the MPU6050 sensor.
- `get_accel_data() → tuple`: Get the accelerometer data.
- `get_gyro_data() → tuple`: Get the gyroscope data.

</details>