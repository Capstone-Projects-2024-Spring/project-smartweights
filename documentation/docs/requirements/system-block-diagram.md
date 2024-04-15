---
sidebar_position: 2
---

# System Block Diagram

![System Block Diagram Pt 2](https://github.com/Capstone-Projects-2024-Spring/project-smartweights/assets/123014795/2863a149-8e81-4b2d-acf2-7d0c05b05baa)
**Figure 1.**
High level design of the SmartWeights system.

## Description
Figure 1 illustrates the overarching architecture of SmartWeights, showcasing the integration between its paired embedded-system and software application. The Raspberry Pi sensors, the embedded system, is attached to both the dumbbell and the user's elbow. This system interacts with a user's mobile application via Bluetooth. The application's frontend is built with SwiftUI, which implements Apple's login authentication service to verify user accounts. User profile and workout data read from the frontend are stored in CoreData database tables along with the images and assests related to virtual pets. The application also reads from the database to gather information related to the user’s workout and virtual pet and displays them as UI elements.

