//
//  File.swift
//  
//
//  Created by Evan Sunley James on 26/05/23.
//

import SwiftUI

public class THBPopupConfiguration: ObservableObject {
        
    /// Set to 0 for dialogs
    public var dismissalDelay: Double = 2
    public var backgroundStyle: (any ShapeStyle)? = .ultraThinMaterial
    
    public init(dismissalDelay: Double = 2, backgroundStyle: (any ShapeStyle)? = .ultraThinMaterial) {
        self.dismissalDelay = dismissalDelay
        self.backgroundStyle = backgroundStyle
    }
}
