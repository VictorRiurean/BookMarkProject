//
//  Item.swift
//  BookmarkProject
//
//  Created by Victor on 25/08/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
