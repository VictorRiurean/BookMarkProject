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
    
    
    // MARK: Lifecycle
    
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
    }
    
    public init() { }
}

extension Button {
    public func primaryStyle() -> some View {
        self
            .buttonStyle(PrimaryButtonStyle())
    }
}
