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
