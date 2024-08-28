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
        let noChanges = newTitle == asset.title && newContent == asset.content
        
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
                
                newContentSection
                
                htmlSection
                
                saveButton
            }
        }
        .onAppear {
            newTitle = asset.title
            newContent = asset.content
        }
    }
    
    
    // MARK: Subviews
    
    private var thumbnail: some View {
        HStack {
            Spacer()
            
            AssetThumbnailView(urlString: asset.imageUrl)
                .frame(
                    width: Constants.imageSize,
                    height: Constants.imageSize
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
    
    private var newContentSection: some View {
        Section("Content:") {
            TextEditor(text: $asset.content)
                .frame(height: Constants.editorHeight)
        }
    }
    
    @ViewBuilder
    private var htmlSection: some View {
        if !asset.contentHtml.isEmpty {
            Section("HTML:") {
                HTMLView(htmlContent: asset.contentHtml)
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
                    asset.content = newContent
                    
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
