//
//  HomeScreenViewModel.swift
//  BookmarkProject
//
//  Created by Victor on 27/08/2024.
//

import AsyncAlgorithms
import Observation


@MainActor @Observable
final class HomeScreenViewModel {
    
    // MARK: Public properties
    
    private(set) var debouncedText = ""
    
    
    // MARK: Private properties
    
    private let searchTextChannel = AsyncChannel<String>()
    
    
    // MARK: Lifecycle
    
    init() {
        Task {
            await subscribeToSearchText()
        }
    }
    
    
    // MARK: Public methods
    
    func send(_ value: String) async {
        await searchTextChannel.send(value)
    }
    
    
    // MARK: Private methods
    
    func subscribeToSearchText() async {
        let strings = searchTextChannel
            .debounce(for: .milliseconds(300))
        
        for await string in strings {
            self.debouncedText = string
        }
    }
}
