//
//  PrimaryButtonStyle.swift
//
//
//  Created by Victor on 27/08/2024.
//

import SwiftUI


public struct PrimaryButtonStyle: ButtonStyle, @unchecked Sendable {
    
    // MARK: Environment
    
    @Environment(\.isEnabled) var isEnabled
    
    
    // MARK: State properties
    
    @Binding var isLoading: Bool
    
    
    // MARK: Lifecycle
    
    public init(_ isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .background(
                isEnabled ? .blue : .blue.opacity(0.2)
            )
            .foregroundStyle(
                .white
            )
            .clipShape(Capsule())
            .disabled(isLoading)
    }
}

extension Button {
    public func primaryStyle(_ isLoading: Binding<Bool> = .constant(false)) -> some View {
        self
            .buttonStyle(PrimaryButtonStyle(isLoading))
    }
}
