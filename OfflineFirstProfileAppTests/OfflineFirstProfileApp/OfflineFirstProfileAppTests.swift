//
//  OfflineFirstProfileAppTests.swift
//  OfflineFirstProfileAppTests
//
//  Created by Purva on 26/02/26.
//

import XCTest
@testable import OfflineFirstProfileApp

final class OfflineFirstProfileAppTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var repo: CoreDataProfileRepo!

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStack(inMemory: true)
        repo = CoreDataProfileRepo(context: coreDataStack.viewContext)
    }
    
    override func tearDown() {
        coreDataStack = nil
        repo = nil
        super.tearDown()
    }
    
    func testSaveProfileStoresData() async throws {
        
        let profile = Profile(
            id: UUID(),
            name: "John",
            phoneNumber: "123456789",
            email: "john@grr.la",
            address: "USA",
            pincode: "100089",
            shippingAddress: "",
            updatedAt: Date(),
            isSynced: false
        )
        
        try await repo.saveProfile(profile: profile)
        
        let fetched = try await repo.fetchProfile()
        
        XCTAssertNotNil(fetched)
        XCTAssertEqual(fetched?.name, "John")
    }
    
    func testMarkProfileAsSynced() async throws {
        
        let id = UUID()
        
        let profile = Profile(
            id: id,
            name: "Test",
            phoneNumber: "1234567890",
            email: "test@grr.la",
            address: "City",
            pincode: "111111",
            shippingAddress: "",
            updatedAt: Date(),
            isSynced: false
        )
        
        try await repo.saveProfile(profile: profile)
        
        try await repo.makeProfileAsSynced(id: id)
        
        let unsynced = try await repo.fetchUnsyncedProfiles()
        
        let fetched = try await repo.fetchProfile()
        
        XCTAssertEqual(fetched?.isSynced, true)
        XCTAssertTrue(unsynced.isEmpty)
    }

}
