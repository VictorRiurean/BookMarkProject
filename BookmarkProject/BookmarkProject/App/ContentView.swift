//
//  ContentView.swift
//  BookmarkProject
//
//  Created by Victor on 25/08/2024.
//

import Models
import SwiftUI
import SwiftData


struct ContentView: View {
    
    // MARK: Environment
    
    @Environment(\.modelContext) private var modelContext
    
    
    // MARK: Query
    
    @Query private var learningAssets: [LearningAsset]
    
    
    // MARK: Body

    var body: some View {
        NavigationStack {
            List {
                ForEach(learningAssets, id: \.url) { asset in
                    Text(asset.title)
                }
                .onDelete(perform: deleteItems)
            }
        }
    }
    
    
    // MARK: Private methods

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(learningAssets[index])
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
        .modelContainer(for: LearningAsset.self, inMemory: true)
}
