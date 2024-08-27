//
//  HTMLView.swift
//  
//
//  Created by Victor on 27/08/2024.
//

import SwiftUI
import WebKit


public struct HTMLView: UIViewRepresentable {
    
    public let htmlContent: String
    
    public func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
    public init(htmlContent: String) {
        self.htmlContent = htmlContent
    }
}
