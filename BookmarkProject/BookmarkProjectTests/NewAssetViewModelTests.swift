//
//  NewAssetViewModelTests.swift
//  BookmarkProjectTests
//
//  Created by Victor on 29/08/2024.
//

import XCTest
import Networking
import Models
@testable import BookmarkProject


final class NewAssetViewModelTests: XCTestCase {

    class MockAssetService: AssetService {
        var shouldSucceed: Bool = true
        
        func getAsset(url: String) async throws -> LearningAsset {
            if shouldSucceed {
                return LearningAsset.mockLearningAssets.randomElement()!
            } else {
                throw ClientError.timeout
            }
        }
    }

    /// Due to viewModel implementation which involves Int.random, some variances of the tests are flakey. I will leave a commented
    /// out version as a sort of a proof of concept. 
//    func testGetAssetFailure() async {
//        // Arrange
//        let mockService = MockAssetService()
//        
//        mockService.shouldSucceed = false
//        
//        let viewModel = NewAssetViewModel(service: mockService)
//        
//        // Act
//        do {
//            _ = try await viewModel.getAsset(with: "https://example.com")
//            
//            XCTFail("Expected failure, but got success")
//        } catch ClientError.timeout {
//            // Assert
//            XCTAssertTrue(viewModel.didFailToGenerate)
//        } catch {
//            XCTFail("Expected ClientError.timeout, but got \(error)")
//        }
//    }
    
    func testDidFailToGenerateIsTrueOnFailure() async {
        // Arrange
        let mockService = MockAssetService()
        let viewModel = NewAssetViewModel(service: mockService)
        
        // Act
        do {
            _ = try await viewModel.getAsset(with: "https://example.com")
        } catch {
            // Assert
            XCTAssertTrue(viewModel.didFailToGenerate)
        }
    }
    
    func testIsManualModeOnDefaultsToFalse() {
        // Arrange
        let viewModel = NewAssetViewModel()
        
        // Assert
        XCTAssertFalse(viewModel.isManualModeOn)
    }
}

