//
//  LearningAsset.swift
//
//
//  Created by Victor on 25/08/2024.
//

import SwiftData


@Model
public final class LearningAsset {
    public let url: String
    public let type: LearningAssetType
    public var title: String
    public var summary: String
    public var contentHtml: String
    public var tags: [String]
    public var imageUrl: String?
    
    public init(
        url: String,
        type: LearningAssetType,
        title: String,
        content: String = "",
        contentHtml: String = "",
        tags: [String] = [],
        imageUrl: String? = nil
    ) {
        self.url = url
        self.type = type
        self.title = title
        self.summary = content
        self.contentHtml = contentHtml
        self.tags = tags
        self.imageUrl = imageUrl
    }
}


public enum LearningAssetType: String, CaseIterable, Codable, Hashable {
    case article
    case course
    case podcast
    case stackOverflow
    case video
    case other
    
    public var title: String {
        if self == .stackOverflow {
            "StackOverflow"
        } else {
            rawValue.capitalized
        }
    }
}


extension LearningAsset {
    convenience init(response: LearningAssetResponse) {
        self.init(
            url: response.url,
            type: response.type,
            title: response.title,
            content: response.content ?? "",
            contentHtml: response.contentHtml ?? "",
            tags: response.tags,
            imageUrl: response.imageUrl
        )
    }
}

// MARK: - Mock

extension LearningAsset: @unchecked Sendable {
    public static let mockLearningAssets: [LearningAsset] = [
        LearningAsset(
            url: "https://www.example.com/swift-article",
            type: .article,
            title: "Mastering Swift Programming",
            content: "This article dives deep into advanced Swift programming techniques...",
            contentHtml: "<p>This article dives deep into <strong>advanced Swift programming techniques</strong>...</p>",
            tags: ["Swift", "Programming", "iOS"],
            imageUrl: "https://www.example.com/images/swift-article.jpg"
        ),
        LearningAsset(
            url: "https://www.example.com/swift-tutorial",
            type: .course,
            title: "Build Your First iOS App",
            content: "In this tutorial, you'll learn how to build your first iOS app using Swift and Xcode...",
            contentHtml: "<h1>Build Your First iOS App</h1><p>In this tutorial, you'll learn how to build your first iOS app using <em>Swift</em> and <em>Xcode</em>...</p>",
            tags: ["Swift", "iOS", "Xcode", "Beginner"],
            imageUrl: "https://www.example.com/images/ios-tutorial.jpg"
        ),
        LearningAsset(
            url: "https://www.example.com/swift-video",
            type: .video,
            title: "Understanding SwiftUI",
            content: "This video provides an in-depth overview of SwiftUI and its powerful UI framework...",
            tags: ["SwiftUI", "iOS", "Development"],
            imageUrl: "https://www.example.com/images/swiftui-video.jpg"
        ),
        LearningAsset(
            url: "https://www.example.com/swift-podcast",
            type: .podcast,
            title: "The Future of Swift",
            content: "In this podcast episode, experts discuss the future of Swift and its impact on the development community...",
            tags: ["Swift", "Podcast", "Development"]
        ),
        LearningAsset(
            url: "https://www.example.com/swift-course",
            type: .course,
            title: "Complete Swift Programming Course",
            contentHtml: "<h2>Course Overview</h2><p>This course covers everything from the basics to advanced topics in Swift programming...</p>",
            tags: ["Swift", "Course", "Programming", "Advanced"],
            imageUrl: "https://www.example.com/images/swift-course.jpg"
        )
    ]
}
