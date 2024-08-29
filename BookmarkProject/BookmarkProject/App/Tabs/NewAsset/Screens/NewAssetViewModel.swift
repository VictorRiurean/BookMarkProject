//
//  NewResourceViewModel.swift
//  BookmarkProject
//
//  Created by Victor on 28/08/2024.
//

import Models
import Networking
import Observation


@Observable
final class NewAssetViewModel {
    
    // MARK: Public properties
    
    var didFailToGenerate = false
    var isManualModeOn = false
    
    
    // MARK: Private properties
    
    private let service: AssetService
    
    
    // MARK: Lifecycle
    
    init(service: AssetService = Client()) {
        self.service = service
    }
    
    
    // MARK: Public methods
    
    func getAsset(with url: String) async throws -> LearningAsset {
        if Int.random(in: 0 ... 2 ) % 2 == 0 {
//            return try await service.getAsset(url: url)
            try? await Task.sleep(for: .seconds(2))
            
            didFailToGenerate = true
            
            throw ClientError.timeout
        } else {
            return LearningAsset.mockLearningAssets.randomElement()!
        }
    }
}
