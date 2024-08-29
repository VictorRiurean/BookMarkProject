//
//  NewAssetScreen.swift
//  BookmarkProject
//
//  Created by Victor on 27/08/2024.
//

import DesignSystems
import Models
import SwiftUI


@MainActor
struct NewAssetScreen: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let pickerWidth: CGFloat = 150.0
    }
    
    
    // MARK: Environment
    
    @Environment(Theme.self) var theme
    
    
    // MARK: State properties
    
    @Binding var selectedTab: Tab
    
    @State private var viewModel = NewAssetViewModel()
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            VStack {
                modePicker
                
                if viewModel.isManualModeOn {
                    CreateManuallyView(selectedTab: $selectedTab)
                } else {
                    CreateAutomaticallyView(
                        selectedTab: $selectedTab,
                        generateAsset: { url in
                            try await viewModel.getAsset(with: url)
                        }
                    )
                }
            }
            .background(theme.primaryBackgroundColor)
            .navigationTitle("Create a new asset")
            .navigationBarTitleDisplayMode(.inline)
            .alert(
                "Failed to generate asset",
                isPresented: $viewModel.didFailToGenerate
            ) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
    
    // MARK: Subviews
    
    private var modePicker: some View {
        Picker("What is your favorite color?", selection: $viewModel.isManualModeOn) {
            Text("Manual")
                .tag(true)
                .accessibilityIdentifier("Manual button")
            
            Text("Auto")
                .tag(false)
                .accessibilityIdentifier("Auto button")
        }
        .pickerStyle(.segmented)
        .frame(width: Constants.pickerWidth)
        .padding(.medium)
    }
}


#Preview {
    NewAssetScreen(selectedTab: .constant(.newAsset))
}
