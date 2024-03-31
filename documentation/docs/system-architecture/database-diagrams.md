---
sidebar_position: 9
---

# Database Diagrams
SmartWeights uses a relation schema approach to the database design. It combines usage of both cloud based database (CloudKit) and local storage database (CoreData). 


## CloudKit Database Design
CloudKit uses a relational 

- Profile
- Achievements
- Pet
- Fitness Data

```mermaid
---
title: NoSQL ERD (Cloud base, User)
---
erDiagram 
    User ||--o{ UserProfile : has
    User ||--|| Apple : has
    %% User ||--||Achievement_List: has
    UserProfile ||--||Fitness_data: contains
    User ||--||Pet:has
    Pet ||--|| Pet_image: has 
    Inventory ||--|{ Pet_clothing: has 
    Pet ||--||Inventory: has
    Inventory ||--|{ Food: has 
    Inventory ||--|{ Background: has 
    %% Shop ||--|{ Pet: has
    %% Shop ||--|{ Pet_clothing: has
    Fitness_data||--||fitness_plan: has 
    Fitness_data||--|{Feedback_data:has
   User ||--|{User_Achievements:has
    Achievement ||--|{ User_Achievements: has-ListIsPublic

    UserProfile {
        string user_id
        string full_name
        date birth_date
    }
    Fitness_data{
        int fitness_data_id
        int height
        int weight 
     
    }
    Feedback_data{
        int feedback_data_id
        int form_value
        int speed_value
        date date_recorded
        int sets
        int reps
        int dumbbell_weight
    }
    fitness_plan{
        int fitness_plan_id
        int weight_goal
        int num_days_to_workout
    }
    User {
        string user_id
        int currency
        date latest_login
        %% string apple_id
        %% enum account_type
        %% date registration_date
    }
    Apple{
        int apple_id
        string email
        string password
    }
    %% Account_type{
    %%     int account_type_id
    %%     string account_type 
    %% }
    Pet{
        int pet_id
        int level
        int health
    }
    Pet_image{
        int pet_image_id
        string pet_image_url
    }
    Inventory{
        int inventory_id
    }
    Food{
        int food_id
        string food_name
        string food_image_url
    }
    Background{
        int background_id
        string background_name
        string background_image_url
    }
    Pet_clothing{
        int pet_clothing_id
        int price 
        string pet_clothing_image
    }
   Achievement{
        int Achievement
        string achievement_name
        int total_progress
        string reward
    }
    User_Achievements{
        int achievement_id

         bool is_completed
        int progress_percentage
      
    }
    
```
As this is a NoSQL approach, there are some relations to where there are a one-to-many. This can be seen through something such as inventory. A user has one pet, which has one inventory, but an inventory can store multiple Food. 

```mermaid
erDiagram
 Pet{
        int pet_id
        int level
        int health
    }
 Inventory{
        int inventory_id
    }
    Food{
        int food_id
        string food_name
        string food_image_url
    }
  Pet ||--||Inventory: has
 Inventory ||--|{ Food: has 
```

## Firebase Database Design, Shop

This is a small section of the database. It is representative of the shop part of the application. The user does not manipulate this relevant data. It is used for the application to retrieve assets needed for the shop and to make loading assets with relevant values easier for development. The shop contains multiple *Assets* and assets can contain 0 or more KeywordTags to help for easier searching functionality in the application.

```mermaid
---
title: Shop
---

erDiagram
    
 
    Asset {
        asset_id INT 
        name STRING
        category STRING
        price INT
        image_URL STRING
        date DATE
    }
    KeywordTag{
        keyword_tag_id INT
        keyword STRING
    }
    Asset ||--o{ KeywordTag: has
```

## CoreData Database Design

The purpose of the CoreData database design is to be lightweight and to contain the information relevant to the machine learning that will take place to help provide relevant feedback for the user's workout. There are multiple sensor systems that will get measurement data.

```mermaid
---
title: CoreData Machine Learning 
---

erDiagram
    SensorSystem{
        sensor_ID INT
    }
    Measurement {
        measurement_id INT
        user_id INT
        speed FLOAT
        velocity FLOAT
        angle FLOAT
        dateTime DATETIME
    }
    Exercise {
        exercise_id INT
        name VARCHAR
        description VARCHAR
    }
    Form {
        form_id INT
        exercise_id INT
        technique VARCHAR
    }
    
    SensorSystem ||--o{ Measurement: has
    Measurement }|--|| Exercise : has
    Exercise ||--|| Form : has

```
