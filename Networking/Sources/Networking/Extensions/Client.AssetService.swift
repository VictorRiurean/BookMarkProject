//
//  Client.AssetService.swift
//  
//
//  Created by Victor on 25/08/2024.
//

import Models


extension Client: AssetService {
    public func getAsset(url: String) async throws -> LearningAsset {
        do {
            let response: LearningAssetResponse = try await get(endpoint: AssetEndpoint.asset(url: url))
            
            return .init(response: response)
        } catch {
            throw error
        }
    }
}
