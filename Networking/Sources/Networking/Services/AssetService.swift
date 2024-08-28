//
//  AssetService.swift
//  
//
//  Created by Victor on 25/08/2024.
//

import Models


public protocol AssetService {
    func getAsset(url: String) async throws -> LearningAsset
}
