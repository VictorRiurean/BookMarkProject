//
//  BookmarkProjectApp.swift
//  BookmarkProject
//
//  Created by Victor on 25/08/2024.
//

import Models
import SwiftUI
import SwiftData


@main
struct BookmarkProjectApp: App {
    
    // MARK: Model container
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            LearningAsset.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    
    // MARK: Body

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
