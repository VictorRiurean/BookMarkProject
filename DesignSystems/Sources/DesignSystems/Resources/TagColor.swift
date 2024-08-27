//
//  TagColor.swift
//
//
//  Created by Victor on 27/08/2024.
//

import SwiftUI


enum TagColor: CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case indigo
    case violet

    var color: Color {
        switch self {
        case .red:
            Color.red
        case .orange:
            Color.orange
        case .yellow:
            Color.yellow
        case .green:
            Color.green
        case .blue:
            Color.blue
        case .indigo:
            Color(red: 75 / 255, green: 0 / 255, blue: 130 / 255)
        case .violet:
            Color(red: 138 / 255, green: 43 / 255, blue: 226 / 255)
        }
    }
    
    var contrastingColor: Color {
        switch self {
        case .red:
            return Color.cyan 
        case .orange:
            return Color.blue 
        case .yellow:
            return Color.purple 
        case .green:
            return Color(red: 255 / 255, green: 0 / 255, blue: 255 / 255)
        case .blue:
            return Color.orange 
        case .indigo:
            return Color(red: 255 / 255, green: 215 / 255, blue: 0 / 255) 
        case .violet:
            return Color.yellow 
        }
    }
}
