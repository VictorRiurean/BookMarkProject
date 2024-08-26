//
//  ThemePreviewView.swift
//
//
//  Created by Victor on 26/08/2024.
//

import SwiftUI


public struct ThemePreviewView: View {
    
    // MARK: Environment
    
    @Environment(Theme.self) private var theme
    @Environment(\.dismiss) var dismiss
    
    
    // MARK: Body
    
    public var body: some View {
        ScrollView {
            ForEach(availableColorsSets) { couple in
                HStack(spacing: .medium) {
                    ThemeBoxView(color: couple.light)
                    
                    ThemeBoxView(color: couple.dark)
                }
            }
        }
        .padding(.large)
        .frame(maxHeight: .infinity)
        .background(theme.primaryBackgroundColor)
        .navigationTitle("Theme preview")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // MARK: Lifecycle
    
    public init() {}
}


struct ThemeBoxView: View {
    
    // MARK: Environment
    
    @Environment(Theme.self) private var theme
    
    
    // MARK: State properties
    
    @State private var isSelected = false
    
    
    // MARK: Public properties
    
    var color: ColorSet
    
    
    // MARK: Body
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: .medium)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shadow(radius: .xxSmall, x: .xxSmall, y: .xSmall)
                .accessibilityHidden(true)
            
            VStack(spacing: .small) {
                Text(color.name.rawValue)
                    .foregroundColor(color.tintColor)
                    .font(.system(size: .large))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Design theme text preview")
                    .foregroundColor(color.labelColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(color.primaryBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: .small))
                
                Text("#tint #color")
                    .foregroundColor(color.tintColor)
                
                if isSelected {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .frame(width: .large, height: .large)
                            .foregroundColor(.green)
                    }
                } else {
                    HStack {
                        Spacer()
                        
                        Circle()
                            .strokeBorder(color.tintColor, lineWidth: .one)
                            .background(
                                Circle()
                                    .fill(color.primaryBackgroundColor)
                            )
                            .frame(width: .large, height: .large)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.secondaryBackgroundColor)
            .font(.system(size: .regular))
            .cornerRadius(.medium)
        }
        .onAppear {
            isSelected = theme.selectedSet.rawValue == color.name.rawValue
        }
        .onChange(of: theme.selectedSet) { _, newValue in
            isSelected = newValue.rawValue == color.name.rawValue
        }
        .onTapGesture {
            let currentScheme = theme.selectedScheme
            
            if color.scheme != currentScheme {
                theme.followSystemColorScheme = false
            }
            
            theme.applySet(set: color.name)
        }
    }
}

