//
//  TagHStackView.swift
//  BookmarkProject
//
//  Created by Victor on 28/08/2024.
//

import SwiftUI


public struct TagHStackView: View {
    
    // MARK: Environment
    
    @Environment(Theme.self) var theme
    
    
    // MARK: State properties
    
    @Binding var tags: [String]
    
    
    // MARK: Body
    
    public var body: some View {
        HStack {
            if tags.count <= 5 {
                ForEach(tags, id: \.self) { tag in
                    TagView(tag: tag)
                }
            } else {
                ForEach(0 ..< 5) {
                    TagView(tag: tags[$0])
                        .frame(minWidth: .large)
                        /// We don't want to resize all of the tags if they don't all fit the container, so we give each subsequent
                        /// one a decreased layout priority, so that they resize from right to left.
                        .layoutPriority(0.99 - (Double($0) / 100.0))
                }
                
                Text("and \(tags.count - 5) more")
                    .padding(.xSmall)
                    .font(.scaledCaption)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(theme.tintColor)
                    .background(theme.secondaryBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: .xxSmall))
                    .layoutPriority(1)
            }
            
            Spacer()
        }
    }
    
    
    // MARK: Lifecycle
    
    public init(tags: Binding<[String]>) {
        self._tags = tags
    }
}


#Preview {
    TagHStackView(tags: .constant(["tag", "me", "please"]))
}
