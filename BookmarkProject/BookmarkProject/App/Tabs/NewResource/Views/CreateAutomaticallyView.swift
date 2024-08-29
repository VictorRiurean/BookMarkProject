//
//  CreateAutomaticallyView.swift
//  BookmarkProject
//
//  Created by Victor on 28/08/2024.
//

import DesignSystems
import Models
import SwiftUI


@MainActor
struct CreateAutomaticallyView: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let buttonHeight: CGFloat = 50.0
        static let buttonWidth: CGFloat = 200.0
    }
    
    
    // MARK: Environment
    
    @Environment(Theme.self) var theme
    
    
    // MARK: State properties
    
    @Binding var selectedTab: Tab
    
    @State private var asset: LearningAsset?
    @State private var isPrimaryButtonLoading = false
    @State private var url = ""
    
    
    // MARK: Public properties
    
    let generateAsset: (String) async throws -> LearningAsset
    
    
    // MARK: Body
    
    var body: some View {
        Group {
            if let asset {
                ConfirmAssetView(
                    selectedTab: $selectedTab,
                    parentAsset: $asset,
                    pendingAsset: asset
                )
            } else {
                generateAssetView
            }
        }
    }
    
    
    // MARK: Subviews
    
    private var generateAssetView: some View {
        VStack(spacing: .large) {
            Spacer()
            
            urlTextField
            
            primaryButton
            
            Spacer()
        }
        .padding(.large)
    }
    
    private var urlTextField: some View {
        TextField("Enter URL", text: $url)
            .textInputAutocapitalization(.never)
            .padding(.medium)
            .border(theme.secondaryBackgroundColor, width: .xxSmall)
            .clipShape(RoundedRectangle(cornerRadius: .small))
    }
    
    private var primaryButton: some View {
        Button {
            Task {
                guard !isPrimaryButtonLoading else {
                    return
                }
                
                isPrimaryButtonLoading = true
                
                do {
                    asset = try await generateAsset(url)
                    
                    url = ""
                } catch { }
                
                isPrimaryButtonLoading = false
            }
        } label: {
            ZStack {
                Text("Generate asset")
                    .opacity(isPrimaryButtonLoading ? 0 : 1)
                
                if isPrimaryButtonLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                }
            }
        }
        .primaryStyle($isPrimaryButtonLoading)
        .disabled(url.isEmpty)
    }
}

// MARK: - Preview

#Preview {
    CreateAutomaticallyView(
        selectedTab: .constant(.home),
        generateAsset: { url in
            return LearningAsset.mockLearningAssets.first!
        }
    )
}
