//
//  LearningAsset.swift
//
//
//  Created by Victor on 25/08/2024.
//

import SwiftData


@Model
public class LearningAsset {
    public let url: String
    public let type: LearningAssetType
    public var title: String
    public var content: String?
    public var contentHtml: String?
    public var tags: [String]
    public var imageUrl: String?
    
    init(
        url: String,
        type: LearningAssetType,
        title: String,
        content: String? = nil,
        contentHtml: String? = nil,
        tags: [String] = [],
        imageUrl: String? = nil
    ) {
        self.url = url
        self.type = type
        self.title = title
        self.content = content
        self.contentHtml = contentHtml
        self.tags = tags
        self.imageUrl = imageUrl
    }
}


public enum LearningAssetType: Codable {
    case article
    case video
    case other(value: String)
}


extension LearningAsset {
    convenience init(response: LearningAssetResponse) {
        self.init(
            url: response.url,
            type: response.type,
            title: response.title,
            content: response.content,
            contentHtml: response.contentHtml,
            tags: response.tags,
            imageUrl: response.imageUrl
        )
    }
}
