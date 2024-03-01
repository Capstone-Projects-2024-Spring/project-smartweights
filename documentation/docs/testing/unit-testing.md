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

***Health Increases After Eating Food***
- Test user is feeding their pets food
    - Input/User action
        - User clicks on food button to feed pet
    - Expected Result
        - handleFoodUse() is called, health bar should increase


***Food Quantity Decreases After Eating Food***
- Test user is feeding their pets food
    - Input/User action
        - User clicks on food button to feed pet
    - Expected Result
        - handleFoodUse() is called, food quantity should decrease

***Health Should Not Exceed After Eating Food***
- Test user is feeding their pet with the pet's health bar full
    - Input/User action
        - User clicks on food button to feed pet
    - Expected Result
        - handleFoodUse() is called, health bar bar should not exceed full

***Alert Users of insufficient amount of food***
- Test user is feeding their pets with insufficient amount of food
    - Input/User action
        - User clicks on food button to feed pet
    - Expected Result
        - handleFoodUse() is called, an alert pops up telling the user they have no more food


***Alert Users that health is at max ***
- Test user is feeding their pets the health already full
    - Input/User action
        - User clicks on food button to feed pet
    - Expected Result
        - handleFoodUse() is called, an alert pops up telling the user that the health bar is already full
    
</details>


