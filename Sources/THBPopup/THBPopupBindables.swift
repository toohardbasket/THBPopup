//
//  File.swift
//  
//
//  Created by Evan Sunley James on 26/05/23.
//

import SwiftUI

public class THBPopupBindables: ObservableObject {
    
    @Published public var popupShouldTransition: Bool
    @Published public var popupSourceViewID: String?
    
    public init(popupShouldTransition: Bool, popupSourceViewID: String? = nil) {
        self.popupShouldTransition = popupShouldTransition
        self.popupSourceViewID = popupSourceViewID
    }
}
