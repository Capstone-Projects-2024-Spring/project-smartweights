---
sidebar_position: 2
---

# System Block Diagram

![BlockDiagram](https://github.com/Capstone-Projects-2024-Spring/project-smartweights/assets/114025055/4d1bad1f-cdf1-45e2-a370-775240dd9767)

## Figure 1. High-level design of the SmartWeights application.

Figure 1 depicts the high-level design of the embedded-system and software application merge. The user will attach the hardware component of the RaspberryPI system to their dumbbells and elbow sleeves. The hardware is connected via bluetooth to the user's mobile device. The mobile device has an application that is built on the SwiftUI frontend framework. The application calls the Apple Health Kit API and OAuth API and stores the information into a database. The application communicates with the backend as well to gather and update information related to the user’s workout and virtual pet data.

