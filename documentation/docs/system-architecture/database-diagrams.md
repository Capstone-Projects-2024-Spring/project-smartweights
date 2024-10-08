---
sidebar_position: 9
---

# Database Diagrams

SmartWeights uses a relation schema approach to the database design. It combines usage of both cloud based database (CloudKit) and local storage database (CoreData).

## CloudKit Database Design

CloudKit uses a relational database schema where every record has a relation to an iCloud user record that is created by CloudKit.

The **_User_** entity is meant to store the id that is generated by CloudKit and other relevant data. This is used as the parent for other entities.
CloudKit offers two databases:

- Public
  - Records that are accessible to all users of the application
- Private
  - Records that are only accessible to the specific iCloud user

The portions of the public database are all of the asset related entities. The public database's data is never manipulated by users, only read. These entities being:
- Achievement

The user is able to manipulate data in their "private cloud database." These specific entities being:

- User
- Pet
- PetItem
- ClothingItem
- FoodItem
- BackgroundItem
- FitnessPlan
- UserAchievement

```mermaid
---
title: ERD (Cloud base, User)
---
erDiagram

    %% User ||--||Achievement_List: has
   
    User ||--||Pet: has
    User ||--|{PetItem: has
    User ||--o{BackgroundItem: has
    User ||--o{ClothingItem: has
    User ||--o{FoodItem: has

    User ||--||fitness_plan: has

     User ||--o{User_Achievements:has
    Achievement ||--|{ User_Achievements: has


   
    fitness_plan{

        int daysPerWeekGoal
        int dumbbellWeightGoal
        int setGoal
        int repGoal
        string notes
        date selectedDate
    }
    User {
        string first_name
        string last_name
        int currency
        date latest_login

    }
    Pet{
        int level
        int health
        int total_xp
    }
    PetItem{
        int isActive
        string pet_name
        string pet_image_url
    }
    FoodItem{
        int quantity
        string food_name
        string food_image_url
    }
    BackgroundItem{
        int isActive
        string background_name
        string background_image_url
    }
    ClothingItem{
        int isActive
        string clothing_name
        string clothing_image_url
    }
   Achievement{
        int Achievement
        string achievement_name
        int total_progress
    }
    User_Achievements{
        bool is_completed
        int progress_percentage

    }

```

The activeBackground and activePetClothing attributes act as references directly to their specific assets. The lists in inventory is an array of references to their specific assets. This is so an inventory can contain multiple of references, such as an inventory containing more than one type of background asset.


## CoreData Database Design

The purpose of the CoreData database design is to be lightweight and to contain the information that will be received from the multiple sensors attached to the user and dumbbells. This will help provide relevant feedback for the user's workout once the data has been processed through an algorithm. There will also be a history with each feedback to allow users to revisit and see their past feedback.

There will be a Workout Session with as many sets depending on how many sets the user is doing. The workout session will take all the data from several sets and process it through an algorithm to detect whether or not the user had good or bad form through a scoring system ( 1 to 100, 1 being worst to 100 being perfect). There will also be feedback correlated with the score and will consist of suggestions on how to fix up their form.

```mermaid
---
title: CoreData Structure
---

erDiagram
    Set {
       avgCurlAcceleration DOUBLE
        avgElbowFlareLeftRight DOUBLE
        avgElbowFlareUpDown DOUBLE
        avgElbowSwing DOUBLE
        avgWristStabilityLeftRight DOUBLE
        avgWristStabilityUpDown DOUBLE 
        setNum INT
    }
    WorkoutSession {
        
        dateTime DATETIME
        overallCurlAcceleration DOUBLE 
        overallElbowFlareLeftRight DOUBLE
        overallElbowFlareUpDown DOUBLE
        overallElbowSwing DOUBLE
        overallWristStabilityLeftRight DOUBLE
        overallWristStabilityUpDown DOUBLE
        reps INT
        weight DOUBLE
        workoutNum INT 
    }

    WorkoutSession ||--|{ Set : has



```
