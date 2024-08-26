//
//  Font.swift
//
//
//  Created by Victor on 26/08/2024.
//

import Environment
import SwiftUI


@MainActor
public extension Font {
    
    // MARK: Sizes
    
    private static let title = 28.0
    private static let headline = 17.0
    private static let body = 17.0
    private static let callout = 16.0
    private static let subheadline = 15.0
    private static let footnote = 13.0
    private static let caption = 12.0
    
    
    // MARK: Static properties
    
    static var scaledTitle: Font {
        customFont(size: userScaledFontSize(baseSize: title), relativeTo: .title)
    }
    
    static var scaledHeadline: Font {
        customFont(size: userScaledFontSize(baseSize: headline), relativeTo: .headline).weight(.semibold)
    }
    
    static var scaledHeadlineFont: UIFont {
        customUIFont(size: userScaledFontSize(baseSize: headline))
    }
    
    static var scaledBodyFocused: Font {
        customFont(size: userScaledFontSize(baseSize: body + 2), relativeTo: .body)
    }
    
    static var scaledBodyFocusedFont: UIFont {
        customUIFont(size: userScaledFontSize(baseSize: body + 2))
    }
    
    static var scaledBody: Font {
        customFont(size: userScaledFontSize(baseSize: body), relativeTo: .body)
    }
    
    static var scaledBodyFont: UIFont {
        customUIFont(size: userScaledFontSize(baseSize: body))
    }
    
    static var scaledBodyUIFont: UIFont {
        customUIFont(size: userScaledFontSize(baseSize: body))
    }
    
    static var scaledCallout: Font {
        customFont(size: userScaledFontSize(baseSize: callout), relativeTo: .callout)
    }
    
    static var scaledCalloutFont: UIFont {
        customUIFont(size: userScaledFontSize(baseSize: body))
    }
    
    static var scaledSubheadline: Font {
        customFont(size: userScaledFontSize(baseSize: subheadline), relativeTo: .subheadline)
    }
    
    static var scaledSubheadlineFont: UIFont {
        customUIFont(size: userScaledFontSize(baseSize: subheadline))
    }
    
    static var scaledFootnote: Font {
        customFont(size: userScaledFontSize(baseSize: footnote), relativeTo: .footnote)
    }
    
    static var scaledFootnoteFont: UIFont {
        customUIFont(size: userScaledFontSize(baseSize: footnote))
    }
    
    static var scaledCaption: Font {
        customFont(size: userScaledFontSize(baseSize: caption), relativeTo: .caption)
    }
    
    static var scaledCaptionFont: UIFont {
        customUIFont(size: userScaledFontSize(baseSize: caption))
    }
    
    
    // MARK: Static methods
    
    private static func customFont(size: CGFloat, relativeTo textStyle: TextStyle) -> Font {
        if let chosenFont = Theme.shared.chosenFont {
            return .custom(chosenFont.fontName, size: size, relativeTo: textStyle)
        }
        
        return .system(size: size, design: .default)
    }
    
    private static func customUIFont(size: CGFloat) -> UIFont {
        if let chosenFont = Theme.shared.chosenFont {
            return chosenFont.withSize(size)
        }
        
        return .systemFont(ofSize: size)
    }
    
    private static func userScaledFontSize(baseSize: CGFloat) -> CGFloat {
        UIFontMetrics.default.scaledValue(for: baseSize * Theme.shared.fontSizeScale)
    }
}
