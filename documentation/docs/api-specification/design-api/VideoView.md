`structure`

# VideoView
Embedded YouTube videos via WebKit library and UIViewRepresentable protocol.

```swift
struct VideoView
```

### Initializers
```swift
init(videoId: String)
```

### Instance Properties
```swift
let videoId: String
```

### Instance Methods
```swift
func makeUIView(context: Context) -> WKWebView
func updateUIView(WKWebView, context: Context)
```
