//
//  File.swift
//  WhenThing
//
//  Created by Evan Sunley James on 26/05/23.
//

import SwiftUI


/// Usage:
///
///
/// Add: ```@State private var popupShouldTransition = false
/// @State var popupSourceViewId: String?
/// @Namespace var namespace```
/// to the root view.
/// Stick `PopupView(shouldTransition: $popupShouldTransition, sourceViewId: $popupSourceViewId, namespace: namespace)` in a ZStack with the rest of the view content.
/// Pass those state vars as binding to any child views that need to use them.
///
///
///
/// Problems:
/// `Multiple inserted views in matched geometry group Pair<String, ID>(first: "add-event.toolbar", second: SwiftUI.Namespace.ID(id: 100)) have `isSource: true`, results are undefined.
/// When I fix this by either making sure one of the views is isSouce=false, or that one is always not inserted, the animation doesn't work properly`
///

extension View {
    @ViewBuilder func `ifBackgroundMaterialExists`<Content: View>(_ optional: (any ShapeStyle)?, modifier: (Self, Material) -> Content) -> some View {
        if let unwrapped = optional as? Material {
            modifier(self, unwrapped)
        }
        else {
            self
        }
    }
}

enum THBPopupStyle {
    case checkmark(sourceViewId: String, namespace: Namespace.ID)
}

public struct THBPopupView: View {
    
    @EnvironmentObject var configuration: THBPopupConfiguration

    var shouldTransition: Binding<Bool>
    var sourceViewId: Binding<String?>
    let namespace: Namespace.ID
    
    public init(shouldTransition: Binding<Bool>, sourceViewId: Binding<String?>, namespace: Namespace.ID) {
        self.shouldTransition = shouldTransition
        self.sourceViewId = sourceViewId
        self.namespace = namespace
    }
    
    @ViewBuilder
    private func popupViewContent(style: THBPopupStyle) -> some View {
        switch style {
        case .checkmark(let sourceViewId, let namespace):
            THBCheckmarkPopupViewContent(sourceViewId: sourceViewId, namespace: namespace)
        }
    }
    
    public var body: some View {
        
        if shouldTransition.wrappedValue, let id = sourceViewId.wrappedValue {
            Color.clear.overlay(
                popupViewContent(style: .checkmark(sourceViewId: id, namespace: namespace))
                    .environmentObject(configuration)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + configuration.dismissalDelay) {
                            withAnimation {
                                shouldTransition.wrappedValue = false
                                sourceViewId.wrappedValue = nil
                            }
                        }
                    }
            )
            .ifBackgroundMaterialExists(configuration.backgroundStyle, modifier: { view, style in
                view.background(style)
            })
            .zIndex(3)
        }
    }
}
