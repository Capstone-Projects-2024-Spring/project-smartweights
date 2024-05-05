---
sidebar_position: 2
---
# Integration tests

Tests to demonstrate each use-case based on the use-case descriptions and the sequence diagrams. External input should be provided via mock objects and results verified via mock objects. Integration tests should not require manual entry of data nor require manual interpretation of results.

## Use Case 1 - Account Login

<details open>

<summary>A user wants to login into their account</summary>

- The user is presented with the login page.
- The user clicks the 'Login with Apple Account' button.
- The user enters their account info.
- The server verified the account.
- The user can continue into the app.

</details>

#### Assertions
1. After the user logins to the app, they will be routed to the Home Page.
2. The user's information will be cached onto the phone's storage to retain login information for the next time they open the app.

<br></br>

## Use Case 2 - Tutorial

<details open>

<summary>A user has already created a SmartWeights account and has logged in for the first time.</summary>

- The user logs into their SmartWeights account for the first time.
- The app displays a prompt for the user to watch a tutorial video.
3. The virtual pet highlights key features of the application.
4. The user finishes the tutorial and returns to the main navigation screen.

</details>

#### Assertions
1. The user will be routed through multiple different tabs/pages of the app by the pet while watching the video.
2. After the tutorial is done, there will be information cached onto the phone's storage to prevent the tutorial from happening again.

<br></br>

## Use Case 3 - Profile Management

<details open>

<summary>A user wants to change their profile settings and workout goals.</summary>

- The user selects the Profile tab.
- From there, the user can see all their settings and workout goals.
- The user selects the notifcations setting.
- The user edits the desired setting.


</details>

#### Assertions
1. The user should see all setting options as well as the workout goals they created.
2. When the user edits any setting, the updated setting will be saved.

<br></br>

## Use Case 4 - Connecting Sensors

<details open>

<summary>A user wants to connect their SmartWeights sensors with the mobile app.</summary>

- The user securely attaches the SmartWeight sensor to their dumbbell following the instructions provided via the mobile app.
- The user turns on all the sensors.
- Upon navigating the to workout page, the app will ask the user to allow bluetooth.
- After enabling bluetooth, the app will automatically connect to the sensors.
- The user will be notified that the sensors are connected.

</details>

#### Assertions
1. User will have all sensors set up on their body and equipment
2. User will see the indicators in the application that the sensors are connected.


<br></br>

## Use Case 5 - Starting a Workout via Voice Command

<details open>

<summary>User wants to start a workout session without manually interacting with their smartphone, using a voice commands while already in position to lift weights.</summary>

- After heading to the workout page, the user is prompted to input the weight of the dumbbells they will use.
- User enters the weights of the dumbbells into the app before starting the workout.
- User clicks on the microphone button after inputting the required prompts, reps, sets, weight, and countdown.
- User, in position to start lifting and without the need to interact with the device manually, says, “Start”.
- The phone processes the command and interface with the SmartWeights app to initiate the workout session based on the user's inputs from the prompts.
- The SmartWeights app activates the workout mode, starts recording the session, including the detection of lifting form, repetitions, and other relevant data using the attached sensors.

</details>

#### Assertions
1. The correct dumbbell weight is displayed within the workout page's UI.
2. After completing a workout, post-workout analysis is displayed to the screen due to the workout starting from the user saying "Start" and other required voice commands such as "Pause", "Next", "Finish".

<br></br>

## Use Case 6 - Performing Workout

<details open>

<summary>A user wants to complete a workout with the assistance of the virtual pet.</summary>

- The user navigates to the workout section.
- The user completes their repetitions and the SmartWeights application tracks the user's form.
- The virtual pet notifies the user if their form is incorrect.
- Once finished, the user ends the workout and the SmartWeights application generates a personalized report and summary of the workout for the user.

</details>

#### Assertions
1. A personalized report and summary of the workout is generated for the user.

<br></br>

## Use Case 7 - View Workout Feedback History

<details open>

<summary>A user wants to view their all their workout feedbacks.</summary>

- After completing a workout, the user selects the progress button on the home page.
- Once in, the user selects the date to receive workout feedback for that day.
- From this page, The user will then be able to view feedback on their form and the number of reps inputted.

</details>

#### Assertions
1. The user can select a date from the dropdown menu.
2. The workout feedback for the date is displayed.

<br></br>

## Use Case 8 - Purchasing Pet Cosmetics

<details open>

<summary>A user wants to purchase cosmetics for their virtual pet.</summary>

- The user navigates to the virtual pet store.
- The app displays cosmetics by category for the user to inspect.
- The user sees each cosmetic’s price and clicks the buy button on the desired cosmetic.
- The user has enough currency for the transaction, so the cosmetic is no longer purchaseable and placed into the user’s virtual pet inventory.
- The price of the cosmetic is deducted from the user’s total currency.

</details>

#### Assertions
1. User is able to navigate the cosmetic menu.
2. User has the ability to purchase cosmetics given adequate funds.

<br></br>

## Use Case 9 - Virtual Pet Customization

<details open>

<summary>A user wants to customize their virtual pet.</summary>

- The user taps on the Customize button found on the pet page.
- The user can tap an inventory button to look at what they currently have equipped/own.
- The user will then select any items they want to equip for their pet.
- The user will see their pet change according to the items they picked.

</details>

#### Assertions
1. User is able to open and navigate their inventory when pressing the inventory button.
2. Pet visuals are updated after user equips an accessory.

<br></br>

## Use Case 10 - Completing an achievement
<details open>
<summary>A user wants to complete an achievement</summary>


- The user navigates to the achievements section within the app and views the list of achievements.
- The user then views detailed information about the achievement, which includes details of the achievement completion requirement (e.g. total weight lifted, number of workouts completed).
- The user can check their current standings in the achievement via the app(achievement tab), which updates in real time, showing their progress.
- Once the completion requirement has been fully met, the app updates their list of completed achievements.

</details>

#### Assertions
1. User is able to view both completed and in progress achievements.
2. User is able to monitor progress of an achievement.

## Use Case 11 - Share with Friends

<details open>

<summary>A user wants to share their pet/achievements with their friends.</summary>

- The user selects the Profile tab.
- Within the Profile screen, the user will select the Share Profile button.
- A pop-up appears of options to share the image.
- User selects who/how they want to share.
- Profile is sent.


</details>

#### Assertions
1. JPEG of user profile appears when Share Profile button is pressed.
2. User can choose who they want to send their profile to.
3. User can choose how they want to send their profile.
4. Profile link can be viewed by receiver.

<br></br>
