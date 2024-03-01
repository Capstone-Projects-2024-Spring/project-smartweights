---
sidebar_position: 2
---
# Integration tests

Tests to demonstrate each use-case based on the use-case descriptions and the sequence diagrams. External input should be provided via mock objects and results verified via mock objects. Integration tests should not require manual entry of data nor require manual interpretation of results.

# Use Case 1 - Account Login

A user wants to login into their account

1. The user is presented with the login page.
2. The user clicks the 'Login with Apple Account' button.
3. The user enters their account info.
4. The server verified the account.
5. The user can continue into the app.

## Assertion

1. After the user logins to the app, they will be routed to the Home Page
2. The user's information will be cached onto the phone's storage to retain login information for the next time they open the app.

# Use Case 2 - Tutorial
A user has already created a SmartWeights account and has logged in for the first time.

1. The user logs into their SmartWeights account for the first time.
2. The app displays a generic virtual pet that will guide the user through the application.
3. The virtual pet highlights key features of the application.
4. The user finishes the tutorial.
5. The user is prompted to create their virtual pet.
6. The user finishes the virtual pet creation process and is returned to the main navigation screen.

## Assertion

1. The user will be routed through multiple different tabs/pages of the app while being guided by the pet
2. After the tutorial is done, there will be information cached onto the phone's storage to prevent the tutorial from happening again several times

# Use Case 3 - Profile Management
A user wants to change their profile settings and workout goals.

1. The user selects the Profile tab.
2. From there, the user can see all their settings and workout goals.
3. The user selects the pencil icon next to the setting.
4. The user edits the desired setting.

## Assertion

1. The user should see all setting options as well as the workout goals they created
2. When the user edits any setting, the updated information will be saved and some of the information will transfer to the database

# Use Case 4 - Importing Data From Apple Health to SmartWeight App
User decides to integrate their SmartWeight app with Apple Health to import fitness and health data for a comprehensive overview of their wellness journey.

1. The user navigates to the settings.
2. The user selects the option to link the SmartWeight app with Apple Health.
3. iOS will prompt the user to authorize access to the required data from Apple Health.
4. The user grants permission for the SmartWeight app to access the specified data from Apple Health.
5. iOS automatically begins importing the user’s health and fitness data from Apple Health into the SmartWeight app.

## Assertion

1. The Apple Health statistics/information will transfer over to the Smart Weights app

# Use Case 5 - Attaching Sensors
A user wants to prepare for a workout by attaching sensors appropriately.

1. The user gets the dumbbells and elbow sleeve they want to use.
2. The user attaches the sensors to the heads of the dumbbell, locking it in securely.
3. The user puts on the elbow sleeve.
4. The user attaches the sensor to the elbow sleeve.
5. The user attaches another sensor to their chest.

## Assertion

1. User will have all sensors set up on their body and equipment
