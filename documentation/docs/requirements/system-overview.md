---
sidebar_position: 1
---

# System Overview

## Project Abstract
SmartWeights is a project that presents a comprehensive approach to fitness and virtual pets. The project aims to improve both physical and mental health by helping users fix their form, as well as rewarding them for their hard work.

SmartWeights removes the need for a personal trainer through the integration of sensors and dumbbells. It provides users with a set of sensors that can be attached to any dumbbell of their choice. This allows SmartWeights to capture data about the user’s weight-lifting form and relay it to the companion mobile app. The application of SmartWeights extends beyond a traditional fitness tracking app by incorporating unique features that track the user’s exercise form and provide real-time feedback using machine learning. The app will also allow the user to create a virtual pet that will motivate them to continue working out. Continuous workouts and progress will award users with a digital currency that they can then use to buy cosmetics for their virtual companion. The addition of having a virtual pet gives working out a fun and motivating experience. Not only do users get physical and mental satisfaction from working out, but they can also visually show their progress and dedication to their friends and family.


# Conceptual Design

The integrated project combining MacroBuddy and SmartWeights represents a comprehensive approach to fitness and wellness, blending advanced hardware with intuitive software to offer users a unique experience. This unified solution involves two key components: innovative fitness equipment and a mobile application that serves as the interface for mainly fitness guidance/tracking and customizing your virtual pet.

On the hardware front, SmartWeights employs an array of sensors integrated into both the dumbbells and sleeves that the user will wear, coupled with a Raspberry Pi Pico microcontroller. This setup is designed to meticulously monitor the user's weightlifting form and velocity, capturing precise data on their exercise routines. The microcontroller plays a pivotal role in processing this sensor data, which is then seamlessly transmitted to the mobile application. Here, advanced machine learning algorithms analyze the data to provide users with real-time feedback on their technique, ensuring that exercises are performed optimally for maximum effectiveness and safety.
Concurrently, the MacroBuddy component of the project leverages the versatility and ubiquity of mobile devices, requiring no additional hardware beyond a smartphone or tablet. The development of the MacroBuddy app hinges on React Native or Swift since the app will be available strictly for iOS users.

Data management is a critical aspect of the project, with MySQL serving as the backbone for securely storing and managing user data, from workout analytics to nutritional information. The application will integrate various APIs, including those for step tracking and accessing a comprehensive nutrition database, enriching the user experience with a wide array of functionalities. Deployment plans encompass availability on strictly the Apple App Store.

This fusion of SmartWeights' sensor-based fitness tracking and MacroBuddy's nutritional guidance, all accessible through a single mobile application, embodies a holistic approach to health and wellness. By offering detailed insights into both physical activity and dietary habits, the project aims to motivate users towards a balanced lifestyle, with technology serving as both a coach and companion on their wellness journey.

# Background

SmartWeights is a combination of two project proposals “SmartWeights” and “MarcoBuddy”. The idea for SmartWeights came about from the group’s personal experience with weight lifting and the challenges they faced. Going to the gym can be both intimidating and inaccessible, and SmartWeights aims to solve those issues. There are similar products on the market such as Dribbleup and Kabata, but these products have a huge price point while SmartWeights will try to differentiate itself by providing advanced analytics at a reasonable price point. The idea of MacroBuddy was to create a mobile application that would combine virtual pets and healthy habits. Most health apps that involve a virtual pet only promote users to get enough daily steps, but there are a multitude of different things that can help users be healthy like working out and eating a good diet. MacroBuddy’s goal was to focus on those other goals and reward users on sticking to their healthy habits. By combining these two ideas together, SmartWeights would be a cheap solution for beginner weightlifters and a way to keep them motivated to continue having healthy habits. 