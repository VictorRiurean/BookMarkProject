//
//  WebViewRepresentable.swift
//  
//
//  Created by Victor on 27/08/2024.
//

import SwiftUI
import WebKit


public struct WebViewRepresentable: UIViewRepresentable {
    
    public let url: URL
    
    public func makeUIView(context: Context) -> WKWebView {
        let request = URLRequest(url: url)
        let wkwebView = WKWebView()
        
        wkwebView.load(request)
        
        return wkwebView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) { }
    
    public init(url: URL) {
        self.url = url
    }
}
