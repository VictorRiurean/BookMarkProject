// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Models
import Observation
import SwiftUI


@Observable
public final class Client {
    
    // MARK: Private properties
    
    private let urlSession: URLSession = .shared
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    
    // MARK: Lifecycle
    
    public init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = .sortedKeys
    }
    
    
    // MARK: Public methods
    
    public func get<Entity: Decodable>(endpoint: Endpoint) async throws -> Entity {
        try await makeEntityRequest(endpoint: endpoint, method: "GET")
    }
    
    
    // MARK: Private methods
    
    private func makeURL(
        scheme: String = AppInfo.scheme,
        host: String = AppInfo.host,
        endpoint: Endpoint
    ) -> URL {
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        components.path += endpoint.path()
        components.queryItems = endpoint.queryItems()
        
        return components.url!
    }
    
    private func makeURLRequest(url: URL, endpoint: Endpoint, httpMethod: String) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        
        if let json = endpoint.jsonValue {
            do {
                let jsonData = try encoder.encode(json)
                
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                // TODO: Log error
            }
        }
        
        return request
    }
    
    private func makeEntityRequest<Entity: Decodable>(
        endpoint: Endpoint,
        method: String
    ) async throws -> Entity {
        let url = makeURL(endpoint: endpoint)
        let request = makeURLRequest(url: url, endpoint: endpoint, httpMethod: method)
        let (data, httpResponse) = try await urlSession.data(for: request)
        
        do {
            return try decoder.decode(Entity.self, from: data)
        } catch {
            if var serverError = try? decoder.decode(ServerError.self, from: data) {
                if let httpResponse = httpResponse as? HTTPURLResponse {
                    serverError.httpCode = httpResponse.statusCode
                }
                
                throw serverError
            }
            
            throw error
        }
    }
}

extension Client: Sendable {}
