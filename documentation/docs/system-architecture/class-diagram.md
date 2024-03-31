---
sidebar_position: 7
---

# Class Diagram

SmartWeights uses an MVVM architecture and the class diagrams reflect as such. The frontend represents the views and the backend represents the viewmodels and models. The following is separated in this manner. Every view has its own respective viewmodel.

## Front End
Our frontend is made with SwiftUI and the visual elements are made through its views. Views come from SwiftUI's View struct. The entry point into the application is through the SmartWeightsApp class. The elements within the views vary, but all are relevant to some graphical component. Some contain buttons, images, or components that we are creating that are not part of the SwiftUI library such as the WorkoutGraph or Calendar. The methods in the views represent any sort of user interaction with the view. The method itself calls to its respective ViewModel to handle the functionality. Many views are made up of the NavBar component and it allows users to view other key components. The NavBar is necessary in creating a simple but effective way for users to traverse the application.


## Backend 
The backend represents the ViewModel and Model portion of the architecture.
The ViewModels's tasks are to handle any type of logic related to the application. Some are simple such as changing which view to redirect to, or update the current view with new data relevant to their reliant variables. The models are the classes that hold the data elements these views rely on.
Additionally, there are classes to connect to external APIs these including: Firebase, SiriKit, AppleHealthKit. These classes establish the connection between the application and API and allow the transfer of data between the two.
There is also an API that connects to our hardware (Raspberry Pi Pico W). This API class establishes the connection and requests data from the PI. The PI has its own classes of data that it is sending to the application.





## Connected

### App
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
Text about login
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
``` mermaid 

classDiagram
 class Settings{
    notificationSlider
    connectHealthKitButton
   }
 class SettingsVM{
        toggleNotifications()
        toggleHealthKit()
    }
    class SettingsM{
        notificationsAllowed: boolean
        healthKitAllowed: boolean
    }
    Settings o--SettingsVM
SettingsVM <--SettingsM
```

### HomePage

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

### DB Management


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
``` mermaid
classDiagram
    class WorkoutVM{

    }
    class BLEManager{

    }

    WorkoutVM o-- BLEManager
```

## Raspberry Pi Pico W

MPU class is a driver https://github.com/micropython-IMU/micropython-mpu9150.git 
class vector3D is for imu inertial measurement unit drivers Authors Peter Hinch, Sebastian Plamauer

IDK Which class is being used
``` mermaid
classDiagram

    class BLEAccelCentral{
        UUID
        scan()
        read()
        connect()
        disconnect()
    }
    class BLEAccelPeripheral{
        get_data()
        update_data()
    }
    class MPU6050{

    }
    class Vector3D{
        vector
        calibrate()
        magnitude()
        inclination()
        elevation()
    }
```