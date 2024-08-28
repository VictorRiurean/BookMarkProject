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
        case .course:
            Image(systemName: "graduationcap.fill")
        case .podcast:
            Image(systemName: "mic")
        case .stackOverflow:
            Image(systemName: "square.stack.3d.up.fill")
        case .video:
            Image(systemName: "play.circle")
        case .other:
            Image(systemName: "ellipsis")
        }
    }
}
