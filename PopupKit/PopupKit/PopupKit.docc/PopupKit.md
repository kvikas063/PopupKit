# ``PopupKit``

Popup class conforms to UIView, It is used to show alert kind of view to highlight some info


## Overview

Example Usage:

```swift
import PopupKit

let popup = Popup(with: "Popup Title", 
                  message: "Popup Message", 
                  dismissTitle: "Dismiss Button Title")
addSubview(popup)

```

```swiftui
import PopupKit

PopupView(with: "Popup Title", 
                  message: "Popup Message", 
                  dismissTitle: "Dismiss Button Title") {
    // Do something
}


```

> Note: Keep **Popup Title** in one line only.

## Topics

### Files

- ``Popup``
- ``PopupView``
