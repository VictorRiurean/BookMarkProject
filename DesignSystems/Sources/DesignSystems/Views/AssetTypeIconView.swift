//
//  File.swift
//  
//
//  Created by Victor on 27/08/2024.
//

import Models
import SwiftUI


public struct AssetTypeIconView: View {
    
    // MARK: Environment
    
    @Environment(Theme.self) var theme
    
    
    // MARK: Public properties
    
    public let assetType: LearningAssetType
    
    
    // MARK: Body
    
    public var body: some View {
        assetType.icon
            .font(.scaledTitle)
            .foregroundStyle(theme.tintColor)
    }
    
    
    // MARK: Lifecycle
    
    public init(assetType: LearningAssetType) {
        self.assetType = assetType
    }
}
