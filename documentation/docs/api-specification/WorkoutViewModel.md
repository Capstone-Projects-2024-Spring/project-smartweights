
`Class`

# WorkoutViewModel

```
class WorkoutViewModel
```

Topics
 ### Initializers
```swift
init()
```

### Instance Properties
``` swift
var hours: Int
var inputtedReps: String
var inputtedSs: String
var inputtedWeights: String
var minutes: Int
var progress: Double
var progressInterval: Double
var seconds: Int
var timer: Timer?
```
### Instance Methods

```swift
func addProgress(data: Double)
// Function to add progress
func generateRandomNumber() -> Double
func resetProgress()
// Function to reset progress
func restartTimer()
// Function to restart timer
func startTimer()
// Function to start timer
func stopTimer()
// Function to stop timer
```

### Relationships
#### Conforms To

Combine.ObservableObject
