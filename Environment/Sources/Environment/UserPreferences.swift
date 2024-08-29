//
//  UserPreferences.swift
//
//
//  Created by Victor on 26/08/2024.
//

import SwiftUI


@MainActor @Observable
public class UserPreferences {
    
    // MARK: Storage
    
    class Storage {
        @AppStorage("isFirstLaunch") public var isFirstLaunch: Bool = true
    }
    
    
    // MARK: Singleton
    
    public static let sharedDefault = UserDefaults(suiteName: "group.com.riurean.bookmarkProject")
    public static let shared = UserPreferences()
    
    
    // MARK: Private properties
    
    private let storage = Storage()
    
    
    // MARK: Public properties
    
    public var isFirstLaunch: Bool {
        didSet {
            storage.isFirstLaunch = isFirstLaunch
        }
    }
    
    
    // MARK: Lifecycle
    
    private init() {
        isFirstLaunch = storage.isFirstLaunch
    }
}
