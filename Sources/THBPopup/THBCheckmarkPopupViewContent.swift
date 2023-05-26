//
//  THBCheckmarkPopupViewContent.swift
//  WhenThing
//
//  Created by Evan Sunley James on 26/05/23.
//

import SwiftUI

struct THBCheckmarkPopupViewContent: View {
    
    @ObservedObject var configuration: THBPopupConfiguration
    var sourceViewId: String
    let namespace: Namespace.ID
    
    var body: some View {
        
        Image(systemName: "checkmark.circle.fill")
            .font(.system(size: 60))
            .bold()
            .foregroundColor(configuration.titleTextColor)
            .matchedGeometryEffect(id: sourceViewId, in: namespace, properties: .position)
            .foregroundStyle(.secondary)
    
    }
}
