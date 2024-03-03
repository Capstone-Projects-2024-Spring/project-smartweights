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




