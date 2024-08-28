//
//  Array+LearningAssetQuery.swift
//  BookmarkProject
//
//  Created by Victor on 28/08/2024.
//

import Foundation
import Models


extension Array where Element == LearningAsset {
    func apply(query: String) -> Array<Element> {
        self
            .filter {
                $0.title.localizedCaseInsensitiveContains(query) ||
                $0.summary.localizedCaseInsensitiveContains(query) ||
                $0.tags.first(where: { $0.contains(query) }) !=  nil
            }
    }
}
