//
//  LearningAssetDetailsScreen.swift
//
//
//  Created by Victor on 27/08/2024.
//

import DesignSystems
import Models
import SwiftUI


@MainActor
public struct LearningAssetDetailsScreen: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let imageSize: CGFloat = 150.0
        static let editorHeight: CGFloat = 300.0
        static let buttonHeight: CGFloat = 50.0
        static let buttonWidth: CGFloat = 120.0
    }
    
    
    // MARK: Environment
    
    @Environment(\.dismiss) var dismiss
    @Environment(Theme.self) var theme
    
    
    // MARK: State properties
    
    @Bindable public var asset: LearningAsset
    
    @State private var newTitle = ""
    @State private var newContent = ""
    
    
    // MARK: Private properties
    
    private var saveButtonIsDisabled: Bool {
        let invalidFormat = newTitle.isEmpty || newContent.isEmpty
        let noChanges = newTitle == asset.title && newContent == asset.summary
        
        return invalidFormat || noChanges
    }
    
    
    // MARK: Body
    
    public var body: some View {
        VStack(spacing: .regular) {
            thumbnail
            
            if let url = URL(string: asset.url) {
                Link(asset.url, destination: url)
            }
            
            Form {
                newTitleSection
                
                newSummarySection
                
                webViewSection
                
                saveButton
            }
            .scrollContentBackground(.hidden)
        }
        .background(theme.primaryBackgroundColor)
        .onAppear {
            newTitle = asset.title
            newContent = asset.summary
        }
    }
    
    
    // MARK: Subviews
    
    private var thumbnail: some View {
        HStack {
            Spacer()
            
            AssetThumbnailView(
                urlString: asset.imageUrl,
                size: Constants.imageSize
            )
            
            Spacer()
        }
        .listRowBackground(Color.clear)
    }
    
    private var newTitleSection: some View {
        Section("Title:") {
            TextField(text: $newTitle) {
                Text("Title cannot be empty")
            }
        }
    }
    
    private var newSummarySection: some View {
        Section("Summary:") {
            TextEditor(text: $asset.summary)
                .frame(height: Constants.editorHeight)
        }
    }
    
    @ViewBuilder
    private var webViewSection: some View {
        if let url = URL(string: asset.url) {
            Section("WebView:") {
                WebViewRepresentable(url: url)
                    .frame(height: Constants.editorHeight)
            }
        }
    }
    
    private var saveButton: some View {
        Section {
            HStack {
                Spacer()
                
                Button {
                    asset.title = newTitle
                    asset.summary = newContent
                    
                    dismiss()
                } label: {
                    Text("Save")
                }
                .primaryStyle()
                .frame(
                    width: Constants.buttonWidth,
                    height: Constants.buttonHeight,
                    alignment: .center
                )
                .disabled(saveButtonIsDisabled)
                
                Spacer()
            }
            
        }
        .listRowBackground(Color.clear)
    }
    
    
    // MARK: Lifecycle
    
    public init(asset: LearningAsset) {
        self.asset = asset
    }
}
