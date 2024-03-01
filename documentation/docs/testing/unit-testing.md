---
sidebar_position: 1
---
# Unit tests
For each method, one or more test cases.

A test case consists of input parameter values and expected results.

All external classes should be stubbed using mock objects.


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

***The date is updated when the user use the calendar***
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





