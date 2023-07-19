//
//  File.swift
//  WhenThing
//
//  Created by Evan Sunley James on 26/05/23.
//

import SwiftUI



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

public struct THBPopupView<Content: View>: View {
        
    @EnvironmentObject var configuration: THBPopupConfiguration

    public var shouldTransition: Binding<Bool>
    public var sourceViewId: Binding<String?>
    public var namespace: Namespace.ID
    @ViewBuilder public var content: (String, Namespace.ID) -> Content
    
    public init(shouldTransition: Binding<Bool>, sourceViewId: Binding<String?>, namespace: Namespace.ID, @ViewBuilder content: @escaping (String, Namespace.ID) -> Content) {
        self.shouldTransition = shouldTransition
        self.sourceViewId = sourceViewId
        self.namespace = namespace
        self.content = content
    }

    public var body: some View {
        
        if shouldTransition.wrappedValue, let id = sourceViewId.wrappedValue {
            Color.clear.overlay(
                content(id, namespace)
                    .environmentObject(configuration)
                    .onAppear {
                        if configuration.dismissalDelay > 0 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + configuration.dismissalDelay) {
                                withAnimation {
                                    shouldTransition.wrappedValue = false
                                    sourceViewId.wrappedValue = nil
                                }
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
