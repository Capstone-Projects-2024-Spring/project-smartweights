---
sidebar_position: 7
---
# Class Diagram

SmartWeights uses an MVVM architecture and the class diagrams reflect as such. The frontend represents the views and the backend represents the viewmodels and models. The following is separated in this manner. Every view has its own respective viewmodel.

## Frontend

Our frontend is made with SwiftUI and the visual elements are made through its views. Views come from SwiftUI's View struct. The entry point into the application is through the SmartWeightsApp class.

```mermaid
---
title: FrontEnd
---


classDiagram 
   class SmartWeightsApp{
    + ContentView()
   }
   class LoginPage{
    logoImage
    loginButton
    loginButtonPressed()
   }
   
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
   class Settings{
    notificationSlider
    connectHealthKitButton
   }
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
     class NavBar{
    HomeButton
    Achievementbutton
    PetButton
    MiscButton
    navButtonPressed(button)
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
    
  

    SmartWeightsApp <-- Profile
    SmartWeightsApp <-- VirtualPet
    SmartWeightsApp <-- ChallengesList
    SmartWeightsApp <-- PetStore
    SmartWeightsApp <-- HomePage
    SmartWeightsApp <-- WorkoutPage
     
    SmartWeightsApp <-- LoginPage
    %% MainApp *-- NavBar
    
    %% NavBar --* Profile
    %% NavBar --* VirtualPet
    %% NavBar --* ChallengesList
    %% NavBar --* PetStore
    %% NavBar --* HomePage
    %% NavBar --* WorkoutPage
    %% NavBar --* WorkoutProgress
        Profile *-- NavBar
        VirtualPet *-- NavBar
        ChallengesList *-- NavBar
        PetStore *-- NavBar
        HomePage *-- NavBar
        WorkoutPage *-- NavBar
        WorkoutProgress *-- NavBar
    
    %% NavBar --o Profile
    %% NavBar --o VirtualPet
    %% NavBar --o ChallengesList
    %% NavBar --o PetStore
    %% NavBar --o HomePage
    %% NavBar --o WorkoutPage

    HomePage *-- HomePageButtonCarousel
    HomePage *-- HomePageVideoCarousel

    WorkoutPage *-- WorkoutPageScreenSelector
    WorkoutPageScreenSelector *-- WorkoutPageSetsDisplay
    WorkoutPageScreenSelector *-- WorkoutPageFormDisplay
    WorkoutPageSetsDisplay *-- WorkoutPageSetTracker
    WorkoutPageSetsDisplay *-- WorkoutPageInsightDisplay
    WorkoutPageFormDisplay *-- WorkoutPageInsightDisplay
    WorkoutPageFormDisplay *-- WorkoutPageVideoCarousel
    
    Profile *-- Settings
    
   
    ChallengesList *-- ChallengeRow
    ChallengesList *-- ChallengesTab
    

```
