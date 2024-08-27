//
//  AssetThumbnailView.swift
//
//
//  Created by Victor on 27/08/2024.
//

import NukeUI
import SwiftUI


@MainActor
public struct AssetThumbnailView: View {
    
    // MARK: Public properties
    
    public let urlString: String?
    public let cornerRadius: CGFloat
    
    
    // MARK: Private properties
    
    private var url: URL? {
        urlString == nil ? nil : .init(string: urlString!)
    }
    
    
    // MARK: Body
    
    public var body: some View {
        Group {
            if let url {
                LazyImage(url: url)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
        }
        .clipShape(
            RoundedRectangle(cornerRadius: cornerRadius)
        )
        .shadow(radius: .xSmall)
    }
    
    
    // MARK: Lifecycle
    
    public init(
        urlString: String?,
        cornerRadius: CGFloat = .small
    ) {
        self.urlString = urlString
        self.cornerRadius = cornerRadius
    }
}

// MARK: - Preview

#Preview {
    VStack {
        AssetThumbnailView(
            urlString: "test",
            cornerRadius: .small
        )
        
        AssetThumbnailView(
            urlString: "https://picsum.photos/200/300",
            cornerRadius: .small
        )
    }
}
