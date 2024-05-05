<div align="center">

# Smart Weights
[![Report Issue on Jira](https://img.shields.io/badge/Report%20Issues-Jira-0052CC?style=flat&logo=jira-software)](https://temple-cis-projects-in-cs.atlassian.net/jira/software/c/projects/DT/issues)
[![Deploy Docs](https://github.com/ApplebaumIan/tu-cis-4398-docs-template/actions/workflows/deploy.yml/badge.svg)](https://github.com/ApplebaumIan/tu-cis-4398-docs-template/actions/workflows/deploy.yml)
[![Documentation Website Link](https://img.shields.io/badge/-Documentation%20Website-brightgreen)](https://applebaumian.github.io/tu-cis-4398-docs-template/)


</div>


## Keywords

Section 001, Swift, Python, Xcode, Raspberry Pi Pico, iOS Application 

## Project Abstract

SmartWeights is a project that presents a comprehensive approach to fitness and virtual pets. The project aims to improve both physical and mental health by helping users fix their form, as well as rewarding them for their hard work.

SmartWeights removes the need for a personal trainer through the integration of sensors and dumbbells. It provides users with a set of sensors that can be attached to any dumbbell of their choice. Users will also be provided sensors to attach to their body depending on the exercise of their choice. This allows SmartWeights to capture data about the user’s weight-lifting form and relay it to the SmartWeights mobile app. The application of SmartWeights extends beyond a traditional fitness tracking app by incorporating unique features that track the user’s exercise form and provide feedback after each set. The app will allow the user to create their own virtual pet that will motivate them to continue working out by providing feedback and through the pet’s level-up and customization system. Continuous workouts and progress will award users with a digital currency that they can then use to buy items for their pet. The virtual pet gives working out a fun and motivating experience, as not only do users get physical and mental satisfaction from working out, but they can also visually show their progress and dedication to their friends and family.

## High Level Requirement

### Functional Requirements
1. SmartWeights will give users feedback and information about their weightlifting form after each set in their workout.
2. After each workout, the system generates personalized reports and analytics for users.
    - The virtual pet will give a synopsis.
    - The user will be able to revisit the reports at any given time post-workout.
3. SmartWeights will require registration using an Apple Account.
4. The user must be able to enter the amount of sets, reps, and the weight of their dumbbell before performing a workout.
5. The user must be able to connect the sensors by pressing a button in the application.
6. The user must be able to start workouts through voice commands.
7. The home page will be displayed after user login, and a tutorial prompt will appear for newly registered users.
    - The tutorial will be a video demonstrated by SmartWeights' generic pet.
    - The user will be able to revisit the tutorial prompt.
8. The user must be able to create a workout plan that can be tracked from a fitness plan page.
9. During the process of the user workout, it will provide feedback after each set on the user's action such as correcting their form.
10. The app will award the users with digital currency and experience points based on their workouts.
    - There will be a pet store tab dedicated to buying items for your virtual pet with digital currency.
11. The pet will have a level-up system and a health system.
    - Users can use digital currency to buy food for their pet in the pet store tab to keep the pet healthy.
12. There will be an achievement tab for users to look through their completed achievements as well as achievements they can strive for.
13. Users can click on a share button that displays their virtual pet along with other accolades they would like to share with friends.
14. The user must be able to customize their in-app settings, including setting preferences for notifications.




### Nonfunctional Requirements
1. Hardware should communicate with mobile devices through Bluetooth.
2. To ensure ease of use and learning, the app needs a user-friendly interface that allows users to navigate through all features independently without requiring assistance.
3. The app generates data in a timely fashion after each set is completed in a workout.
    - The data is easily understandable by the user. It is accompanied by visual graphs and text to help explain it.
4. The app generates notifications to remind and encourage users to work out and use the app.
5. The hardware components must be securely contained and easily attachable.
6. The hardware components must have easy access to being charged.
7. The database will properly and efficiently store and handle user data.
8. The mobile app will start up promptly.
9. The app will keep users engaged with activities and attractive designs.

## Conceptual Design

SmartWeights will consist of attachable/wearable sensors sending data to an iOS application through Bluetooth; the MPU6050 IMU sensors combine Raspberry Pi Pico W microcontrollers. These devices are then placed on the dumbbells and the user’s body depending on the exercise to track changes in position during a workout. Using the built-in Bluetooth shield on the Pico, we can then relay the sensors’ information to the paired iOS app.

Designed with Swift using SwiftUI, the app will process the data and display feedback on the user’s weightlifting form. Users will be required to log in with their Apple accounts using Apple’s Sign-In Authentication service. User accounts will be tracked and stored with Apple’s CloudKit service. User's achievements progression will be tracked and stored using Apple's GameCenter. Users can start their workouts using a voice recognition feature or through a button on the application. SmartWeights is only available on iOS.

## Background

SmartWeights is a combination of two project proposals, “SmartWeights” and “MarcoBuddy”. The idea for SmartWeights came about from the group’s personal experience with weightlifting and the challenges they faced. Going to the gym can be both intimidating and inaccessible, and SmartWeights aims to solve those issues. There are similar products on the market such as Dribbleup and Kabata, but these products have a huge price point. SmartWeights will try to differentiate itself by providing advanced analytics at a reasonable price point. The idea of MacroBuddy was to create a mobile application that would combine virtual pets and healthy habits. Most health apps that involve a virtual pet only encourage users to get enough daily steps, but there are a multitude of different things that can help users be healthy like working out and eating a good diet. MacroBuddy’s goal was to focus on those other goals and reward users for sticking to their healthy habits. By combining these two ideas, SmartWeights would be a cheap solution for weightlifters and a way to keep them motivated to continue having healthy habits.

## Required Resources

- iPhone with iOS 17
    - AppleID 
    - GameCenter Account
- Dumbbells
- Sensors (IMUs)
- Raspberry Pi Pico W
- Mobile Application Development Environment
- IDE/Text Editor
- Project Management (Jira)
- Version Control management (GitHub/Git)
- Database (Apple CloudKit)
- TestFlight
- 3D Printer
- CAD Software

## Installation Instructions

These instructions are to help build and run the project locally on your system.

#### Minimum Requirements

In order to install and build this project you must have (at the time of this being written):
- a MacOS machine
- MacOS Sonoma 14.4 as the minimum version
- XCode 15 minimum (XCode can be downloaded from the App Store)
- iPhone Simulator with iOS 17.0 minimum (XCode will download this for you), or iPhone with iOS 17.0 minimum
    - if using a physical iPhone, it can be connected via cable with the Mac machine.
- A valid iCloud Account
    - iCloud Account should also have at 10kb of free storage remaining.

The steps to building and running the project:
1.  `
git clone https://github.com/Capstone-Projects-2024-Spring/project-smartweights.git
`
2. Open XCode and click on `open existing project` 
3. Locate the project and select the `SmartWeights.xcodeproj` file.
    - This file will have the AppStore icon.
4. Select your target location to run the project through the dropdown at the time of the IDE.
    - It will likely say ***any iOS device (arm64)*** the first time
5. Press the *play*/*start the active scheme* button found in the top left of the IDE.

## Testing

Testing the application is also available through invitation via **TestFlight**. The invite link is [Here](https://testflight.apple.com/join/ABKummcT). This invite link will prompt you to download the **TestFlight** app on your iOS device and give you a beta release to the SmartWeights application. The instructions are given on the directed webpage. 

If you are unable to access the link, or unable to download the app due to the limit of testers allowed has been met, contact:
smartweights1@gmail.com

### Milestone Demo 2

As this is the first version openly available to test, the SmartWeights team is requesting a test of the full application. The version being tested is v3.0.0. 
If testing through TestFlight, there should be a section to leave feedback for the SmartWeights developer team to read through if you choose to submit feedback. You can submit feedback by clicking on the app icon in the **TestFlight** app and the **Send Beta Feedback** button 

List of testing: 
- Signing up/logging in for the application
- Navigating through all the pages in the application
- Watching a workout instructional video on the home page.
- Starting and finishing a workout 
- Connecting with a SmartWeights sensor
- Purchasing items from the pet store
- Customizing your virtual pet
- Inputting user details in the profile

## Collaborators

[//]: # ( readme: collaborators -start )
<table>
<tr>
    <td align="center">
        <a href="https://github.com/parchea">
            <img src="https://github.com/parchea.png" width="100;" alt="parchea"/>
            <br />
            <sub><b>Par Chea</b></sub>
        </a>
    </td>
    <td align="center">
        <a href="https://github.com/DanielEap">
            <img src="https://github.com/DanielEap.png" width="100;" alt="DanielEap"/>
            <br />
            <sub><b>Daniel Eap</b></sub>
        </a>
    </td>
    <td align="center">
        <a href="https://github.com/jtstanczak7">
            <img src="https://github.com/jtstanczak7.png" width="100;" alt="jtstanczak7"/>
            <br />
            <sub><b>Jonathan Stanczak</b></sub>
        </a>
    </td>
    <td align="center">
        <a href="https://github.com/AdamRa97">
            <img src="https://github.com/AdamRa97.png" width="100;" alt="AdamRa97"/>
            <br />
            <sub><b>Adam Ra</b></sub>
        </a>
    </td>
     <td align="center">
        <a href="https://github.com/SlowMiata">
            <img src="https://github.com/SlowMiata.png" width="100;" alt="SlowMiata"/>
            <br />
            <sub><b>Tu Ha</b></sub>
        </a>
    </td>
    <td align="center">
        <a href="https://github.com/tun38646">
            <img src="https://github.com/tun38646.png" width="100;" alt="tun38646"/>
            <br />
            <sub><b>Timothy Bui</b></sub>
        </a>
    </td>
    <td align="center">
        <a href="https://github.com/dillon09776">
            <img src="https://github.com/dillon09776.png" width="100;" alt="tup09776"/>
            <br />
            <sub><b>Dillon Shi</b></sub>
        </a>
    </td>
   </tr>
</table>

[//]: # ( readme: collaborators -end )
