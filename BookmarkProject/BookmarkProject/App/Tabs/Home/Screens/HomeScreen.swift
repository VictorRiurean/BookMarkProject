//
//  HomeScreen.swift
//  BookmarkProject
//
//  Created by Victor on 27/08/2024.
//

import DesignSystems
import Environment
import Home
import Models
import SwiftData
import SwiftUI


@MainActor
struct HomeScreen: View {
    
    // MARK: Environment
    
    @Environment(\.modelContext) private var modelContext
    
    
    // MARK: Query
    
    @Query(sort: \LearningAsset.title) var assets: [LearningAsset]
    
    
    // MARK: State properties
    
    @State private var routerPath = RouterPath()
    @State private var searchText = ""
    @State private var viewModel = HomeScreenViewModel()
    
    
    // MARK: Private properties
    
    private var filteredAssets: [LearningAsset] {
        if viewModel.debouncedText.isEmpty {
            assets
        } else {
            assets
                .apply(query: viewModel.debouncedText)
        }
    }
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack(path: $routerPath.path) {
            List {
                ForEach(filteredAssets, id: \.self) { asset in
                    HomeListRowView(asset: asset)
                        .frame(height: .xxxLarge)
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .navigationTitle("Your assets")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search for asset")
            .withAppRouter()
            .environment(routerPath)
            .onChange(of: searchText) { _, newValue in
                Task {
                    await viewModel.send(newValue)
                }
            }
        }
    }
    
    
    // MARK: Private methods
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(assets[index])
            }
        }
    }
}


// MARK: - Preview

#Preview {
    HomeScreen()
        .modelContainer(for: LearningAsset.self, inMemory: true)
        .environment(RouterPath())
        .environment(Theme.shared)
}
