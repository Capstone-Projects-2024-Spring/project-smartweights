`Structure`

# Pet_page
A view that represents the pet page. This view displays the pet’s name, a hamburger menu for navigation, a custom image of the pet, health and level progress bars, and navigation links to the pet store, inventory, and customization views.

``` swift
struct Pet_page
```

### Initializers
```swift
init ()
```

### Instance Properties
```swift
var body: some View
```

---

`Structure`

# CustomProgressView
A custom progress view that displays the progress value and label.

```swift
struct CustomProgressView
```

### Initializers
```swift
init(value: Float, maxValue: Float, label: String, displayMode: CustomProgressView.DisplayMode, foregroundColor: Color, backgroundColor: Color)
```

### Instance Properties
```swift
var backgroundColor: Color
var body: some View
var displayMode: DisplayMode
var foregroundColor: Color
var label: String
var maxValue: Float
var value: Float
```
### Enumerations
```swift
enum DisplayMode
```
The display mode for the progress value and health bar.

---

`Structure`

# HamburgerMenu
A view representing a hamburger menu with options to navigate to different pages.

```swift
struct HamburgerMenu
```

### Initializers
```swift
init(navigateToShop: () -> Void, navigateToInventory: () -> Void, navigateToCustomize: () -> Void)
```

### Instance Properties
```swift
var body: some View
var navigateToCustomize: () -> Void
var navigateToInventory: () -> Void
var navigateToShop: () -> Void
```
