<div align="center">

# Smart Weights
[![Report Issue on Jira](https://img.shields.io/badge/Report%20Issues-Jira-0052CC?style=flat&logo=jira-software)](https://temple-cis-projects-in-cs.atlassian.net/jira/software/c/projects/DT/issues)
[![Deploy Docs](https://github.com/ApplebaumIan/tu-cis-4398-docs-template/actions/workflows/deploy.yml/badge.svg)](https://github.com/ApplebaumIan/tu-cis-4398-docs-template/actions/workflows/deploy.yml)
[![Documentation Website Link](https://img.shields.io/badge/-Documentation%20Website-brightgreen)](https://applebaumian.github.io/tu-cis-4398-docs-template/)


</div>


## Keywords

Section 001, Swift, Python, Xcode, Raspberry Pi Pico, iOS Application, Machine Learning, TensorFlow

## Project Abstract

SmartWeights is a project that presents a comprehensive approach to fitness and virtual pets. The project aims to improve both physical and mental health by helping users fix their form, as well as rewarding them for their hard work.

SmartWeights removes the need for a personal trainer through the integration of sensors and dumbbells. It provides users with a set of sensors that can be attached to any dumbbell of their choice. This allows SmartWeights to capture data about the user’s weight-lifting form and relay it to the companion mobile app. The application of SmartWeights extends beyond a traditional fitness tracking app by incorporating unique features that track the user’s exercise form and provide real-time feedback using machine learning. The app will also allow the user to create a virtual pet that will motivate them to continue working out. Continuous workouts and progress will award users with a digital currency that they can then use to buy cosmetics for their virtual companion. The addition of having a virtual pet gives working out a fun and motivating experience. Not only do users get physical and mental satisfaction from working out, but they can also visually show their progress and dedication to their friends and family.

## High Level Requirement

### Functional Requirements
1. SmartWeights will give users feedback and information about their weightlifting form after each workout.
2. After each workout the system generates personalized reports and analytics for users.
    - Virtual pet will give a synopsis
    - The user will be able to revisit the reports at any given time post-workout.
3. SmartWeights will require registration using an Apple Account.
4. The user must be able to enter the weight of their dumbbell.
5. The user must be able to connect the sensors by pressing a button in the application.
6. The user must be able to calibrate their start position and inform the application through voice commands
7. The main page of the app will appear first and have a tutorial prompt for new users
    - The user will be able to revisit the tutorial prompt.
8. The tutorial will be demonstrated by SmartWeights' generic pet.
9. The user must be able to go to a user information page and set their nutrition goals and their body measurements. 
10. The user will be able to create a workout plan.
11. During the process of the user workout it will provide real-time feedback on the user's action such as correcting posture, velocity, or speed.
12. The app will award the users with digital currency based on their workout achievements.
    - There will be a tab for a shop dedicated to buying costumes/accessories for your Virtual Pet with in-game currency.
13. The pet will have a level-up system and a health system.
    - Users can use the in-game currency to buy food for their pet to keep the pet healthy.
14. There will be an achievement tab for users to look through all their past achievements they’ve gained as well as other achievements they can strive for.
15. Users can click on a button to share an image of their virtual pet along with other accolades to share with friends.
16. Challenge tab - a weekly and monthly challenge that users can do to earn free pet items or in-game currency.
17. The user must be able to customize their in-app settings.
    - notifications, Apple Health




### Nonfunctional Requirements
1. Hardware should communicate with mobile devices through Bluetooth.
2. To ensure ease of use and learning, the app needs a user-friendly interface that allows users to navigate through all features independently without requiring assistance.
3. The app generates data in a timely fashion post-workout.
    - The data is easily understandable by the user. It is accompanied by visual graphs and text to help explain it.
4. The app generates notifications to remind and encourage users to work out and use the app.
5. The hardware components must be securely contained and easily attachable.
6. The hardware components must have easy access to being charged.
7. The database and machine learning processes will be handled locally on the user’s device.
8. The mobile app will start up promptly.
9. The app will keep users engaged with activities and attractive designs.

## Conceptual Design

SmartWeights will consist of attachable/wearable sensors sending data to an iOS application through Bluetooth. The sensors combine Raspberry Pi Pico microcontrollers and ADXL345 accelerometers. These devices are then placed on dumbbells and the user’s elbows and chest to track changes in position during a workout. Using the built-in Bluetooth shield on the Pico, we can then relay the sensors’ coordinates to the paired iOS app.

Designed with Swift using SwiftUI, the app will process the data and display feedback on the user’s weightlifting form. Users will be able to create accounts and have the option to log in with their Apple accounts using Apple’s Sign-In SDK and OAuth. They will also have the option to connect the app to their Apple Health with HealthKit. User accounts will be tracked and stored with Firebase’s NoSQL database hosting service. Users can start their workouts using SiriKit’s voice activation feature. The feedback displayed will be a generated response based on a trained machine learning (ML) model. The ML model will be trained and its data will be stored on a local Core Data NoSQL database. The training and processing of data will be done in Python using the TensorFlow library.

## Background

SmartWeights is a combination of two project proposals “SmartWeights” and “MarcoBuddy”. The idea for SmartWeights came about from the group’s personal experience with weight lifting and the challenges they faced. Going to the gym can be both intimidating and inaccessible, and SmartWeights aims to solve those issues. There are similar products on the market such as Dribbleup and Kabata, but these products have a huge price point while SmartWeights will try to differentiate itself by providing advanced analytics at a reasonable price point. The idea of MacroBuddy was to create a mobile application that would combine virtual pets and healthy habits. Most health apps that involve a virtual pet only promote users to get enough daily steps, but there are a multitude of different things that can help users be healthy like working out and eating a good diet. MacroBuddy’s goal was to focus on those other goals and reward users on sticking to their healthy habits. By combining these two ideas together, SmartWeights would be a cheap solution for beginner weightlifters and a way to keep them motivated to continue having healthy habits.

## Required Resources

- iOS
- Dumbbells
- Workout Bench
- 3D printer
- Sensors (IMUs, Barometers)
- Raspberry Pi Pico W
- Mobile Application Development Environment
- IDE/text editor
- Project management (Jira)
- Version Control management (GitHub/Git)
- Database (Firebase & NoSQL)

## Collaborators

[//]: # ( readme: collaborators -start )
<table>
<tr>
    <td align="center">
        <a href="https://github.com/ApplebaumIan">
            <img src="https://avatars.githubusercontent.com/u/9451941?v=4" width="100;" alt="ApplebaumIan"/>
            <br />
            <sub><b>Ian Tyler Applebaum</b></sub>
        </a>
    </td>
    <td align="center">
        <a href="https://github.com/leekd99">
            <img src="https://avatars.githubusercontent.com/u/32583417?v=4" width="100;" alt="leekd99"/>
            <br />
            <sub><b>Kyle Dragon Lee</b></sub>
        </a>
    </td>
    <td align="center">
        <a href="https://github.com/thanhnguyen46">
            <img src="https://avatars.githubusercontent.com/u/60533187?v=4" width="100;" alt="thanhnguyen46"/>
            <br />
            <sub><b>Thanh Nguyen</b></sub>
        </a>
    </td>
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
