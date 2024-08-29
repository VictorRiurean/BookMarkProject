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
    public let size: CGFloat
    
    
    // MARK: Private properties
    
    private var url: URL? {
        urlString == nil ? nil : .init(string: urlString!)
    }
    
    
    // MARK: Body
    
    public var body: some View {
        Group {
            if let url {
                LazyImage(url: url)
                    .scaledToFill()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: size, height: size)
        .clipShape(
            RoundedRectangle(cornerRadius: cornerRadius)
        )
        .shadow(radius: .xSmall)
    }
    
    
    // MARK: Lifecycle
    
    public init(
        urlString: String?,
        cornerRadius: CGFloat = .small,
        size: CGFloat
    ) {
        self.urlString = urlString
        self.cornerRadius = cornerRadius
        self.size = size
    }
}

// MARK: - Preview

#Preview {
    VStack {
        AssetThumbnailView(
            urlString: "test",
            cornerRadius: .small,
            size: .xxLarge
        )
        
        AssetThumbnailView(
            urlString: "https://picsum.photos/200/300",
            cornerRadius: .small,
            size: .xxLarge
        )
    }
}
