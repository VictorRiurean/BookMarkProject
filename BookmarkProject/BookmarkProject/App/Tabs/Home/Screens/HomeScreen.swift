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
    
    // MARK: Screen state
    
    enum HomeScreenState {
        case list
        case noAssets
        case noSearchResults
    }
    
    
    // MARK: Environment
    
    @Environment(\.modelContext) private var modelContext
    @Environment(Theme.self) var theme
    
    
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
    
    private var state: HomeScreenState {
        if assets.isEmpty {
            .noAssets
        } else if filteredAssets.isEmpty {
            .noSearchResults
        } else {
            .list
        }
    }
    
    
    // MARK: Body
    
    var body: some View {
        NavigationStack(path: $routerPath.path) {
            Group {
                switch state {
                case .list:
                    listView
                case .noAssets:
                    noAssetsView
                case .noSearchResults:
                    noSearchResultsView
                }
            }
            .background(theme.primaryBackgroundColor)
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
    
    
    // MARK: Subviews
    
    private var listView: some View {
        List {
            ForEach(filteredAssets, id: \.self) { asset in
                HomeListRowView(asset: asset)
                    .frame(height: .xxxLarge)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
    }
    
    private var noAssetsView: some View {
        ContentUnavailableView(
            "You have assets saved.",
            systemImage: "tray",
            description: Text("Please create assets from the New Asset tab.")
        )
    }
    
    private var noSearchResultsView: some View {
        ContentUnavailableView(
            "No results for this query.",
            systemImage: "exclamationmark.magnifyingglass",
            description: Text("Please try a different search term.")
        )
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
