`structure`

# Challenge
Struct which contains all the relevant attributes for a challenge

```swift
struct Challenge
```

### Initializers
```swift
init(id: UUID, title: String, description: String, currentProgress: Int, progressGoal: Int, reward: String)
```

### Instance Properties
```swift
var currentProgress: Int
var description: String
var id: UUID
var progressGoal: Int
var progressPercent: Double
var reward: String
var title: String
```

### Relationships
#### Conforms to
Swift.Identifiable, Swift.Sendable
