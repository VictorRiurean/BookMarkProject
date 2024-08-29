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
    case newAsset
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
        case .newAsset:
            Label("New asset", systemImage: "hammer.fill")
        case .settings:
            Label("Settings", systemImage: "gear")
        }
    }
    
    @ViewBuilder
    func makeContentView(_ selectedTab: Binding<Tab>) -> some View {
        switch self {
        case .home:
            HomeScreen()
        case .newAsset:
            NewAssetScreen(selectedTab: selectedTab)
        case .settings:
            SettingsScreen()
        }
    }
}
