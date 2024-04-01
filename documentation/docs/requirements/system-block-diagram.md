---
sidebar_position: 2
---

# System Block Diagram

![System Block Diagram Part 1](https://github.com/Capstone-Projects-2024-Spring/project-smartweights/assets/123014795/6de8c6d5-6725-47b7-b1cc-88ce2766f0b0)
**Figure 1.**
High level design of SmartWeights.

## Description
Figure 1 depicts a high-level design of SmartWeight's paired embedded-system and software application. The user will attach the Raspberry Pi sensor system to a dumbbell and their elbow. This hardware is connected to the user's mobile device application via Bluetooth. The application is built on the SwiftUI frontend framework. The application calls Apple's login authentication service to verify the user's account and stores their information into a CoreData database table. The application receives data from the sensors, processes the data and relays it to another table in the backend. It also communicates with the database to fetch information related to the user’s workout and virtual pet data and displays them as UI elements.

