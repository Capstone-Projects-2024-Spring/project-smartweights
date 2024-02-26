`Structure`

PetStore
=============================
Display view for the Pet Store depending on available items and prices.

```swift
struct PetStore
```

Topics
==========
**Initializers**
```swift
init()
```

**Instance Properties**

```swift
var body: some View

let categories: [String]
```

---
`Structure`

SellingItem
=============================
SellingItem struct that contains essential item attributes.

```swift
struct SellingItem
```

Topics
=============================
**Initializers**

```swift
init(id: Int, name: String, category: String, price: String, image: Image, description: String)
```

**Instance Properties**

```swift
var category: String

var description: String

var id: Int

var image: Image

var name: String

var price: String
```

---
`Structure`

ItemDetailView
=============================
Display view for previewing and purchasing and item.

```swift
struct ItemDetailView
```

Topics
=============================
**Initializers**

```swift
init(item: SellingItem, userCur: Int)
```

**Instance Properties**

```swift
var body: some View

let item: SellingItem

let userCur: Int
```
