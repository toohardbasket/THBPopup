# THBPopup

A simple hero-transition style overlay view for SwiftUI.

## Requirements

- iOS 16+.

As yet untested with other platforms, but does work with iOS17 beta.

## Usage

Place a `THBPopupView` as the top item in a ZStack. Control its presentation with the `shouldTransition` binding. The `sourceViewId` is the ID of the presenting view. You don't have to use this, but the hero transition won't work otherwise. 

Configure the view with a `THBPopupConfiguration`. Currently this only has two parameters - the dismissal delay, and the background.

### Dismissal

The default dismissal delay is 2 seconds, you can override this to any value. To allow the view to stay up indefinitely, set the delay to 0, then include some functionality in your presented content to toggle the value of `shouldTransition` back.

### Background

The default background is `ultraThinMaterial`, you can override this with any ShapeStyle.

### Transition

THBPopup uses matchedGeometryEffect, as such to use it correctly you need to remove the source view from the layout as you trigger the transition, and reinsert it afterwards. If you don't, you will see the `Multiple inserted views in matched geometry group` error. The transition may still work, but nobody likes console warnings!

```
    ...
    @State private var sourceViewId: String = "demo-source-view-id"
    @State private var shouldTransition: Bool = false
    ...

    ZStack {
    
        ...
        
        if !shouldTransition {
            Button {
                withAnimation {
                    shouldTransition.toggle()
                }
            } label: {
                "DO THE THING!"
            }
            .matchedGeometryEffect(id: sourceViewId, in: privateNamespace, properties: .frame)
        }
        
        ...
    
        THBPopupView(configuration: THBPopupConfiguration(),
                     shouldTransition: $shouldTransition,
                     sourceViewId: $sourceViewId,
                     namespace: namespace,
                     content: { id, namespace in
                     
            <your popover content here...>
                     
        })
    }
```

## THBPopupBindables

This is a class that you can use to pass around bindings so that you can trigger a `THBPopupView` declared in a parent view from child views.
I use this in order to trigger a confirmation feedback (a little checkmark) to transition from different sources in the view hierarchy (a button in one view, a menu in another, etc.). When triggering the transition, set the `sourceViewId` to the source, and then change the wrapped value of `shouldTransition`.

## THBCheckmarkPopupView

This is a convenience view, included so that you can use the checkmark confirmation mentioned above.

## Contribution

Contributions are welcome - make a suggestions or open a PR. I can't promise to be prompt in responding, but I will try!
