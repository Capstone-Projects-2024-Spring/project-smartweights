`Class`

# GameCenterManager
GameCenterManager class to integrate Game Center into the application.

```swift
class GameCenterManager
```
## Topics

### Classes
```swift
class GameCenterDelegate // GameCenterDelegate class for loading Game Center UI into game.
```

### Structures
```swift
struct GameCenterConstants
```

### Instance Properties
```swift
var isAuthenticated: Bool
```

### Instance Methods
```swift
func authenticateLocalPlayer() // GameCenterManager class function to authenticate.
func checkAchievementCompletion(identifier: String) // GameCenterManager class function to check if an achievement is completed.
func fetchAllAchievementsProgress(completion: ([String : Double]?, Error?) -> Void) // GameCenterManager class function that fetches all achievements and their completion percentages.
func reportAchievement(challenge: Challenge) // GameCenterManager class function to report achievement.
func showGameCenterAchievements() // GameCenterManager class function to display Game Center.
func updateAchievement(identifier: String, progressToAdd: Double) // GameCenterManager class function to update achievement progress.
```

### Type Properties
```swift
static let shared: GameCenterManager
```

### Relationships
### Inherits From

ObjectiveC.NSObject

### Conforms To

Combine.ObservableObject

ObjectiveC.NSObjectProtocol

Swift.CVarArg

Swift.CustomDebugStringConvertible

Swift.CustomStringConvertible

Swift.Equatable

Swift.Hashable
