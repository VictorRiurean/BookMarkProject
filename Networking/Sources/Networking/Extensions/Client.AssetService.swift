//
//  Client.AssetService.swift
//  
//
//  Created by Victor on 25/08/2024.
//

import Models


extension Client: AssetService {
    public func getAsset(url: String) async throws -> LearningAssetResponse {
        do {
            return try await get(endpoint: AssetEndpoint.asset(url: url))
        } catch {
            throw error
        }
    }
}
