//
//  NewResourceScreen.swift
//  BookmarkProject
//
//  Created by Victor on 27/08/2024.
//

import Models
import SwiftUI


@MainActor
struct NewResourceScreen: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let pickerWidth: CGFloat = 150.0
    }
    
    
    // MARK: State properties
    
    @Binding var selectedTab: Tab
    
    @State private var viewModel = NewResourceViewModel()
    
    
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
            
            Text("Auto")
                .tag(false)
        }
        .pickerStyle(.segmented)
        .frame(width: Constants.pickerWidth)
        .padding(.medium)
    }
}


#Preview {
    NewResourceScreen(selectedTab: .constant(.newResource))
}
