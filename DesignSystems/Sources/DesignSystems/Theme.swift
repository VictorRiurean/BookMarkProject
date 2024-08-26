//
//  Theme.swift
//
//
//  Created by Victor on 26/08/2024.
//

import SwiftUI


/**
 The `Theme` class is a singleton that manages the color scheme and font settings for the application. It allows for customizing the app's appearance by storing and retrieving user preferences such as color schemes, background colors, label colors, font size, and custom fonts.

 The class is designed to work with SwiftUI and leverages `@AppStorage` for persisting these settings across app launches. It also supports following the system's color scheme or using a custom theme chosen by the user.

 ### Key Features:
 - **Color Scheme Management:** Allows users to select and apply different color schemes (e.g., light, dark, neon).
 - **Persistent Storage:** Utilizes `@AppStorage` to store user preferences such as selected color scheme, font settings, and whether to follow the system's color scheme.
 - **Custom Font Support:** Provides functionality to apply a custom font throughout the app, with the ability to save and restore this setting.
 - **Singleton Pattern:** Ensures that there is a single instance of `Theme` managing the app's appearance, making it easily accessible and consistent across the app.
 - **Restoring Defaults:** Provides a method to restore the default theme settings, making it easy for users to revert to the original appearance.

 This class also includes a nested `ThemeStorage` class for handling the actual storage of these preferences, keeping the main `Theme` class focused on providing the public API for theme management.
 */

@MainActor @Observable
public final class Theme {
    
    // MARK: Storage
    
    @MainActor
    final class ThemeStorage {
        
        // MARK: Keys
        
        enum ThemeKey: String {
            case colorScheme
            case tint
            case label
            case primaryBackground
            case secondaryBackground
            case followSystemColorScheme
            case selectedScheme
            case selectedSet
            case lineSpacing
        }
        
        
        // MARK: Public properties
        
        @AppStorage("IS_PREVIOUSLY_SET") public var isThemePreviouslySet: Bool = false
        @AppStorage(ThemeKey.selectedScheme.rawValue) public var selectedScheme: ColorScheme = .dark
        @AppStorage(ThemeKey.selectedSet.rawValue) var storedSet: ColorSetName = .bpDark
        @AppStorage(ThemeKey.followSystemColorScheme.rawValue) public var followSystemColorScheme: Bool = true
        @AppStorage(ThemeKey.tint.rawValue) public var tintColor: Color = .black
        @AppStorage(ThemeKey.primaryBackground.rawValue) public var primaryBackgroundColor: Color = .white
        @AppStorage(ThemeKey.secondaryBackground.rawValue) public var secondaryBackgroundColor: Color = .gray
        @AppStorage(ThemeKey.label.rawValue) public var labelColor: Color = .black
        @AppStorage(ThemeKey.lineSpacing.rawValue) public var lineSpacing: Double = .defaultLineSpacing
        @AppStorage("FONT_SIZE_SCALE") public var fontSizeScale: Double = .one
        @AppStorage("CHOSEN_FONT") public var chosenFontData: Data?
        
        
        // MARK: Lifecycle
        
        init() {}
    }
    
    
    // MARK: FontState
    
    public enum FontState: Int, CaseIterable {
        case system
        case custom
        
        public var title: LocalizedStringKey {
            switch self {
            case .system:
                "System font"
            case .custom:
                "Custom font"
            }
        }
    }
    
    
    // MARK: Static properties
    
    public static let shared = Theme()
    
    public static var allColorSet: [ColorSet] {
        [
            BPDark(),
            BPLight(),
            BPNeonDark(),
            BPNeonLight()
        ]
    }
    
    
    // MARK: Internal properties
    
    let themeStorage = ThemeStorage()
    
    
    // MARK: Public properties
    
    public var isThemePreviouslySet: Bool {
        didSet {
            themeStorage.isThemePreviouslySet = isThemePreviouslySet
        }
    }
    
    public var selectedScheme: ColorScheme {
        didSet {
            themeStorage.selectedScheme = selectedScheme
        }
    }
    
    public var followSystemColorScheme: Bool {
        didSet {
            themeStorage.followSystemColorScheme = followSystemColorScheme
        }
    }
    
    public var tintColor: Color {
        didSet {
            themeStorage.tintColor = tintColor
        }
    }
    
    public var primaryBackgroundColor: Color {
        didSet {
            themeStorage.primaryBackgroundColor = primaryBackgroundColor
        }
    }
    
    public var secondaryBackgroundColor: Color {
        didSet {
            themeStorage.secondaryBackgroundColor = secondaryBackgroundColor
        }
    }
    
    public var labelColor: Color {
        didSet {
            themeStorage.labelColor = labelColor
        }
    }
    
    public var lineSpacing: Double {
        didSet {
            themeStorage.lineSpacing = lineSpacing
        }
    }
    
    public var fontSizeScale: Double {
        didSet {
            themeStorage.fontSizeScale = fontSizeScale
        }
    }
    
    public private(set) var chosenFontData: Data? {
        didSet {
            themeStorage.chosenFontData = chosenFontData
        }
    }
    
    private var storedSet: ColorSetName {
        didSet {
            themeStorage.storedSet = storedSet
        }
    }
    
    public var selectedSet: ColorSetName = .bpDark
    
    public var chosenFont: UIFont? {
        get {
            if let _cachedChoosenFont {
                return _cachedChoosenFont
            }
            
            guard
                let chosenFontData,
                let font = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIFont.self, from: chosenFontData)
            else {
                return nil
            }
            
            _cachedChoosenFont = font
            
            return font
        }
        set {
            if let font = newValue,
               let data = try? NSKeyedArchiver.archivedData(withRootObject: font, requiringSecureCoding: false) {
                chosenFontData = data
            } else {
                chosenFontData = nil
            }
            
            _cachedChoosenFont = nil
        }
    }
    
    
    // MARK: Private properties
    
    private var _cachedChoosenFont: UIFont?
    
    
    // MARK: Lifecycle
    
    private init() {
        isThemePreviouslySet = themeStorage.isThemePreviouslySet
        selectedScheme = themeStorage.selectedScheme
        followSystemColorScheme = themeStorage.followSystemColorScheme
        tintColor = themeStorage.tintColor
        primaryBackgroundColor = themeStorage.primaryBackgroundColor
        secondaryBackgroundColor = themeStorage.secondaryBackgroundColor
        labelColor = themeStorage.labelColor
        lineSpacing = themeStorage.lineSpacing
        fontSizeScale = themeStorage.fontSizeScale
        chosenFontData = themeStorage.chosenFontData
        storedSet = themeStorage.storedSet
        selectedSet = storedSet
    }
    
    
    // MARK: Public methods
    
    public func restoreDefault() {
        applySet(set: themeStorage.selectedScheme == .dark ? .bpDark : .bpLight)
        
        isThemePreviouslySet = true
        followSystemColorScheme = true
        lineSpacing = .defaultLineSpacing
        fontSizeScale = .one
        chosenFontData = nil
        chosenFont = nil
        storedSet = selectedSet
    }
    
    public func applySet(set: ColorSetName) {
        selectedSet = set
        setColor(withName: set)
    }
    
    public func setColor(withName name: ColorSetName) {
        let colorSet = Theme.allColorSet.filter { $0.name == name }.first ?? BPDark()
        
        selectedScheme = colorSet.scheme
        tintColor = colorSet.tintColor
        primaryBackgroundColor = colorSet.primaryBackgroundColor
        secondaryBackgroundColor = colorSet.secondaryBackgroundColor
        labelColor = colorSet.labelColor
    }
}

