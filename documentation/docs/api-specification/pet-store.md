Structure

PetStore
=============================
Display view for the Pet Store depending on available items and prices.

struct PetStore

Topics
==========
**Initializers**

init()

**Instance Properties**


var body: some View

let categories: [String]

---
Structure

SellingItem
=============================
SellingItem struct that contains essential item attributes.

struct SellingItem

Topics
=============================
**Initializers**

init(id: Int, name: String, category: String, price: String, image: Image, description: String)

**Instance Properties**

var category: String

var description: String

var id: Int

var image: Image

var name: String

var price: String

---
Structure

ItemDetailView
=============================
Display view for previewing and purchasing and item.

struct ItemDetailView

Topics
=============================
**Initializers**

init(item: SellingItem, userCur: Int)

**Instance Properties**

var body: some View

let item: SellingItem

let userCur: Int
