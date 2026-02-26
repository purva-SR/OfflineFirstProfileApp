//
//  ProfileUseCaseTests.swift
//  OfflineFirstProfileAppTests
//
//  Created by Purva on 26/02/26.
//

import XCTest
@testable import OfflineFirstProfileApp

final class ProfileUseCaseTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var repo: CoreDataProfileRepo!
    var useCase: ProfileUseCase!
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStack(inMemory: true)
        repo = CoreDataProfileRepo(context: coreDataStack.viewContext)
        useCase = ProfileUseCase(repo: repo)
    }
    
    override func tearDown() {
        coreDataStack = nil
        repo = nil
        useCase = nil
        super.tearDown()
    }
    
    func testShippingAddressFormat() async throws {
        
        let profile = Profile(
            id: UUID(),
            name: "Test",
            phoneNumber: "1234567890",
            email: "a@grr.la",
            address: "City",
            pincode: "100001",
            shippingAddress: "",
            updatedAt: Date(),
            isSynced: false
        )
        
        try await useCase.saveProfile(profile: profile)
        
        let fetched = try await useCase.fetchProfile()
        
        XCTAssertEqual(fetched?.shippingAddress, "City - 100001")
        XCTAssertEqual(fetched?.isSynced, false)
    }
    
}
