//
//  ServerError.swift
//  
//
//  Created by Victor on 25/08/2024.
//

import Foundation


public struct ServerError: Decodable, Error {
    public let error: String?
    public var httpCode: Int?
}


extension ServerError: Sendable { }

