//
//  CustomButtonStyle.swift
//
//
//  Created by Victor on 27/08/2024.
//

import SwiftUI


public struct CustomButtonStyle: ButtonStyle, @unchecked Sendable {
    
    // MARK: Style
    
    public enum Style {
        case primary
        case destructive
    }
    
    
    // MARK: Environment
    
    @Environment(\.isEnabled) var isEnabled
    
    
    // MARK: State properties
    
    @Binding var isLoading: Bool
    
    
    // MARK: Public properties
    
    public var style: Style
    
    
    // MARK: Private properties
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            isEnabled ? .blue : .blue.opacity(0.2)
        case .destructive:
            isEnabled ? .red : .red.opacity(0.2)
        }
    }
    
    private var foregroundStyle: Color {
        switch style {
        case .primary:
            .white
        case .destructive:
            .white
        }
    }
    
    
    // MARK: Lifecycle
    
    public init(
        style: Style,
        _ isLoading: Binding<Bool>
    ) {
        self.style = style
        self._isLoading = isLoading
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .background(
                backgroundColor
            )
            .foregroundStyle(
                foregroundStyle
            )
            .clipShape(Capsule())
            .disabled(isLoading)
    }
}

// MARK: - Convenience modifiers

extension Button {
    public func primaryStyle(_ isLoading: Binding<Bool> = .constant(false)) -> some View {
        self
            .buttonStyle(
                CustomButtonStyle(
                    style: .primary,
                    isLoading
                )
            )
    }
}

extension Button {
    public func destructiveStyle(_ isLoading: Binding<Bool> = .constant(false)) -> some View {
        self
            .buttonStyle(
                CustomButtonStyle(
                    style: .destructive,
                    isLoading
                )
            )
    }
}
