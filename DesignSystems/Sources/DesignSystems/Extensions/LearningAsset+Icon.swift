//
//  File.swift
//  
//
//  Created by Victor on 27/08/2024.
//

import Models
import SwiftUI


extension LearningAssetType {
    var icon: Image {
        switch self {
        case .article:
            Image(systemName: "book.pages")
        case .video:
            Image(systemName: "play.circle")
        case .other:
            Image(systemName: "ellipsis")
        }
    }
}
