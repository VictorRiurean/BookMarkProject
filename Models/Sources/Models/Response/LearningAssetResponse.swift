//
//  LearningAssetResponse.swift
//
//
//  Created by Victor on 25/08/2024.
//

import Foundation


public struct LearningAssetResponse: Decodable {
    public let url: String
    public let type: LearningAssetType
    public var title: String
    public var content: String?
    public var tags: [String]
    public var imageUrl: String?
}
