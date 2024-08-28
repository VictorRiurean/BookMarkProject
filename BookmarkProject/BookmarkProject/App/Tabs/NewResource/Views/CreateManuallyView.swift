//
//  CreateManuallyView.swift
//  BookmarkProject
//
//  Created by Victor on 28/08/2024.
//

import DesignSystems
import Models
import SwiftData
import SwiftUI


@MainActor
public struct CreateManuallyView: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let editorHeight: CGFloat = 150.0
        static let buttonHeight: CGFloat = 50.0
        static let buttonWidth: CGFloat = 120.0
    }
    
    
    // MARK: Environment
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Environment(Theme.self) var theme
    
    
    // MARK: Query
    
    @Query var assets: [LearningAsset]
    
    
    // MARK: State properties
    
    @Binding var selectedTab: Tab
    
    @State private var title = ""
    @State private var url = ""
    @State private var type: LearningAssetType = .article
    @State private var content = ""
    @State private var html = ""
    @State private var tags: [String] = []
    @State private var tag = ""
    @State private var imageUrl = ""
    
    
    // MARK: Private properties
    
    private var saveButtonIsDisabled: Bool {
        let isTitleValid = !title.isEmpty
        let isUrlNil = URL(string: url) == nil
        let isUrlValid = !isUrlNil && !urlAlreadyExists
        
        return !(isTitleValid && isUrlValid)
    }
    
    private var urlAlreadyExists: Bool {
        assets.contains { $0.url == url }
    }
    
    
    // MARK: Body
    
    public var body: some View {
        Form {
            titleSection
            
            urlSection
            
            typeSection
            
            tagsSection
            
            imageUrlSection
            
            summarySection
            
            htmlSection
            
            saveButton
        }
    }
    
    
    // MARK: Subviews
    
    private var titleSection: some View {
        Section("Title:") {
            TextField(text: $title) {
                Text("Title cannot be empty")
            }
        }
    }
    
    private var urlSection: some View {
        Section("URL:") {
            TextField(text: $url) {
                Text("Please enter a valid URL")
            }
            .textInputAutocapitalization(.never)
            
            if urlAlreadyExists {
                Text("URL already exists")
                    .font(.scaledCallout)
                    .foregroundStyle(.red)
            }
        }
    }
    
    private var typeSection: some View {
        Section("Type:") {
            Picker("Select type", selection: $type) {
                ForEach(LearningAssetType.allCases, id: \.rawValue) { asset in
                    Text(asset.title)
                        .tag(asset)
                }
            }
            .pickerStyle(.menu)
        }
    }
    
    private var summarySection: some View {
        Section("Summary: *") {
            TextEditor(text: $content)
                .frame(height: Constants.editorHeight)
        }
    }
    
    private var htmlSection: some View {
        Section("HTML: *") {
            TextEditor(text: $html)
                .frame(height: Constants.editorHeight)
        }
    }
    
    private var tagsSection: some View {
        Section("Tags: *") {
            HStack {
                TextField("Enter tag", text: $tag)
                    .textInputAutocapitalization(.never)
                
                Button {
                    tags.append(tag)
                    
                    tag = ""
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(tag.isEmpty || tags.contains(tag))
            }
            
            if !tags.isEmpty {
                TagHStackView(tags: $tags)
            }
        }
    }
    
    private var imageUrlSection: some View {
        Section("Image URL: *") {
            TextField("Image URL:", text: $imageUrl)
                .textInputAutocapitalization(.never)
        }
    }
    
    private var saveButton: some View {
        Section {
            HStack {
                Spacer()
                
                Button {
                    createAsset()
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
    
    
    // MARK: Private methods
    
    private func createAsset() {
        let newAsset = LearningAsset(
            url: url,
            type: type,
            title: title,
            content: content,
            contentHtml: html,
            tags: tags,
            imageUrl: imageUrl
        )
        
        resetForm()
        
        modelContext.insert(newAsset)
        
        Task {
            try? await Task.sleep(for: .milliseconds(300))
            
            withAnimation {
                selectedTab = .home
            }
        }
    }
    
    private func resetForm() {
        url = ""
        type = .article
        title = ""
        content = ""
        html = ""
        tags = []
        imageUrl = ""
    }
}

// MARK: - Preview

#Preview {
    CreateManuallyView(selectedTab: .constant(.newResource))
        .environment(Theme.shared)
}

