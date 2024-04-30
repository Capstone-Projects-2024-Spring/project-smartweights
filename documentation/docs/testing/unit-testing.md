---
sidebar_position: 1
---
# Unit tests
Swift unit tests are done with Swift's XCTest

Pico-W testing is done with pytest library

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

### WorkoutViewModel

<details open>
<summary> testIsInputZeroOrInvalid()</summary>

***Validates whether input values are zero or invalid***
- User inputs values for sets, reps, weights, and countdown
    - Input/User action
        - User enters input values
    - Expected Result
        - The function correctly identifies whether the input values are zero or invalid.
</details>

<details open>
<summary> testIsValidInput()</summary>

***Validates the validity of input values***
- User inputs values for sets, reps, weights, and countdown
    - Input/User action
        - User enters input values
    - Expected Result
        - The function correctly identifies whether the input values are valid.
</details>

<details open>
<summary> testStringToInt()</summary>

***Validates the conversion of string to integer***
- User inputs a string value
    - Input/User action
        - User enters a string value
    - Expected Result
        - The function correctly converts the string to an integer if possible; otherwise, returns nil.
</details>

<details open>
<summary> testResetWorkoutState()</summary>

***Validates the reset of workout state***
- User resets the workout state
    - Input/User action
        - User initiates a new workout
    - Expected Result
        - The workout state variables are reset to their initial values.
</details>

<details open>
<summary> testStartWorkout()</summary>

***Validates the start of workout***
- User starts a workout session
    - Input/User action
        - User initiates the start of a workout session
    - Expected Result
        - The workout state is updated to indicate that the workout has started.
</details>

<details open>
<summary> testNextSet()</summary>

***Validates the transition to the next set***
- User progresses to the next set during a workout session
    - Input/User action
        - User initiates the transition to the next set
    - Expected Result
        - The workout state and relevant variables are updated accordingly for the next set.
</details>

<details open>
<summary> testResetTimer()</summary>

***Validates the reset of timer***
- User resets the timer during a workout session
    - Input/User action
        - User initiates a new workout
    - Expected Result
        - The timer variables are reset, and the timer is deactivated.
</details>




### Workout Overall Progress Page



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


### FormCriteria

<details open>
<summary> getRandomGoodFormPhrase()</summary>

***The user gets one of three phrases when having good form***
- User finishes a workout and wants their feedback
    - Input/User action
        - User clicks 'finish set' or 'finish workout'
    - Expected Result
      - getRandomGoodFormPhrase() is called and the user sees one of the three phrases
  
</details>


<details open>
<summary> updateWorkoutAnalysis()</summary>

***updates the workout analysis data with provided current data***
- User completes a workout session and wants to see the results
    - Input/User action
        - User finishes a workout session
    - Expected Result
        - The workout analysis is updated with the provided data and contains the expected keys.
</details>

<details open>

<summary> averageUpDownAcceleration()</summary>

***Calculate of average up-down acceleration***
- User wants to ensure accurate calculation of up-down acceleration average
    - Input/User action
        - User performs several sets of exercises
    - Expected Result
        - The calculated average up-down acceleration falls within the range of 0 to 1.

</details>

<details open>

<summary> averageWristLeftRightRotation()</summary>

***Calculates average wrist left-right rotation***
- User wants to ensure accurate calculation of left-right wrist rotation average
    - Input/User action
        - User performs several sets of exercises
    - Expected Result
        - The calculated average wrist left-right rotation falls within the range of 0 to 1.

</details>

<details open>

<summary> overallWorkoutUpDownAverage()</summary>

***calculates overall workout up-down average***
- User wants to ensure accurate calculation of overall workout up-down average
    - Input/User action
        - User completes a workout session
    - Expected Result
        - The calculated overall workout up-down average falls within the range of 0 to 1 and is approximately equal to the expected value.


</details>

<details open>

<summary> averageElbowSwing()</summary>

***calculates average elbow swing***
- User wants to ensure accurate calculation of elbow swing average
    - Input/User action
        - User performs several sets of exercises
    - Expected Result
        - The calculated average elbow swing falls within the range of 0 to 1.

</details>

<details open>

<summary> averageElbowFlareForwardBackward()</summary>

***calculates average elbow flare forward-backward***
- User wants to ensure accurate calculation of elbow flare forward-backward average
    - Input/User action
        - User performs several sets of exercises
    - Expected Result
        - The calculated average elbow flare forward-backward falls within the range of 0 to 1.

</details>

<details open>

<summary> overallWorkoutElbowSwing()</summary>

***calculates overall workout elbow swing***
- User wants to ensure accurate calculation of overall workout elbow swing
    - Input/User action
        - User completes a workout session
    - Expected Result
        - The calculated overall workout elbow swing falls within the range of 0 to 1 and is approximately equal to the expected value.


</details>

<details open>

<summary> dangerousForm()</summary>

***Detects of dangerous form***
- User wants to ensure accurate detection of dangerous form based on provided data
    - Input/User action
        - User performs exercises with varying data
    - Expected Result
        - The function correctly identifies whether the provided data indicates dangerous form.

</details>

<details open>

<summary> giveFeedback()</summary>

***generation of feedback***
- User wants to ensure accurate generation of feedback based on provided data
    - Input/User action
        - User completes an exercise session
    - Expected Result
        - The feedback generated for acceleration and elbow swing is formatted correctly, and the custom text feedback for elbow is correct.


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
<details open>
<summary> setUpWithError() </summary>

***Sets up an in-memory Core Data environment for each test***
- Ensures tests do not affect real user data by creating a mock environment
    - Input/Setup action
        - Core Data stack setup with in-memory store type
    - Expected Result
        - CoreDataManager instance is initialized without errors

</details>

<details open>
<summary> tearDownWithError() </summary>

***Cleans up and deallocates the in-memory Core Data stack after each test***
- Ensures all data and instances are cleaned up properly
    - Input/Cleanup action
        - Removing persistent stores from the coordinator
    - Expected Result
        - Persistent stores are removed without errors, and CoreDataManager is deallocated

</details>

<details open>
<summary> testCreateWorkoutSession() </summary>

***Tests the ability to create a WorkoutSession entity***
- Validating entity creation within the Core Data environment
    - Input/User action
        - Create a WorkoutSession with specified attributes
    - Expected Result
        - WorkoutSession entity is not nil and correctly initialized with provided values

</details>

<details open>
<summary> testCreateAndFetchWorkoutSessions() </summary>

***Tests integration of creating and fetching WorkoutSession entities***
- Ensures data consistency within the created and fetched entities
    - Input/User action
        - Create a WorkoutSession and then fetch it
    - Expected Result
        - The fetched WorkoutSessions list should not be empty and contain the created session

</details>

<details open>
<summary> testFetchWorkoutSessions() </summary>

***Tests fetching WorkoutSession entities***
- Validates the fetch functionality of the Core Data manager
    - Input/User action
        - Create and then fetch WorkoutSession entities
    - Expected Result
        - The fetch returns a list containing the newly created sessions

</details>

<details open>
<summary> testFetchWorkoutSessionsOnDate() </summary>

***Tests fetching WorkoutSession entities based on a specific date***
- Ensures that sessions on a given date are correctly retrieved
    - Input/User action
        - Create a WorkoutSession for today and fetch by today's date
    - Expected Result
        - The fetch returns a list containing only today's sessions

</details>

<details open>
<summary> testGetNextWorkoutNumber() </summary>

***Tests retrieving the next workout number***
- Ensures correct incrementation of workout numbers
    - Input/User action
        - Create a WorkoutSession and then retrieve the next workout number
    - Expected Result
        - The next workout number should be greater than the number of the last session created

</details>

<details open>
<summary> testFetchExerciseSets() </summary>

***Tests fetching ExerciseSet entities associated with a WorkoutSession***
- Validates the fetch functionality for ExerciseSets tied to specific sessions
    - Input/User action
        - Create a WorkoutSession and an associated ExerciseSet, then fetch the sets
    - Expected Result
        - The fetched exercise sets list should contain the created set

</details>

<details open>
<summary> testUpdateWorkoutSession() </summary>

***Tests updating a WorkoutSession entity***
- Verifies that changes to an entity are persisted correctly
    - Input/User action
        - Update an existing WorkoutSession's attributes
    - Expected Result
        - The updated WorkoutSession should reflect the new attribute values

</details>

<details open>
<summary> testUpdateExerciseSet() </summary>

***Tests updating an ExerciseSet entity***
- Ensures property changes are saved correctly within the entity
    - Input/User action
        - Update an existing ExerciseSet's attributes
    - Expected Result
        - The updated ExerciseSet should reflect the new attribute values

</details>

<details open>
<summary> testFetchAllExerciseSets() </summary>

***Tests fetching all ExerciseSet entities***
- Validates that multiple sets are returned when expected
    - Input/User action
        - Create multiple ExerciseSets and fetch all
    - Expected Result
        - The fetched exercise sets list should include all created sets

</details>

<details open>
<summary> testFetchExerciseSetsForWorkoutNum() </summary>

***Tests fetching ExerciseSet entities by workout number***
- Ensures they are correctly retrieved based on the workout number
    - Input/User action
        - Create an ExerciseSet for a specific workout number and then fetch by that number
    - Expected Result
        - The fetched exercise sets list should contain the sets for the specific workout number

</details>









