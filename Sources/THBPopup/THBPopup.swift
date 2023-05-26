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

enum THBPopupStyle {
    case checkmark(sourceViewId: String, namespace: Namespace.ID)
}

public struct THBPopupView: View {
    
    @ObservedObject var configuration: THBPopupConfiguration

    var shouldTransition: Binding<Bool>
    var sourceViewId: Binding<String?>
    let namespace: Namespace.ID
    
    public init(configuration: THBPopupConfiguration, shouldTransition: Binding<Bool>, sourceViewId: Binding<String?>, namespace: Namespace.ID) {
        self.shouldTransition = shouldTransition
        self.sourceViewId = sourceViewId
        self.namespace = namespace
        self.configuration = configuration
    }
    
    @ViewBuilder
    private func popupViewContent(configuration: THBPopupConfiguration, style: THBPopupStyle) -> some View {
        switch style {
        case .checkmark(let sourceViewId, let namespace):
            THBCheckmarkPopupViewContent(configuration: configuration, sourceViewId: sourceViewId, namespace: namespace)
        }
    }
    
    public var body: some View {
        
        if shouldTransition.wrappedValue, let id = sourceViewId.wrappedValue {
            Color.clear.overlay(
                popupViewContent(configuration: configuration, style: .checkmark(sourceViewId: id, namespace: namespace))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                shouldTransition.wrappedValue = false
                                sourceViewId.wrappedValue = nil
                            }
                        }
                    }
            )
            .background(.ultraThinMaterial)
            .zIndex(3)
        }
    }
}
