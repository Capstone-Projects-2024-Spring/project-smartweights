`Structure`

PetStore
=============================
Display view for the Pet Store, allowing users to interact and purchase a variety of items.

```swift
struct PetStore
```

Topics
==========
**Initializers**
```swift
init()

init(viewModel: storeViewModel)
```

**Instance Properties**

```swift
var body: some View

var viewModel: storeViewModel
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
init(id: Int, name: String, category: String, price: String, image: Image, description: String, isBought: Bool)
```

**Instance Properties**

```swift
var category: String

var description: String

var id: Int

var image: Image

var isBought: Bool

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
init(item: SellingItem, viewModel: storeViewModel, userCur: Int)
```

**Instance Properties**

```swift
var body: some View

let item: SellingItem

let userCur: Int

var viewModel: storeViewModel
```
