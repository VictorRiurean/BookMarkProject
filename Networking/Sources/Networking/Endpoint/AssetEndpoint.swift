//
//  File.swift
//  
//
//  Created by Victor on 25/08/2024.
//

import Foundation


public enum AssetEndpoint: Endpoint {
    case asset(url: String)
    
    // MARK: Public properties
    
    public var jsonValue: Encodable? {
        switch self {
        case .asset:
            nil
        }
    }
    
    
    // MARK: Public methods
    
    public func path() -> String {
        switch self {
        case .asset(let url):
            "/api/asset/\(url)"
        }
    }
    
    public func queryItems() -> [URLQueryItem]? {
        switch self {
        case .asset:
            nil
        }
    }
}
