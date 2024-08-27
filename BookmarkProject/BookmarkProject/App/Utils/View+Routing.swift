//
//  View+Routing.swift
//  BookmarkProject
//
//  Created by Victor on 26/08/2024.
//

import DesignSystems
import Environment
import Models
import Home
import SwiftData
import SwiftUI


@MainActor
extension View {
    func withAppRouter() -> some View {
        navigationDestination(for: RouterDestination.self) { destination in
            switch destination {
            case .assetDetails(let asset):
                LearningAssetDetailsScreen(asset: asset)
            case .themePreview:
                ThemePreviewView()
                    .withEnvironments()
            }
        }
    }
    
    func withSheetDestinations(sheetDestinations: Binding<SheetDestination?>) -> some View {
        sheet(item: sheetDestinations) { destination in
            switch destination {
            case .fontPicker:
                FontPicker()
            }
        }
    }
    
    func withEnvironments() -> some View {
        environment(UserPreferences.shared)
            .environment(Theme.shared)
    }
}
