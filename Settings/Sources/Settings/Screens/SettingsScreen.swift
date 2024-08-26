//
//  SettingsView.swift
//  BookmarkProject
//
//  Created by Victor on 26/08/2024.
//

import DesignSystems
import Environment
import Observation
import SwiftUI


@MainActor @Observable
class DisplaySettingsLocalValues {
    var tintColor = Theme.shared.tintColor
    var primaryBackgroundColor = Theme.shared.primaryBackgroundColor
    var secondaryBackgroundColor = Theme.shared.secondaryBackgroundColor
    var labelColor = Theme.shared.labelColor
    var lineSpacing = Theme.shared.lineSpacing
    var fontSizeScale = Theme.shared.fontSizeScale
}


@MainActor
public struct SettingsScreen: View {
    
    typealias FontState = Theme.FontState
    
    
    // MARK: Environment
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(Theme.self) private var theme
    @Environment(UserPreferences.self) private var userPreferences
    
    
    // MARK: State properties
    
    @State private var localValues = DisplaySettingsLocalValues()
    @State private var routerPath = RouterPath()
    @State private var isFontSelectorPresented = false
   
    
    // MARK: Body
    
    public var body: some View {
        NavigationStack(path: $routerPath.path) {
            ZStack(alignment: .top) {
                Form {
                    selectionPreview
                    
                    themeSection
                    
                    fontSection
                    
                    resetSection
                }
                .navigationTitle("Settings")
                .scrollContentBackground(.hidden)
                .background(theme.secondaryBackgroundColor)
                .navigationDestination(
                    isPresented: $isFontSelectorPresented,
                    destination: {
                        FontPicker()
                    }
                )
                .task(id: localValues.tintColor) {
                    try? await Task.sleep(for: .microseconds(500))
                    
                    theme.tintColor = localValues.tintColor
                }
                .task(id: localValues.primaryBackgroundColor) {
                    try? await Task.sleep(for: .microseconds(500))
                    
                    theme.primaryBackgroundColor = localValues.primaryBackgroundColor
                }
                .task(id: localValues.secondaryBackgroundColor) {
                    try? await Task.sleep(for: .microseconds(500))
                    
                    theme.secondaryBackgroundColor = localValues.secondaryBackgroundColor
                }
                .task(id: localValues.labelColor) {
                    try? await Task.sleep(for: .microseconds(500))
                    
                    theme.labelColor = localValues.labelColor
                }
                .task(id: localValues.lineSpacing) {
                    try? await Task.sleep(for: .microseconds(500))
                    
                    theme.lineSpacing = localValues.lineSpacing
                }
                .task(id: localValues.fontSizeScale) {
                    try? await Task.sleep(for: .microseconds(500))
                    
                    theme.fontSizeScale = localValues.fontSizeScale
                }
            }
        }
    }
    
    
    // MARK: Lifecycke
    
    public init() { }
    
    
    // MARK: Subviews
    
    private var selectionPreview: some View {
        Section("Preview") {
            Text("This is a preview of the currently selected settings.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.large)
                .cornerRadius(.small)
                .background(theme.primaryBackgroundColor)
                .padding(.horizontal, .large)
                .padding(.vertical, .large)
                .background(theme.secondaryBackgroundColor)
                .foregroundStyle(theme.labelColor)
                .font(.scaledBody)
                .lineSpacing(CGFloat(theme.lineSpacing))
        }
    }
    
    @ViewBuilder
    private var themeSection: some View {
        @Bindable var theme = theme
        
        Section {
            Toggle("Match system", isOn: $theme.followSystemColorScheme)
            
            themeSelectorButton
            
            Group {
                ColorPicker("Tint color", selection: $localValues.tintColor)
                
                ColorPicker("Background color", selection: $localValues.primaryBackgroundColor)
                
                ColorPicker("Secondary background color", selection: $localValues.secondaryBackgroundColor)
                
                ColorPicker("Text color", selection: $localValues.labelColor)
            }
            .disabled(theme.followSystemColorScheme)
            .opacity(theme.followSystemColorScheme ? 0.5 : 1.0)
            .onChange(of: theme.selectedSet) {
                localValues.tintColor = theme.tintColor
                localValues.primaryBackgroundColor = theme.primaryBackgroundColor
                localValues.secondaryBackgroundColor = theme.secondaryBackgroundColor
                localValues.labelColor = theme.labelColor
            }
        } header: {
            Text("Theme")
        } footer: {
            if theme.followSystemColorScheme {
                Text("Custom colors can only be set if match system color scheme is disabled")
            }
        }
        .listRowBackground(theme.primaryBackgroundColor)
    }
    
    private var fontSection: some View {
        Section("Font settings") {
            Picker(
                "Font",
                selection: .init(
                    get: { () -> FontState in
                        theme.chosenFontData != nil ? FontState.custom : FontState.system
                    },
                    set: { newValue in
                        switch newValue {
                        case .system:
                            theme.chosenFont = nil
                        case .custom:
                            isFontSelectorPresented = true
                        }
                    }
                )
            ) {
                ForEach(FontState.allCases, id: \.rawValue) { fontState in
                    Text(fontState.title).tag(fontState)
                }
            }
            
            VStack {
                Slider(
                    value: $localValues.fontSizeScale,
                    in: 0.5 ... 1.5,
                    step: 0.1
                )
                
                Text("Font scaling \(String(format: "%.1f", localValues.fontSizeScale))")
            }
            
            VStack {
                Slider(
                    value: $localValues.lineSpacing,
                    in: 0.4 ... 10.0,
                    step: 0.2
                )
                
                Text("Line spacing \(String(format: "%.1f", localValues.lineSpacing))")
            }
        }
        .listRowBackground(theme.primaryBackgroundColor)
    }
    
    private var resetSection: some View {
        Section {
            Button {
                theme.restoreDefault()
            } label: {
                Text("Restore")
            }
        }
        .listRowBackground(theme.primaryBackgroundColor)
    }
    
    private var themeSelectorButton: some View {
        NavigationLink(destination: ThemePreviewView()) {
            HStack {
                Text("Theme")
                
                Spacer()
                
                Text(theme.selectedSet.rawValue)
            }
        }
    }
}

