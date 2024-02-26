# Mobile Backend

This documents the ViewModels and Models usage in the app.

## ViewModel Classes
<details>
    <summary>
    Click to expand/collapse
    </summary>
<div style="height: 300px; overflow-y: scroll;">

## ViewModel 

All ViewModel methods are type void.

### Class LoginPageVM

#### Class Description

The `LoginPageVM` class handles the logic for the login page.

#### Methods

- `login()`
    - **Purpose:** Initiates the login process.

### Class NavBarVM

#### Class Description

The `NavBarVM` class manages navigation between different views.

#### Methods

- `viewChange()`
    - **Purpose:** Handles view navigation.

### Class VirtualPetVM

#### Class Description

The `VirtualPetVM` class controls interactions related to the virtual pet feature.

#### Methods

- `UpdatePet()`
    - **Purpose:** Updates the virtual pet.
- `InventoryShow()`
    - **Purpose:** Shows the pet's inventory.
- `CustomizeShow()`
    - **Purpose:** Shows customization options.
- `RedirectToShop()`
    - **Purpose:** Redirects to the pet store.

### Class ChallengesVM

#### Class Description

The `ChallengesVM` class manages challenges.

#### Methods

- `fetchChallenges()`
    - **Purpose:** Fetches challenges from the database.
- `onChallengesFetched()`
    - **Purpose:** Handles the retrieval of challenges.
- `onError()`
    - **Purpose:** Handles errors related to challenges.

### Class ProfileVM

#### Class Description

The `ProfileVM` class handles profile-related operations.

#### Methods

- `changeAchievements()`
    - **Purpose:** Manages achievements.
- `editName()`
    - **Purpose:** Edits the user's name.
- `editHeight()`
    - **Purpose:** Edits the user's height.
- `editWeight()`
    - **Purpose:** Edits the user's weight.
- `shareProfile()`
    - **Purpose:** Shares the user's profile.

### Class PetStoreVM

#### Class Description

The `PetStoreVM` class manages interactions with the pet store.

#### Methods

- `purchase()`
    - **Purpose:** Handles pet purchases.

### Class ProgressVM

#### Class Description

The `ProgressVM` class manages progress-related operations.

#### Methods

- `getForm()`
    - **Purpose:** Retrieves form data.
- `getVelocity()`
    - **Purpose:** Retrieves velocity data.
- `getAchievementsEarned()`
    - **Purpose:** Retrieves earned achievements.
- `getCurrencyEarned()`
    - **Purpose:** Retrieves earned currency.
- `getFeedback()`
    - **Purpose:** Retrieves feedback.

### Class CalendarVM

#### Class Description

The `CalendarVM` class handles calendar-related operations.

#### Methods

- `updateDate()`
    - **Purpose:** Updates the selected date.

### Class WorkoutVM

#### Class Description

The `WorkoutVM` class manages workout-related operations.

#### Methods

- `StartPI()`
    - **Purpose:** Initiates a workout using PI.
- `StartSiri()`
    - **Purpose:** Initiates a workout using Siri.
- `PostData()`
    - **Purpose:** Posts workout data.

### Class SettingsVM

#### Class Description

The `SettingsVM` class manages application settings.

#### Methods

- `toggleNotifications()`
    - **Purpose:** Toggles notifications.
- `toggleHealthKit()`
    - **Purpose:** Toggles HealthKit integration.

### Class HomePageButtonCarouselVM

#### Class Description

The `HomePageButtonCarouselVM` class manages button carousel navigation.

#### Methods

- `redirect(view)`
    - **Purpose:** Redirects to the specified view.

### Class WorkoutGraphVM

#### Class Description

The `WorkoutGraphVM` class handles workout graph-related operations.

#### Methods

- `getFormData()`
    - **Purpose:** Retrieves form data.
- `getSpeedData()`
    - **Purpose:** Retrieves speed data.

### Class HomePageVideoCarouselVM

#### Class Description

The `HomePageVideoCarouselVM` class manages video carousel operations.

#### Methods

- `getVideo()`
    - **Purpose:** Retrieves videos.
</div>
</details> 



## Model Classes
<details>

<summary>Click to expand/collapse</summary>
<div style="height: 300px; overflow-y: scroll;">


### Class LoginPageM

#### Class Description

The `LoginPageM` class represents the model for the login page.

#### Data Fields

- `LoginStatus`
    - **Purpose:** Indicates the login status.
    - **Type:** boolean

### Class VirtualPetM

#### Class Description

The `VirtualPetM` class represents the model for the virtual pet feature.

#### Data Fields

- `PetHealth`
    - **Purpose:** Represents the health of the pet.
    - **Type:** int
- `PetLevel`
    - **Purpose:** Represents the level of the pet.
    - **Type:** int
- `Inventory`
    - **Purpose:** Represents the inventory of the pet.
    - **Type:** List of Item

### Class ChallengesM

#### Class Description

The `ChallengesM` class represents the model for challenges.

#### Data Fields

- `title`
    - **Purpose:** Title of the challenge.
    - **Type:** String
- `description`
    - **Purpose:** Description of the challenge.
    - **Type:** String
- `img`
    - **Purpose:** Image associated with the challenge.
    - **Type:** Image
- `currentProgress`
    - **Purpose:** Current progress of the challenge.
    - **Type:** Int
- `progressGoal`
    - **Purpose:** Goal progress of the challenge.
    - **Type:** Int
- `reward`
    - **Purpose:** Reward for completing the challenge.
    - **Type:** String
- `status`
    - **Purpose:** Status of the challenge.
    - **Type:** Bool
- `progressPercent`
    - **Purpose:** Percentage progress of the challenge.
    - **Type:** Double

### Class ProfileM

#### Class Description

The `ProfileM` class represents the model for user profiles.

#### Data Fields

- `displayName`
    - **Purpose:** Display name of the user.
    - **Type:** String
- `lvl`
    - **Purpose:** Level of the user.
    - **Type:** int
- `height`
    - **Purpose:** Height of the user.
    - **Type:** int
- `weight`
    - **Purpose:** Weight of the user.
    - **Type:** int
- `pet`
    - **Purpose:** User's virtual pet.
    - **Type:** virtualPet
- `challenges`
    - **Purpose:** Challenges associated with the user.
    - **Type:** Challenges

### Class PetStoreM

#### Class Description

The `PetStoreM` class represents the model for the pet store.

#### Data Fields

- `currency`
    - **Purpose:** Currency of the user.
    - **Type:** int
- `userPet`
    - **Purpose:** User's pet.
    - **Type:** Pet
- `pets`
    - **Purpose:** Available pets in the store.
    - **Type:** Array of Pet
- `backgrounds`
    - **Purpose:** Available backgrounds in the store.
    - **Type:** Array of Background
- `accessories`
    - **Purpose:** Available accessories in the store.
    - **Type:** Array of Accessories
- `food`
    - **Purpose:** Available food items in the store.
    - **Type:** Array of Food

### Class ProgressM

#### Class Description

The `ProgressM` class represents the model for progress tracking.

#### Data Fields

- `form`
    - **Purpose:** Form data.
    - **Type:** int
- `velocity`
    - **Purpose:** Velocity data.
    - **Type:** int
- `achievementsEarned`
    - **Purpose:** Earned achievements.
    - **Type:** int
- `currencyEarned`
    - **Purpose:** Earned currency.
    - **Type:** int

### Class CalendarM

#### Class Description

The `CalendarM` class represents the model for the calendar feature.

#### Data Fields

- `SelectedDate`
    - **Purpose:** Selected date.
    - **Type:** DateTime

### Class WorkoutM

#### Class Description

The `WorkoutM` class represents the model for workout data.

#### Data Fields

(This class currently has no data fields.)

### Class SettingsM

#### Class Description

The `SettingsM` class represents the model for application settings.

#### Data Fields

- `notificationsAllowed`
    - **Purpose:** Indicates whether notifications are allowed.
    - **Type:** boolean
- `healthKitAllowed`
    - **Purpose:** Indicates whether HealthKit integration is allowed.
    - **Type:** boolean

### Class WorkoutGraphM

#### Class Description

The `WorkoutGraphM` class represents the model for workout graph data.

#### Data Fields

(This class currently has no data fields.)

### Class HomePageVideoCarouselM

#### Class Description

The `HomePageVideoCarouselM` class represents the model for videos displayed in the homepage video carousel.

#### Data Fields

- `video`
    - **Purpose:** URL of the video.
    - **Type:** string



</div>

</details>

