//
//  Tab.swift
//  BookmarkProject
//
//  Created by Victor on 25/08/2024.
//

import SwiftUI


@MainActor
enum Tab: Int, Identifiable, CaseIterable {
    
    // MARK: Cases
    
    case home
    case favourites
    case settings
    
    
    // MARK: Public properties
    
    nonisolated var id: Int {
        rawValue
    }
    
    
    // MARK: ViewBuilder
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .home:
            Label("Home", systemImage: "house")
        case .favourites:
            Label("Favourites", systemImage: "star.fill")
        case .settings:
            Label("Settings", systemImage: "gear")
        }
    }
    
    @ViewBuilder
    func makeContentView() -> some View {
        switch self {
        case .home:
            HomeScreen()
        case .favourites:
            Text("Favourites")
        case .settings:
            SettingsScreen()
        }
    }
}
