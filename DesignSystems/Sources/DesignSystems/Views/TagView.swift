//
//  TagView.swift
//
//
//  Created by Victor on 27/08/2024.
//

import SwiftUI


public struct TagView: View {
    
    // MARK: Public properties
    
    public let tag: String
    
    
    // MARK: Body
    
    public var body: some View {
        let tagColor = TagColor.allCases.randomElement()!
        let backgroundColor = tagColor.color
        let fontColor = tagColor.contrastingColor
        
        Text("#\(tag)")
            .frame(height: .medium)
            .padding(.xSmall)
            .background(
                backgroundColor
                    .opacity(0.8)
            )
            .border(
                backgroundColor,
                width: .xxSmall
            )
            .clipShape(
                RoundedRectangle(cornerRadius: .xSmall)
            )
            .font(.scaledCaption)
            .foregroundStyle(fontColor)
    }
    
    
    // MARK: Lifecycle
    
    public init(tag: String) {
        self.tag = tag
    }
}

// MARK: - Preview

#Preview {
    TagView(tag: "exampleTag")
}
