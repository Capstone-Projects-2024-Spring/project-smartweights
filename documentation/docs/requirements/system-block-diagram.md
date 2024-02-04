---
sidebar_position: 2
---

# System Block Diagram
![BlockDiagram](https://github.com/Capstone-Projects-2024-Spring/project-smartweights/assets/114025055/7290ca5c-d5d2-45ae-bb74-f45bb234f3ea)

## Figure 1. High-level design of the SmartWeights application.

Figure 1 depicts the high-level design of the embedded-system and software application merge. The user will attach the hardware component of the RaspberryPI system to their dumbbells and elbow sleeves. The hardware is connected via bluetooth to the user's mobile device. The mobile device has an application that is built on the SwiftUI frontend framework. The application calls the Apple Health Kit API and OAuth API and stores the information into a SQL database. The application constantly communicates with it.

