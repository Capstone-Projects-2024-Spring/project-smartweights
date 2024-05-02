---
sidebar_position: 1
---
# Unit tests
Swift unit tests are done with Swift's XCTest

Pico-W testing is done with pytest library



## Front End

### Pet Page
<details >
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

### WorkoutViewModel

<details >
<summary> testIsInputZeroOrInvalid()</summary>

***Validates whether input values are zero or invalid***
- User inputs values for sets, reps, weights, and countdown
    - Input/User action
        - User enters input values
    - Expected Result
        - The function correctly identifies whether the input values are zero or invalid.
</details>

<details >
<summary> testIsValidInput()</summary>

***Validates the validity of input values***
- User inputs values for sets, reps, weights, and countdown
    - Input/User action
        - User enters input values
    - Expected Result
        - The function correctly identifies whether the input values are valid.
</details>

<details >
<summary> testStringToInt()</summary>

***Validates the conversion of string to integer***
- User inputs a string value
    - Input/User action
        - User enters a string value
    - Expected Result
        - The function correctly converts the string to an integer if possible; otherwise, returns nil.
</details>

<details >
<summary> testResetWorkoutState()</summary>

***Validates the reset of workout state***
- User resets the workout state
    - Input/User action
        - User initiates a new workout
    - Expected Result
        - The workout state variables are reset to their initial values.
</details>

<details >
<summary> testStartWorkout()</summary>

***Validates the start of workout***
- User starts a workout session
    - Input/User action
        - User initiates the start of a workout session
    - Expected Result
        - The workout state is updated to indicate that the workout has started.
</details>

<details >
<summary> testNextSet()</summary>

***Validates the transition to the next set***
- User progresses to the next set during a workout session
    - Input/User action
        - User initiates the transition to the next set
    - Expected Result
        - The workout state and relevant variables are updated accordingly for the next set.
</details>

<details >
<summary> testResetTimer()</summary>

***Validates the reset of timer***
- User resets the timer during a workout session
    - Input/User action
        - User initiates a new workout
    - Expected Result
        - The timer variables are reset, and the timer is deactivated.
</details>


### Pet Store Page

<details >
<summary> testSortItemsByPrice()</summary>  
    
- Test sorting items by price
    - Input/User action
        - Call `sortItems` with `sortByPrice: true`
     - Expected Result
        - Items should be sorted by price in ascending order
        
</details>


<details >
<summary> testSortItemsbyName()</summary>
    
- Test sorting items by name
    - Input/User action 
        - Call `sortItems` with `sortByPrice: false`
    - Expected Result
        - Items should be sorted by name in alphabetical order
</details>


<details >
<summary> testSubtractFunds()</summary>   
    
- Test subtracting funds
    - Input/User action 
        - Subtract funds using `subtractFunds(price: 100)`
    - Expected Result
        - `viewModel.userCur` should decrease by `100`
</details>


<details >
<summary> testPurchaseItem()</summary> 
    
- Test purchasing an item
    - Input/User action
        - Purchase an item using `purchaseItem(item: item)`
    - Expected Result
        - The item should be marked as bought
        - `viewModel.userCur` should decrease by the item's price
</details>


<details >
<summary> testAddFunds()</summary>
    
- Test adding funds to user currency
    - Input/User action
        - Add funds using `addFundtoUser(price: 100)`
    - Expected Result
        - `viewModel.userCur` should increase by `100`
</details>


### FormCriteria

<details >
<summary> getRandomGoodFormPhrase()</summary>

***The user gets one of three phrases when having good form***
- User finishes a workout and wants their feedback
    - Input/User action
        - User clicks 'finish set' or 'finish workout'
    - Expected Result
      - getRandomGoodFormPhrase() is called and the user sees one of the three phrases
  
</details>


<details >
<summary> updateWorkoutAnalysis()</summary>

***updates the workout analysis data with provided current data***
- User completes a workout session and wants to see the results
    - Input/User action
        - User finishes a workout session
    - Expected Result
        - The workout analysis is updated with the provided data and contains the expected keys.
</details>

<details >

<summary> averageUpDownAcceleration()</summary>

***Calculate of average up-down acceleration***
- User wants to ensure accurate calculation of up-down acceleration average
    - Input/User action
        - User performs several sets of exercises
    - Expected Result
        - The calculated average up-down acceleration falls within the range of 0 to 1.

</details>

<details >

<summary> averageWristLeftRightRotation()</summary>

***Calculates average wrist left-right rotation***
- User wants to ensure accurate calculation of left-right wrist rotation average
    - Input/User action
        - User performs several sets of exercises
    - Expected Result
        - The calculated average wrist left-right rotation falls within the range of 0 to 1.

</details>

<details >

<summary> overallWorkoutUpDownAverage()</summary>

***calculates overall workout up-down average***
- User wants to ensure accurate calculation of overall workout up-down average
    - Input/User action
        - User completes a workout session
    - Expected Result
        - The calculated overall workout up-down average falls within the range of 0 to 1 and is approximately equal to the expected value.


</details>

<details >

<summary> averageElbowSwing()</summary>

***calculates average elbow swing***
- User wants to ensure accurate calculation of elbow swing average
    - Input/User action
        - User performs several sets of exercises
    - Expected Result
        - The calculated average elbow swing falls within the range of 0 to 1.

</details>

<details >

<summary> averageElbowFlareForwardBackward()</summary>

***calculates average elbow flare forward-backward***
- User wants to ensure accurate calculation of elbow flare forward-backward average
    - Input/User action
        - User performs several sets of exercises
    - Expected Result
        - The calculated average elbow flare forward-backward falls within the range of 0 to 1.

</details>

<details >

<summary> overallWorkoutElbowSwing()</summary>

***calculates overall workout elbow swing***
- User wants to ensure accurate calculation of overall workout elbow swing
    - Input/User action
        - User completes a workout session
    - Expected Result
        - The calculated overall workout elbow swing falls within the range of 0 to 1 and is approximately equal to the expected value.


</details>

<details >

<summary> dangerousForm()</summary>

***Detects of dangerous form***
- User wants to ensure accurate detection of dangerous form based on provided data
    - Input/User action
        - User performs exercises with varying data
    - Expected Result
        - The function correctly identifies whether the provided data indicates dangerous form.

</details>

<details >

<summary> giveFeedback()</summary>

***generation of feedback***
- User wants to ensure accurate generation of feedback based on provided data
    - Input/User action
        - User completes an exercise session
    - Expected Result
        - The feedback generated for acceleration and elbow swing is formatted correctly, and the custom text feedback for elbow is correct.


</details>

## Database Integration

### CloudKit DB Tests

#### CloudKitManager Tests

<details>
<summary>Unit Tests for the CloudKitManager class</summary>
- testCreateUser()
    - Tests the creation of a new user in the database.
    - Expected Result:
        - `userExists` should be `true` after creating a user successfully.

- testFetchUser()
    - Tests the fetching of user data from the database.
    - Expected Result:
        - The fetched user data (`user`) should not be `nil`, and there should be no `error`.

- testGetCurrency()
    - Tests the retrieval of the currency value associated with the user.
    - Expected Result:
        - The retrieved currency value (`currency`) should not be `nil`, and there should be no `error`.

- testUpdateCurrency()
    - Tests the updating of the currency value associated with the user.
    - Expected Result:
        - There should be no `error` after updating the currency value.

- testGetName()
    - Tests the retrieval of the full name of the user.
    - Expected Result:
        - The retrieved name (`name`) should not be `nil`, and there should be no `error`.

- testUpdateName()
    - Tests the updating of the first name and/or last name of the user.
    - Expected Result:
        - There should be no `error` after updating the name.
</details>

#### BackgroundItemDBManager Tests

<details>
<summary>Unit Tests for the BackgroundItemDBManager class</summary>
- testFetchBackgroundItems()
    - Tests the fetching of background items from the database.
    - Expected Result:
        - There should be no error while fetching background items.
        - Background items should not be nil.

- testFetchSpecificBackgroundItem()
    - Tests the fetching of a specific background item from the database.
    - Expected Result:
        - There should be no error while fetching the specific background item.
        - The fetched background item should not be nil.
        - The image name of the fetched background item should match the provided image name.

- testCreateBackgroundItem()
    - Tests the creation of a new background item in the database.
    - Expected Result:
        - There should be no error while creating the background item.

- testSetUnactiveAllBackgroundItems()
    - Tests the deactivation of all background items in the database.
    - Expected Result:
        - There should be no error while deactivating all background items.

- testGetActiveBackground()
    - Tests the retrieval of the active background item.
    - Expected Result:
        - The active background item should be an empty string, indicating no active background.

</details>

#### UserDBManager Tests

<details>
<summary>Unit Tests for the UserDBManager class</summary>

- testCreateUser()
    - Tests the creation of a new user in the database.
    - Expected Result:
        - `userExists` should be `true` after creating a user successfully.

- testFetchUser()
    - Tests the fetching of user data from the database.
    - Expected Result:
        - The fetched user data (`user`) should not be `nil`, and there should be no `error`.

- testGetCurrency()
    - Tests the retrieval of the currency value associated with the user.
    - Expected Result:
        - The retrieved currency value (`currency`) should not be `nil`, and there should be no `error`.

- testUpdateCurrency()
    - Tests the updating of the currency value associated with the user.
    - Expected Result:
        - There should be no `error` after updating the currency value.

- testGetName()
    - Tests the retrieval of the full name of the user.
    - Expected Result:
        - The retrieved name (`name`) should not be `nil`, and there should be no `error`.

- testUpdateName()
    - Tests the updating of the first name and/or last name of the user.
    - Expected Result:
        - There should be no `error` after updating the name.


</details>

#### FoodItemDBManager Tests
<details>
<summary>Unit Tests for the FoodItemDBManager class</summary>
- testFetchFoodItems()
    - Tests the fetching of food items.
    - Expected Result:
        - There should be no error while fetching food items.
        - The fetched food items should not be nil.
        - The number of fetched food items should match the expected count.

- testCreateFoodItem()
    - Tests the creation of a food item.
    - Expected Result:
        - There should be no error while creating the food item.

- testUpdateQuantity()
    - Tests the update of a food item's quantity.
    - Expected Result:
        - There should be no error while updating the quantity.
        - The updated food item should be found in the food items list.

- testFetchQuantity()
    - Tests the fetching of a food item's quantity.
    - Expected Result:
        - There should be no error while fetching the quantity.
        - The fetched quantity should not be nil.

- testUpdateQuantity_add()
    - Tests the addition of quantity to a food item.
    - Expected Result:
        - There should be no error while updating the quantity.
        - The updated food item should be found in the food items list.

</details>

#### PetItemDBManager Tests
<details>
<summary>Unit Tests for the PetItemDBManager class</summary>
- testFetchPetItems()
    - Tests the fetching of pet items.
    - Expected Result:
        - There should be no error while fetching pet items.
        - The fetched pet items should not be nil.

- testFetchSpecificPetItem()
    - Tests the fetching of a specific pet item.
    - Expected Result:
        - There should be no error while fetching the specific pet item.
        - The fetched pet item should not be nil.
        - The fetched pet item should match the expected image name.

- testCreatePetItem()
    - Tests the creation of a pet item.
    - Expected Result:
        - There should be no error while creating the pet item.
        - The created pet item should be found in the pet items list.

- testSetActivePetItem()
    - Tests the setting of an active pet item.
    - Expected Result:
        - There should be no error while setting the active pet item.
        - The active pet item should match the expected image name.

- testGetActivePet()
    - Tests the retrieval of the active pet.
    - Expected Result:
        - There should be no error while retrieving the active pet.
        - The retrieved active pet should match the expected image name.

</details>

#### PetDBManager Tests

<details>
<summary>Unit Tests for the PetDBManager class</summary>
- testCreatePet()
    - Tests the creation of a pet.
    - Expected Result:
        - The pet should exist after creation.
        - The initial existence status of the pet should not match the existence status after creation.

- testFetchPet()
    - Tests the fetching of a pet.
    - Expected Result:
        - There should be no error while fetching the pet.
        - The fetched pet should not be nil.

- testGetXP()
    - Tests the retrieval of XP.
    - Expected Result:
        - There should be no error while retrieving XP.

- testGetLevel()
    - Tests the retrieval of the level.
    - Expected Result:
        - There should be no error while retrieving the level.
        - The retrieved level should not be nil.

- testUpdateUserXP()
    - Tests the updating of user XP.
    - Expected Result:
        - There should be no error while updating user XP.
        - The total XP should match the new XP value.

- testUpdateUserLevel()
    - Tests the updating of user level.
    - Expected Result:
        - There should be no error while updating user level.
        - The level should match the new level value.

</details>

#### FitnessPlanDBManager Tests
<details>
<summary>Unit Tests for the FitnessPlanDBManager class</summary>
- testCreateFitnessPlan()
    - Tests the creation of a fitness plan.
    - Expected Result:
        - The fitness plan should not be nil after creation.
        - The days per week goal of the created fitness plan should match the provided value.
        - The dumbbell weight goal of the created fitness plan should match the provided value.
        - The set goal of the created fitness plan should match the provided value.
        - The rep goal of the created fitness plan should match the provided value.
        - The notes of the created fitness plan should match the provided value.
</details>



### CoreData Local DB
<details >
<summary> setUpWithError() </summary>

***Sets up an in-memory Core Data environment for each test***
- Ensures tests do not affect real user data by creating a mock environment
    - Input/Setup action
        - Core Data stack setup with in-memory store type
    - Expected Result
        - CoreDataManager instance is initialized without errors

</details>

<details >
<summary> tearDownWithError() </summary>

***Cleans up and deallocates the in-memory Core Data stack after each test***
- Ensures all data and instances are cleaned up properly
    - Input/Cleanup action
        - Removing persistent stores from the coordinator
    - Expected Result
        - Persistent stores are removed without errors, and CoreDataManager is deallocated

</details>

<details >
<summary> testCreateWorkoutSession() </summary>

***Tests the ability to create a WorkoutSession entity***
- Validating entity creation within the Core Data environment
    - Input/User action
        - Create a WorkoutSession with specified attributes
    - Expected Result
        - WorkoutSession entity is not nil and correctly initialized with provided values

</details>

<details >
<summary> testCreateAndFetchWorkoutSessions() </summary>

***Tests integration of creating and fetching WorkoutSession entities***
- Ensures data consistency within the created and fetched entities
    - Input/User action
        - Create a WorkoutSession and then fetch it
    - Expected Result
        - The fetched WorkoutSessions list should not be empty and contain the created session

</details>

<details >
<summary> testFetchWorkoutSessions() </summary>

***Tests fetching WorkoutSession entities***
- Validates the fetch functionality of the Core Data manager
    - Input/User action
        - Create and then fetch WorkoutSession entities
    - Expected Result
        - The fetch returns a list containing the newly created sessions

</details>

<details >
<summary> testFetchWorkoutSessionsOnDate() </summary>

***Tests fetching WorkoutSession entities based on a specific date***
- Ensures that sessions on a given date are correctly retrieved
    - Input/User action
        - Create a WorkoutSession for today and fetch by today's date
    - Expected Result
        - The fetch returns a list containing only today's sessions

</details>

<details >
<summary> testGetNextWorkoutNumber() </summary>

***Tests retrieving the next workout number***
- Ensures correct incrementation of workout numbers
    - Input/User action
        - Create a WorkoutSession and then retrieve the next workout number
    - Expected Result
        - The next workout number should be greater than the number of the last session created

</details>

<details >
<summary> testFetchExerciseSets() </summary>

***Tests fetching ExerciseSet entities associated with a WorkoutSession***
- Validates the fetch functionality for ExerciseSets tied to specific sessions
    - Input/User action
        - Create a WorkoutSession and an associated ExerciseSet, then fetch the sets
    - Expected Result
        - The fetched exercise sets list should contain the created set

</details>

<details >
<summary> testUpdateWorkoutSession() </summary>

***Tests updating a WorkoutSession entity***
- Verifies that changes to an entity are persisted correctly
    - Input/User action
        - Update an existing WorkoutSession's attributes
    - Expected Result
        - The updated WorkoutSession should reflect the new attribute values

</details>

<details >
<summary> testUpdateExerciseSet() </summary>

***Tests updating an ExerciseSet entity***
- Ensures property changes are saved correctly within the entity
    - Input/User action
        - Update an existing ExerciseSet's attributes
    - Expected Result
        - The updated ExerciseSet should reflect the new attribute values

</details>

<details >
<summary> testFetchAllExerciseSets() </summary>

***Tests fetching all ExerciseSet entities***
- Validates that multiple sets are returned when expected
    - Input/User action
        - Create multiple ExerciseSets and fetch all
    - Expected Result
        - The fetched exercise sets list should include all created sets

</details>

<details >
<summary> testFetchExerciseSetsForWorkoutNum() </summary>

***Tests fetching ExerciseSet entities by workout number***
- Ensures they are correctly retrieved based on the workout number
    - Input/User action
        - Create an ExerciseSet for a specific workout number and then fetch by that number
    - Expected Result
        - The fetched exercise sets list should contain the sets for the specific workout number

</details>









