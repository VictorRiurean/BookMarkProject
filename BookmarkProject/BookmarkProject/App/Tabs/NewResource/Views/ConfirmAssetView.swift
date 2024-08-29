//
//  ConfirmAssetView.swift
//  BookmarkProject
//
//  Created by Victor on 28/08/2024.
//

import DesignSystems
import Models
import SwiftData
import SwiftUI


struct ConfirmAssetView: View {
    
    // MARK: Constants
    
    private enum Constants {
        static let editorHeight: CGFloat = 150.0
        static let buttonHeight: CGFloat = 50.0
        static let buttonWidth: CGFloat = 100.0
    }
    
    
    // MARK: Environment
    
    @Environment(\.modelContext) var modelContext
    
    
    // MARK: Query
    
    @Query var assets: [LearningAsset]
    
    
    // MARK: State properties
    
    @Binding var selectedTab: Tab
    @Binding var parentAsset: LearningAsset?
    
    @State private var pendingAsset: LearningAsset
    @State private var tag = ""
    
    
    // MARK: Body
    
    var body: some View {
        Form {
            titleSection
            
            summarySection
            
            tagsSection
            
            saveButton
        }
    }
    
    
    // MARK: Subviews
    
    private var titleSection: some View {
        Section("Title:") {
            TextField(text: $pendingAsset.title) {
                Text("Title cannot be empty")
            }
        }
    }
    
    private var summarySection: some View {
        Section("Summary: *") {
            TextEditor(text: $pendingAsset.summary)
                .frame(height: Constants.editorHeight)
        }
    }
    
    private var tagsSection: some View {
        Section("Tags: *") {
            HStack {
                TextField("Enter tag", text: $tag)
                    .textInputAutocapitalization(.never)
                
                Button {
                    pendingAsset.tags.append(tag)
                    
                    tag = ""
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(tag.isEmpty || pendingAsset.tags.contains(tag))
            }
            
            if !pendingAsset.tags.isEmpty {
                TagHStackView(tags: $pendingAsset.tags)
            }
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
                .disabled(pendingAsset.title.isEmpty)
                
                Spacer()
            }
            
        }
        .listRowBackground(Color.clear)
    }
    
    
    // MARK: Lifecycle
    
    init(
        selectedTab: Binding<Tab>,
        parentAsset: Binding<LearningAsset?>,
        pendingAsset: LearningAsset
    ) {
        self._selectedTab = selectedTab
        self._parentAsset = parentAsset
        self._pendingAsset = State(wrappedValue: pendingAsset)
    }
    
    
    // MARK: Private methods
    
    private func createAsset() {
        modelContext.insert(pendingAsset)
        
        Task {
            try? await Task.sleep(for: .milliseconds(300))
        
            parentAsset = nil
            
            withAnimation {
                selectedTab = .home
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ConfirmAssetView(
        selectedTab: .constant(.home),
        parentAsset: .constant(nil),
        pendingAsset: LearningAsset.mockLearningAssets.first!
    )
}
