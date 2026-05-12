import Foundation
import XCTest

/*
 Mocking Dependencies
 
 Mocking is a technique where you replace a real object with a "mock" object that simulates its behavior.
 This allows you to test code in isolation, without depending on external systems like databases or networks.
 
 Why Mock?
 1. Speed: Mocks are faster than real network calls.
 2. Consistency: Mocks behave predictably (no network flakes).
 3. Isolation: You only test the unit at hand, not its dependencies.
*/

// --- Protocol for the dependency ---

protocol NetworkService {
    func fetchData() async throws -> String
}

// --- Real Implementation ---

class RealNetworkService: NetworkService {
    func fetchData() async throws -> String {
        // Imagine a real URLSession call here
        return "Real Data from Internet"
    }
}

// --- Mock Implementation ---

class MockNetworkService: NetworkService {
    var result: Result<String, Error> = .success("Mocked Data")
    var fetchDataCalled = false
    
    func fetchData() async throws -> String {
        fetchDataCalled = true
        return try result.get()
    }
}

// --- Class to be tested (System Under Test - SUT) ---

class DataManager {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getProcessData() async throws -> String {
        let rawData = try await networkService.fetchData()
        return "Processed: " + rawData
    }
}

// --- Test Case ---

class DataManagerTests: XCTestCase {
    
    func testGetProcessDataSuccess() async throws {
        // Arrange
        let mockService = MockNetworkService()
        mockService.result = .success("Hello")
        let sut = DataManager(networkService: mockService)
        
        // Act
        let result = try await sut.getProcessData()
        
        // Assert
        XCTAssertEqual(result, "Processed: Hello")
        XCTAssertTrue(mockService.fetchDataCalled)
    }
    
    func testGetProcessDataFailure() async {
        // Arrange
        let mockService = MockNetworkService()
        mockService.result = .failure(NSError(domain: "Test", code: 404))
        let sut = DataManager(networkService: mockService)
        
        // Act & Assert
        do {
            _ = try await sut.getProcessData()
            XCTFail("Should have thrown an error")
        } catch {
            XCTAssertTrue(mockService.fetchDataCalled)
        }
    }
}

print("--- Mocking Dependencies example defined ---")
print("Shows how to use protocols to swap real services with mocks for testing.")
