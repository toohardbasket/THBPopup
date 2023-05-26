//
//  File.swift
//  
//
//  Created by Evan Sunley James on 26/05/23.
//

import SwiftUI

public class THBPopupConfiguration: ObservableObject {
    
    public static let `default` = THBPopupConfiguration()
    
    public var titleTextColor: Color = .black
    public var dismissalDelay: Double = 2
    public var backgroundStyle: (any ShapeStyle)? = .ultraThinMaterial
}
