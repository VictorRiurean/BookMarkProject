//
//  ColorSet.swift
//
//
//  Created by Victor on 26/08/2024.
//

import SwiftUI


public let availableColorsSets: [ColorSetCouple] = [
    .init(light: BPLight(), dark: BPDark()),
    .init(light: BPNeonLight(), dark: BPNeonDark()),
]


public protocol ColorSet: Sendable {
    var name: ColorSetName { get }
    var scheme: ColorScheme { get }
    var tintColor: Color { get set }
    var primaryBackgroundColor: Color { get set }
    var secondaryBackgroundColor: Color { get set }
    var labelColor: Color { get set }
}


public enum ColorScheme: String, Sendable {
    case dark, light
}


public enum ColorSetName: String, Sendable {
    case bpDark = "Dark"
    case bpLight = "Light"
    case bpNeonDark = "Dark Neon"
    case bpNeonLight = "Light Neon"
}

public struct ColorSetCouple: Identifiable, Sendable {
    public var id: String {
        dark.name.rawValue + light.name.rawValue
    }
    
    public let light: ColorSet
    public let dark: ColorSet
}

public struct BPDark: ColorSet {
    public var name: ColorSetName = .bpDark
    public var scheme: ColorScheme = .dark
    public var tintColor: Color = .init(red: 38 / 255, green: 166 / 255, blue: 154 / 255) // Neutral teal
    public var primaryBackgroundColor: Color = .init(red: 16 / 255, green: 21 / 255, blue: 35 / 255) // Deep dark blue-gray
    public var secondaryBackgroundColor: Color = .init(red: 30 / 255, green: 35 / 255, blue: 62 / 255) // Muted dark blue
    public var labelColor: Color = .white
    
    public init() {}
}


public struct BPLight: ColorSet {
    public var name: ColorSetName = .bpLight
    public var scheme: ColorScheme = .light
    public var tintColor: Color = .init(red: 34 / 255, green: 123 / 255, blue: 218 / 255) // A neutral blue
    public var primaryBackgroundColor: Color = .init(red: 245 / 255, green: 245 / 255, blue: 245 / 255) // Very light gray
    public var secondaryBackgroundColor: Color = .init(red: 230 / 255, green: 230 / 255, blue: 230 / 255) // Light gray
    public var labelColor: Color = .init(red: 50 / 255, green: 50 / 255, blue: 50 / 255) // Dark gray for readability
    
    public init() {}
}

public struct BPNeonDark: ColorSet {
    public var name: ColorSetName = .bpNeonDark
    public var scheme: ColorScheme = .dark
    public var tintColor: Color = .init(red: 255 / 255, green: 94 / 255, blue: 77 / 255) // Neon coral
    public var primaryBackgroundColor: Color = .init(red: 20 / 255, green: 20 / 255, blue: 30 / 255) // Deep dark blue
    public var secondaryBackgroundColor: Color = .init(red: 45 / 255, green: 45 / 255, blue: 65 / 255) // Muted dark gray-blue
    public var labelColor: Color = .white
    
    public init() {}
}


public struct BPNeonLight: ColorSet {
    public var name: ColorSetName = .bpNeonLight
    public var scheme: ColorScheme = .light
    public var tintColor: Color = .init(red: 72 / 255, green: 245 / 255, blue: 135 / 255) // Neon green
    public var primaryBackgroundColor: Color = .init(red: 240 / 255, green: 240 / 255, blue: 255 / 255) // Very light blue
    public var secondaryBackgroundColor: Color = .init(red: 220 / 255, green: 220 / 255, blue: 235 / 255) // Soft light gray-blue
    public var labelColor: Color = .init(red: 30 / 255, green: 30 / 255, blue: 30 / 255) // Dark gray
    
    public init() {}
}
