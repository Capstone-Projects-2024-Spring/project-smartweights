`Class`

# Exercise
A CoreData entity that stores data related to Exercises

```
@objc(Exercise)
class Exercise
```

### Instance Properties
```
var detail: String?
var exercise_id: Int16
var name: String?
```

### Type Methods
```
class func fetchRequest() -> NSFetchRequest<Exercise>
```

## Relationships

### Inherits From
`CoreData.NSManagedObject`

### Inherited By
`Form`

---

`Class`

# Form
A CoreData entity that stores data related to an Exercise Form

```
@objc(Form)
class Form
```

### Instance Properties
```
var form_id: Int16
var technique: String?
```

### Type Methods
```
class func fetchRequest() -> NSFetchRequest<Exercise>
```

## Relationships

### Inherits From
`Exercise`

---

`Class`

# Exercise
A CoreData entity that stores data related to Sensors e.g Altimeter, Barometer, and etc...

```
@objc(SensorSystem)
class SensorSYstem
```

### Instance Properties
```
var sensor_id: Int16
```

### Type Methods
```
class func fetchRequest() -> NSFetchRequest<Exercise>
```

## Relationships

### Inherits From
`CoreData.NSManagedObject`

### Inherited By
`Measurement`

---

`Class`

# Measurement
A CoreData entity that stores data related to data collected from the Sensors during a workout

```
@objc(Measurement)
class Measurement
```

### Instance Properties
```
var angle: Float
var dateTime: Date?
var measurement_id: Float
var speed: Float
var user_id: Int32
var velocity: Float
var x_coord: Float
var y_coord: Float
var z_coord: Float
```

### Type Methods
```
class func fetchRequest() -> NSFetchRequest<Exercise>
```

## Relationships

### Inherits From
`SensorSystem`

---

`Structure`

# PersistenceController
Defines a PersistenceController struct to manage the Core Data stack for the application

```
struct PersistenceController
```

### Initializers
```
init (inMemory: Bool)
```
Initializes a new PersistenceController. The inMemory flag determines whether the persistent store is stored in memory or on disk

### Instance Properties
```
let container: NSPersistentCloudKitContainer
```
The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it

### Type Properties
```
static var preview: PersistenceController
```
Creates a preview instance of PersistenceController for development and testing purposes. This in-memory version is populated with sample data to facilitate UI development and testing without affecting the actual database

```
static let shared: PersistenceController
```
Provides a shared instance of PersistenceController for use throughout the app

---
