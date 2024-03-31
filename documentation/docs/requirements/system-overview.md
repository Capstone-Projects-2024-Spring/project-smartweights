---
sidebar_position: 1
---

# System Overview

## Project Abstract
SmartWeights is a project that presents a comprehensive approach to fitness and virtual pets. The project aims to improve both physical and mental health by helping users fix their form, as well as rewarding them for their hard work.

SmartWeights removes the need for a personal trainer through the integration of sensors and dumbbells. It provides users with a set of sensors that can be attached to any dumbbell of their choice. This allows SmartWeights to capture data about the user’s weight-lifting form and relay it to the SmartWeights mobile app. The application of SmartWeights extends beyond a traditional fitness tracking app by incorporating unique features that track the user’s exercise form and provide real-time feedback. The app will allow the user to create their own virtual pet that will motivate them to continue working out by providing feedback and through the pet’s level up and customization system. Continuous workouts and progress will award users with a digital currency that they can then use to buy items for their pet. The virtual pet gives working out a fun and motivating experience, as not only do users get physical and mental satisfaction from working out, but they can also visually show their progress and dedication to their friends and family.



# Conceptual Design

SmartWeights will consist of attachable/wearable sensors sending data to an iOS application through Bluetooth. The sensors combine Raspberry Pi Pico W  microcontrollers and MPU6050 accelerometers. These devices are then placed on dumbbells and the user’s elbows and chest to track changes in position during a workout. Using the built-in Bluetooth shield on the Pico, we can then relay the sensors’ coordinates to the paired iOS app.

Designed with Swift using SwiftUI, the app will process the data and display feedback on the user’s weightlifting form. Users will be required to login with their Apple accounts using Apple’s Sign-In SDK and OAuth. User accounts will be tracked and stored with Apple’s CloudKit service. Users can start their workouts using SiriKit’s voice activation feature. SmartWeights is only available on iOS.



# Background

SmartWeights is a combination of two project proposals, “SmartWeights” and “MarcoBuddy”. The idea for SmartWeights came about from the group’s personal experience with weight lifting and the challenges they faced. Going to the gym can be both intimidating and inaccessible, and SmartWeights aims to solve those issues. There are similar products on the market such as Dribbleup and Kabata, but these products have a huge price point. SmartWeights will try to differentiate itself by providing advanced analytics at a reasonable price point. The idea of MacroBuddy was to create a mobile application that would combine virtual pets and healthy habits. Most health apps that involve a virtual pet only promote users to get enough daily steps, but there are a multitude of different things that can help users be healthy like working out and eating a good diet. MacroBuddy’s goal was to focus on those other goals and reward users on sticking to their healthy habits. By combining these two ideas together, SmartWeights would be a cheap solution for weightlifters and a way to keep them motivated to continue having healthy habits.
 
