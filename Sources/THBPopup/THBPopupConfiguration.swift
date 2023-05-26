//
//  File.swift
//  
//
//  Created by Evan Sunley James on 26/05/23.
//

import SwiftUI

public class THBPopupConfiguration: ObservableObject {
    
    var titleTextColor: Color = .black
    
    public init(titleTextColor: Color = .black) {
        self.titleTextColor = titleTextColor
    }
    
}
