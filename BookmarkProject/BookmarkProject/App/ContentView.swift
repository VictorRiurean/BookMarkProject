//
//  ContentView.swift
//  BookmarkProject
//
//  Created by Victor on 25/08/2024.
//

import DesignSystems
import Environment
import Models
import SwiftUI
import SwiftData


@MainActor
struct ContentView: View {
    
    // MARK: State properties
    
    @State private var selectedTab: Tab = .home
    @State private var theme = Theme.shared
    @State private var userPreferences = UserPreferences.shared
    
    
    // MARK: Body

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tab.allCases) { tab in
                tab
                    .makeContentView($selectedTab)
                    .tabItem {
                        tab.label
                    }
                    .tag(tab)
            }
        }
        .applyTheme(theme)
        .withEnvironments()
        .onAppear {
            if userPreferences.isFirstLaunch {
                userPreferences.isFirstLaunch = false
                
                selectedTab = .newAsset
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
