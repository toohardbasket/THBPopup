//
//  THBCheckmarkPopupViewContent.swift
//  WhenThing
//
//  Created by Evan Sunley James on 26/05/23.
//

import SwiftUI

public struct THBCheckmarkPopupView: View {
    
    public var sourceViewId: String
    public let namespace: Namespace.ID
    public var color: Color

    public init(sourceViewId: String, namespace: Namespace.ID, color: Color) {
        self.sourceViewId = sourceViewId
        self.namespace = namespace
        self.color = color
    }
    
    public var body: some View {
        
        Image(systemName: "checkmark.circle.fill")
            .font(.system(size: 60))
            .bold()
            .foregroundColor(color)
            .matchedGeometryEffect(id: sourceViewId, in: namespace, properties: .position)
            .foregroundStyle(.secondary)
    
    }
}
