//
//  Endpoint.swift
//
//
//  Created by Victor on 25/08/2024.
//

import Foundation


public protocol Endpoint: Sendable {
    var jsonValue: Encodable? { get }
    
    func path() -> String
    func queryItems() -> [URLQueryItem]?
}


public extension Endpoint {
    var jsonValue: Encodable? {
        nil
    }
}
