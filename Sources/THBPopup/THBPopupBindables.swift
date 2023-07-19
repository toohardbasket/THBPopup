//
//  File.swift
//  
//
//  Created by Evan Sunley James on 26/05/23.
//

import SwiftUI

/// An observable class that can be used to pass bindings around so that different views in your app can use the same popup view.
/// For example if you want to show the same confirmation feedback from various actions, you can set up a popup view on the root view, then trigger it using the bindings here
public class THBPopupBindables: ObservableObject {
    
    @Published public var popupShouldTransition: Bool
    @Published public var popupSourceViewID: String?
    public var namespace: Namespace.ID
    
    public init(popupShouldTransition: Bool, popupSourceViewID: String? = nil, namespace: Namespace.ID) {
        self.popupShouldTransition = popupShouldTransition
        self.popupSourceViewID = popupSourceViewID
        self.namespace = namespace
    }
}
