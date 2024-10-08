---
sidebar_position: 7
---

# Class Diagram

SmartWeights uses an MVVM architecture and the class diagrams reflect as such. 

## Architecture 
The SmartWeights application is made with SwiftUI and the visual elements are made through its views. The elements within the views vary, but all are relevant to some graphical component. Some contain buttons, images, or components that we are creating that are not part of the SwiftUI library such as the WorkoutGraph or Calendar. The methods in the views represent any sort of user interaction with the view. The method itself calls to its respective ViewModel to handle the functionality. ViewModels handle logic such as changing which view to redirect to, or update the current view with new data relevant to their reliant variables. The models are the classes that hold the data elements these views rely on.

Additionally, there are classes to connect to external systems being CloudKit and the Raspberry Pi Pico. These classes establish the connection between the application and system and allow the transfer of data between the two. These classes are used in the relevant views where it would be needed. For example: The virtual pet page would require the CloudKit related classes, and the workout page would require the Raspberry Pi related classes.



## Features of the SmartWeights App
The following class diagrams show the main sections that the user can interact with in the app and the logic that comes with it.

### App

The SmartWeightsApp class acts as the entry point for the application. Pages in the app contain a NavBar component.
``` mermaid 
classDiagram
 class SmartWeightsApp{
    + ContentView()
   }
   class NavBar{
        HomeButton
        Achievementbutton
        PetButton
        MiscButton
        navButtonPressed(button)
   
   }
   SmartWeightsApp o-- NavBar
```
### Login
The login page consists of a big image of a pet and the login button. The user would click on the login button which would then ask them to "Continue with Apple". This is done through Apple's OAuth services with Apple Login.
```mermaid

classDiagram 

    class LoginPage{
        logoImage
        loginButton
        loginButtonPressed()
    }

    class LoginPageVM{
        login()
    }
    class LoginPageM{
        LoginStatus: boolean
    }
    LoginPage o-- LoginPageVM
    LoginPageVM <-- LoginPageM

```

### Virtual Pet
The pet page consists of an image of the pet, their stats (hp, exp, lvl) and whatever they have equipped (accessories or clothes). There are some interactive features for the user that involve the pet such as changing their appearance, feeding their pets, and buying things for their pets. There is an inventory button, shop button, and a customize button within a hamburger menu. 
``` mermaid



classDiagram
 class VirtualPet{
    backgroundImage
    PetImage
    PetAccessory
    PetHealthBar
    PetLevelBar
    HamburgerMenuButton
    InventoryButton
    CustomizeButton
    ShopButton

    HamburgerButtonPressed()
    InventoryButtonPressed()
    CustomizeButtonPressed()
    ShopButtonPressed()
   }
   class VirtualPetVM{
        UpdatePet()
        InventoryShow()
        CustomizeShow()
        RedirectToShop()
    }
    class VirtualPetM{
        PetHealth : int
        PetLevel : int 
        Inventory : List [Item]
    }
    VirtualPet o-- VirtualPetVM
    VirtualPetVM <-- VirtualPetM
    
```


### Challenges
The challenges page consists of a list of several achievements that can be unlocked through the user by various tasks completed. Once any challenge/achievement is completed, the user can then reap their rewards through a click of a button. The users could also view their own progress of certain challenges as well to see how much closer they are to completing it.
``` mermaid

classDiagram
 class ChallengesList{
    challenges
    TabPicker
    ChallengesList
    tabPickerClicked()
    updateChallengesList()
   }
   class ChallengesTab{
    body:ChallengesList
   }
   class ChallengeRow{
    challenge: challenge
    ChallengeImage: Image
    ChallengeTitle: Text
    ChallengeDescription: Text
    ChallengeProgressText: Text
    ChallengeReward: Text
    ProgressBar: ProgressView
   }

     class ChallengesVM{
        fetchChallenges()
        onChallengesFetched()
        onError()
    }
    class ChallengesM{
        title: String
        description: String
        img: Image
        currentProgress: Int
        progressGoal: Int
        reward: String
        status: Bool
        progressPercent: Double
    }
    ChallengesList o-- ChallengesVM
    ChallengesVM <-- ChallengesM

    ChallengesList *-- ChallengeRow
    ChallengesList *-- ChallengesTab

```


### Pet Store
The pet store page consists of a bunch of items that can be bought with the user's hard-earned pet coins. With the pet coins, they can be achieved through rewards via challenges or completing workouts. Some of the items that can be bought within the pet store are things like food to restore hp for your pet, buy clothes/accessories to swag out your pet, new pets, and backgrounds.
``` mermaid

classDiagram

 class PetStore{
    ArrowButton
    MoneyImage
    SortButton
    TabButtons
    ItemButtons
    PurchaseButton
    %% CancelButton
    + sort()
    + tabPressed()
    + itemPressed()
    + previewItem()
    + purchasePressed()
    + backArrowPressed()
   }
     class PetStoreVM{
        purchase()
    }
    class PetStoreM{
        currency: int
        userPet: Pet
        pets: Array[Pet]
        backgrounds: Array[Background]
        accessories: Array[Accessories]
        food: Array[Food]   
    }

    class Item{
        name: String
        description: String
        price: int
        itemType: int
        imageName: String
    }
    class Pet{

    }
    class Background{

    }
    class Accessory{

    }
    class Food{

    }
    PetStore o-- PetStoreVM
    PetStoreVM <-- PetStoreM
    PetStoreM "1" o-- "*" Item
    Item <|-- Pet
    Item <|-- Background
    Item <|-- Accessory
    Item <|-- Food

```

### Profile
The profile page consists of the user's profile pic, name, level, pet, and their achievements. The user can edit the showcase of their achievements, change their name, height, weight, and share their profile. Sharing their profile would create a new image that has the user's hard-earned accolades on display to show  their friends.
``` mermaid 

classDiagram
 class Profile {
    profPic
    achPic1
    achPic2
    achPic3
    fullName
    level
    levelProgressBar
    editNameButton
    settingsButton
    ssButton
    pet
    +editNameButtonPressed()
    +ssButtonPressed()
    +achievementsButtonPressed()
    +settingsButtonPressed()
   }
     class ProfileVM{
        changeAchievments()
        editName()
        editHeight()
        editWeight()
        shareProfile()
    }
    class ProfileM{
        displayName: String
        lvl: int
        height: int
        weight: int
        pet: virtualPet
        challenges: Challenges

    }
    Profile o-- ProfileVM
    ProfileVM <-- ProfileM
```

### Settings
The settings page allows users to customize their notifications
``` mermaid 

classDiagram
 class Settings{
    notificationSlider
   
   }
 class SettingsVM{
        toggleNotifications()
   
    }
    class SettingsM{
        notificationsAllowed: boolean
      
    }
    Settings o--SettingsVM
SettingsVM <--SettingsM
```

### HomePage
The home page is where the user will usually go to or see first after they login successfully. There will be a video carousel of workout forms, there will be a tab to allow navigation through the app. 
``` mermaid 

classDiagram
class HomePage{
    welcomeHeader: String
    startWorkoutButton
    buttonCarousel
    videoCarousel
    +startWorkoutButtonPressed()
   }
   class HomePageButtonCarousel{
    button1
    button2
    button3

    +button1Pressed()
    +button2Pressed()
    +button3Pressed()
   }
    class HomePageVideoCarousel{
        header
        video1
        video2
        video3
        +video1Pressed()
        +video2Pressed()
        +video3Pressed()

   }
 class HomePageVideoCarouselVM{
        getVideo()
    }
    class HomePageVideoCarouselM{
        video : string
    }
    
    class HomePageVideoCarouselVMDBConnector{
        dbConnect()
        FetchData()
        PostData()
        DeleteData()
    }

    HomePageVideoCarouselVM <-- HomePageVideoCarouselM
    HomePageVideoCarouselVM <-- HomePageVideoCarouselVMDBConnector

    HomePage *-- HomePageButtonCarousel
    HomePage *-- HomePageVideoCarousel
```

### Workout
The workout page is where the user goes when they want to start working out or review their past feedback history. The user selects their workout and enters how many sets and reps they'll be doing in their desired workout. Once the user is ready to initiate their workout, they can either use a button or voice activation/recognition to start. While they are working out, after each set is completed the feedback will processed through an algorithm to detect whether their form is good or bad and the pet will give suggestions on how to fix their form. The data is received through sensors and raspberry pi's during the workout. There will also be graphs and past feedback histories that the user can access if they want to. The user should also be able to see the video carousel to have more insight on what correct form could look like.
``` mermaid 

classDiagram

  class WorkoutPage{
        header: String
        audioInputButton
        screenSelector
        screenDisplay

        +screenSelectorSelected()
        +audioInputButtonPressed()

    }
    class WorkoutPageScreenSelector{
        setsButton
        formButton
        +setsButtonPressed()
        +formButtonPressed()
    }
    class WorkoutPageSetsDisplay{
        weightInput
        setsInput
        setTracker
        graph
        insightDisplay
        +readWeightInput()
        +readSetsInput()
    }
    class WorkoutPageFormDisplay{
        virtualPetDisplay
        insightDisplay
        videoCarousel
    }
    
    class WorkoutPageSetTracker{
        header
        setTrackerDisplay
    }
    class WorkoutPageInsightDisplay{
        header
        insight
        +readWeightInput()
        +readSetsInput()
    }
    class WorkoutPageVideoCarousel{
        header
        video1
        video2
        video3
        +video1Pressed()
        +video2Pressed()
        +video3Pressed()

    }
     
    class WorkoutProgress{
        BackButton
        WorkoutSummaryHeader
        BackgroundColor
        Date
        PetImage
        form
        formMore
        velocity
        velocityMore
        achievementsEarned
        CurrencyEarned
        GraphHeader
        GraphOptions
        Graph
        OverallForm
        overallSpeed
        formMorePressed()
        velocityMorePressed()
        ChangeGraphPressed()

    }
    class Calendar {
        Title
        Date 

    }
    class WorkoutGraph{
        Chart
    }
   class WorkoutVM{
        StartPI()
        StartSiri()
        PostData()
    }
    class WorkoutM{

    }
      class WorkoutGraphVM{
        getFormData()
        getSpeedData()
    }
    class WorkoutGraphM{
        
    }
    class WorkoutData{
        Speed : int
        Form : int
    }

    WorkoutPage o--WorkoutVM
    WorkoutVM <-- WorkoutM
    WorkoutGraph o-- WorkoutGraphVM
    WorkoutGraphVM <-- WorkoutGraphM
    WorkoutGraphM o-- WorkoutData
    WorkoutGraphVM .. ProgressVM
    WorkoutPage *-- WorkoutPageScreenSelector
    WorkoutPageScreenSelector *-- WorkoutPageSetsDisplay
    WorkoutPageScreenSelector *-- WorkoutPageFormDisplay
    WorkoutPageSetsDisplay *-- WorkoutPageSetTracker
    WorkoutPageSetsDisplay *-- WorkoutPageInsightDisplay
    WorkoutPageFormDisplay *-- WorkoutPageInsightDisplay
    WorkoutPageFormDisplay *-- WorkoutPageVideoCarousel
    WorkoutProgress *-- WorkoutGraph
    WorkoutProgress *-- Calendar
    WorkoutPage o-- WorkoutProgress

```

## External Logic
The external logic contains the classes that connect to external systems being CloudKit and the Raspberry Pi Pico W.

### DB Management

The CloudKitManager class serves as the central manager for interacting with CloudKit. It provides methods for saving, fetching, and deleting records from the CloudKit databases. The other classes represent more specific uses for the DB and help facilitate the necessary parameters for the CloudKitManager to perform its operations.

``` mermaid 

classDiagram
    class CloudKitManager{
        + shared
        + container
        + publicDatabase
        + privateDatabase
        isSignedInToiCloud: Bool
        saveRecord()
        fetchRecord()
        deleteRecord()
    }
    class UserDB{
        createUser()
    }
    class InventoryDB{
        createInventory()
        fetchCurrency()
        updateCurrency()
    }
    class PetDB{
        fetchHealth()
        fetchLevel()
        updateHealth()
        updateLevel()
    }
    class AchievementDB{
        fetchAchievements()
        updateAchievements()
    }

    CloudKitManager o-- UserDB
    CloudKitManager o-- InventoryDB
    CloudKitManager o-- PetDB
    CloudKitManager o-- AchievementDB
```

#### Example Implementation
The Login view model will use the UserDB class in order to create a user with a successful login. The Virtual Pet view model will use the PetDB class to fetch the pet's health.
``` mermaid
classDiagram
    class LoginVM{

    }
    class UserDB{

    }
    LoginVM o-- UserDB

    class VirtualPetVM{

    }
    class PetDB{
        
    }

    VirtualPetVM o-- PetDB
```

### Bluetooth Low Energy Connector

This represents the class that is in the application that is used to connect to the Raspberry Pi Pico W. It establishes connections with multiple sensors and determines the central and peripheral systems. It contains an integer array of the data that is being received from the Picos.
``` mermaid 

classDiagram
    class BLEManager {
        - UUID
        - accelerations: [Int]
        centralManager()
        peripheral()
    }
```
#### Example Implementation

The Workout View Model requires the BLEManager class in order to get the data and use it.
``` mermaid
classDiagram
    class WorkoutVM{

    }
    class BLEManager{

    }

    WorkoutVM o-- BLEManager
```

### Raspberry Pi Pico W

The Raspberry Pi Pico W has its own classes in order to function. The Pico W runs on a continuous loop, which is represented as main. The classes represent the logic and data for the sensors that are attached to the Pico for reading and writing data in order for the Pico to send to the application via Bluetooth Low Energy (BLE)
IDK Which class is being used
``` mermaid
classDiagram

   
    class BLEAdvertisingPayload {
        +advertising_payload(limited_disc: bool, br_edr: bool, name: str, services: List[UUID], appearance: int): bytearray
        +decode_field(payload: bytearray, adv_type: int): List[bytearray]
        +decode_name(payload: bytearray): str
        +decode_services(payload: bytearray): List[UUID]
    }
    class MPU6050 {
        -address: int
        -i2c: machine.I2C
        +__init__(i2c: machine.I2C, address: int = 0x68): void
        +wake(): void
        +sl
        eep(): void
        +who_am_i(): int
        +read_temperature(): float
        +read_gyro_range(): int
        +write_gyro_range(range: int): void
        +read_gyro_data(): tuple[float, float, float]
        +read_accel_range(): int
        +write_accel_range(range: int): void
        +read_accel_data(): tuple[float, float, float]
        +read_lpf_range(): int
        +write_lpf_range(range: int): void
        +_translate_pair(high: int, low: int): int
        +_hex_to_index(range: int): int
        +_index_to_hex(index: int): int
    }
    class mpuData {
        -id: str
        -mpu: MPU6050
        +__init__(id: str): void
        +get_accel_data(): tuple
        +get_gyro_data(): tuple
        +hello(): void
    }
    class BLEAcceleration {
        -_mpu6050: mpuData
        -_ble: bluetooth.BLE
        -_handle_ax: int
        -_handle_ay: int
        -_handle_az: int
        -_handle_gx: int
        -_handle_gy: int
        -_handle_gz: int
        -_connections: set
        -_payload: bytearray
        +__init__(ble: bluetooth.BLE, id: str): void
        +_irq(event: int, data: Any): void
        +update_acceleration(notify: bool, indicate: bool): void
        +_advertise(interval_us: int): void
    }
    class main{

    }
    main <-- BLEAcceleration
    main <-- mpuData
    main <-- MPU6050
    main <-- BLEAdvertisingPayload
    ```
