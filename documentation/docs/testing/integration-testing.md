---
sidebar_position: 2
---
# Integration tests

Tests to demonstrate each use-case based on the use-case descriptions and the sequence diagrams. External input should be provided via mock objects and results verified via mock objects. Integration tests should not require manual entry of data nor require manual interpretation of results.

# Use Case 1 - Account Login

<details open="True">

<summary>A user wants to login into their account</summary>

- The user is presented with the login page.
- The user clicks the 'Login with Apple Account' button.
- The user enters their account info.
- The server verified the account.
- The user can continue into the app.

</details>

## Assertions
1. After the user logins to the app, they will be routed to the Home Page
2. The user's information will be cached onto the phone's storage to retain login information for the next time they open the app.

<br></br>

# Use Case 2 - Tutorial

<details open="True">

<summary>A user has already created a SmartWeights account and has logged in for the first time.</summary>

- The user logs into their SmartWeights account for the first time.
- The app displays a generic virtual pet that will guide the user through the application.
- The virtual pet highlights key features of the application.
- The user finishes the tutorial.
- The user is prompted to create their virtual pet.
- The user finishes the virtual pet creation process and is returned to the main navigation screen.
 
</details>

## Assertions
1. The user will be routed through multiple different tabs/pages of the app while being guided by the pet
2. After the tutorial is done, there will be information cached onto the phone's storage to prevent the tutorial from happening again several times

<br></br>

# Use Case 3 - Profile Management

<details open="True">

<summary>A user wants to change their profile settings and workout goals.</summary>

- The user selects the Profile tab.
- From there, the user can see all their settings and workout goals.
- The user selects the pencil icon next to the setting.
- The user edits the desired setting.

</details>

## Assertions
1. The user should see all setting options as well as the workout goals they created
2. When the user edits any setting, the updated information will be saved and some of the information will transfer to the database

<br></br>

# Use Case 4 - Importing Data From Apple Health to SmartWeight App

<details open="True">

<summary>User decides to integrate their SmartWeight app with Apple Health to import fitness and health data for a comprehensive overview of their wellness journey.</summary>

- The user navigates to the settings.
- The user selects the option to link the SmartWeight app with Apple Health.
- iOS will prompt the user to authorize access to the required data from Apple Health.
- The user grants permission for the SmartWeight app to access the specified data from Apple Health.
- iOS automatically begins importing the user’s health and fitness data from Apple Health into the SmartWeight app.

</details>

## Assertions
1. The Apple Health statistics/information will transfer over to the Smart Weights app

<br></br>

# Use Case 5 - Attaching Sensors

<details open="True>

<summary>A user wants to prepare for a workout by attaching sensors appropriately.</summary>

- The user gets the dumbbells and elbow sleeve they want to use.
- The user attaches the sensors to the heads of the dumbbell, locking it in securely.
- The user puts on the elbow sleeve.
- The user attaches the sensor to the elbow sleeve.
- The user attaches another sensor to their chest.

</details>

## Assertions
1. User will have all sensors set up on their body and equipment

<br></br>

# Use Case 6 - Syncing Sensors

<details open="True">

<summary>A user wants to sync their SmartWeights sensor with the mobile app.</summary>

- The user securely attaches the SmartWeight sensor to their dumbbell following the instructions provided via the mobile app.
- The user navigates to the Devices section on the app to initiate the addition of a new sensor.
- Within the app, the user selects the option to Add New Sensor. The app will provide instructions to ensure the sensor is on and in the pairing mode.
- The app will search for available sensors. The user selects their sensor from the list of available devices to start the pairing process.
- Once the user selects their sensor, the app establishes a connection via Bluetooth. A confirmation message is displayed to the user indicating that the sensor is successfully synced.

</details>

## Assertions
1. User receives a confirmation message displaying the sensor is successfully synced.

<br></br>

# Use Case 7 - Logging Dumbbell Weight

<details open="True">

<summary>User wants to log the weights of dumbbells used during a workout for tracking progress over time, independent of immediate feedback on form or technique.</summary>

- After selecting a workout type, the user is prompted to input the weight of the dumbbells they will use.
- User enters the weights of the dumbbells into the app before starting the workout.
- The user begins their workout session without further interaction with the app, focusing on their exercise routine.

</details>

## Assertions
1. The correct dumbbell weight is displayed within the workout page's UI.

<br></br>

# Use Case 8 - Starting a Workout via Siri Voice Command

<details open="True">

<summary>User wants to start a workout session without manually interacting with their smartphone, using a voice command through Siri while already in position to lift weights.</summary>

- User, in position to start lifting and without the need to interact with the device manually, says, “Hey Siri, Start my workout”.
- Siri processes the command and interface with the SmartWeights app to initiate the workout session based on the user's predefined settings or default workout plan.
- The SmartWeights app activates the workout mode, starts recording the session, including the detection of lifting form, repetitions, and other relevant data using the attached sensors.

</details>

## Assertions
1. After completing a workout, post-workout analysis is displayed to the screen.

<br></br>

# Use Case 9 - Performing Workout

<details open="True">

<summary>A user wants to complete a workout with the assistance of the virtual pet.</summary>

- The user navigates to the workout section.
- The user completes their repetitions and the SmartWeights application tracks how many reps are completed.
- The virtual pet notifies the user if their form is incorrect.
- Once finished, the user ends the workout and the SmartWeights application generates a personalized report and summary of the workout for the user.

</details>

## Assertions
1. A personalized report and summary of the workout is generated for the user.

<br></br>

# Use Case 10 - View Workout Feedback

<details open="True">

<summary>A user wants to view feedback post-workout.</summary>

- After completing a workout, the user selects the post-workout feedback button in the mobile application.
- Once in, the user selects the date to receive workout feedback for that day.
- From this page, The user will then be able to view feedback on their form and the number of reps they completed.

</details>

## Assertions
1. The user can select a date from the dropdown menu.
2. The workout feedback for the date is displayed.

<br></br>

# Use Case 11 - Purchasing Pet Cosmetics

<details open="True">

<summary>A user wants to purchase cosmetics for their virtual pet.</summary>

- The user navigates to the virtual pet store.
- The app displays cosmetics by category for the user to inspect.
- The user sees each cosmetic’s price and clicks the buy button on the desired cosmetic.
- The user has enough currency for the transaction, so the cosmetic is removed from the store and placed into the user’s virtual pet inventory.
- The price of the cosmetic is deducted from the user’s total currency.

</details>

## Assertions
1. User is able to navigate the cosmetic menu.
2. User has the ability to purchase cosmetics given adequate funds.

<br></br>

# Use Case 12: - Virtual Pet Customization

<details open="True">

<summary>A user wants to customize their virtual pet.</summary>

- The user taps on the Virtual Pet button.
- The user can tap an inventory button to look at what they currently have equipped/own.
- The user will then select any costume/accessory they want to equip for their pet.
- The user will see their pet change according to the costumes/accessories they picked.

</details>

## Assertions
1. User is able to open and navigate their inventory when pressing the inventory button.
2. Pet visuals are updated after user equips an accessory.

<br></br>

# Use Case 13 - Participating in Weekly Challenge

<details open="True">

<summary>The SmartWeight app introduces a weekly challenge feature to engage users in varied fitness activities, encouraging consistency and community interaction.</summary>

- The user navigates to the challenges section within the app and opts into the weekly challenge.
- Once opted in, the user can view detailed information about the challenge, which includes details of the challenge (e.g. total weight lifted, number of workouts completed) and potential reward (e.g. digital currency, virtual pet accessories).
- Throughout the week, the user engages in their regular workouts, with the app automatically tracking their progress toward the challenge goals using the integrated sensors.
- The user can check their current standings in the challenge via the app(challenge tab), which updates in real time, showing their progress.
- At the end of the week, the app notifies the user of the challenge outcome. If they have met the challenge criteria, they receive their reward.

</details>

## Assertions
1. User can opt into the weekly challenge.
2. Visual display shows user progress in weekly challenge.
3. User has the ability to view their current standings in the challenge tab.
4. Notification is received at the end of the week.

<br></br>

# Use Case 14 - Share with Friends

<details open="True">

<summary>A user wants to share their pet/achievements with their friends.</summary>

- The user selects the Virtual Pet tab.
- Within the Virtual Pet screen, the user will select the Share Profile button.
- A jpeg of their profile will appear on the screen.
- User selects who/how they want to share.
- Profile is sent.

</details>

## Assertions
1. JPEG of user profile appears when Share Profile button is pressed.
2. User can choose who they want to send their profile to.
3. User can choose how they want to send their profile.
4. Profile link can be viewed by receiver.

<br></br>
