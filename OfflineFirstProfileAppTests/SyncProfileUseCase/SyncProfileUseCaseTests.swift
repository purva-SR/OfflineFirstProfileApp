//
//  SyncProfileUseCaseTests.swift
//  OfflineFirstProfileAppTests
//
//  Created by Purva on 26/02/26.
//

import XCTest
@testable import OfflineFirstProfileApp

class MockFileSyncService: FileSyncService {

    var callCount = 0

    override func sync(profile: Profile) throws {
        callCount += 1
    }
}

final class SyncProfileUseCaseTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var repo: CoreDataProfileRepo!
    var mockSyncService: MockFileSyncService!
    var useCase: SyncProfileUseCase!
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStack(inMemory: true)
        repo = CoreDataProfileRepo(context: coreDataStack.viewContext)
        mockSyncService = MockFileSyncService()
        useCase = SyncProfileUseCase(repo: repo, syncService: mockSyncService)
    }
    
    override func tearDown() {
        coreDataStack = nil
        repo = nil
        mockSyncService = nil
        useCase = nil
        super.tearDown()
    }
    
    func testSyncOnlyUnsyncedProfiles() async throws {

        let unsyncedProfile = Profile(
            id: UUID(),
            name: "Unsynced",
            phoneNumber: "123567890",
            email: "test@grr.la",
            address: "City",
            pincode: "111",
            shippingAddress: "",
            updatedAt: Date(),
            isSynced: false
        )

        let syncedProfile = Profile(
            id: UUID(),
            name: "Synced",
            phoneNumber: "123567890",
            email: "test@grr.la",
            address: "Town",
            pincode: "222",
            shippingAddress: "",
            updatedAt: Date(),
            isSynced: true
        )

        try await repo.saveProfile(profile: unsyncedProfile)
        try await repo.saveProfile(profile: syncedProfile)

        try await useCase.syncProfile()

        XCTAssertEqual(mockSyncService.callCount, 1)
    }
    
    
    func testProfileMarkedAsSyncedAfterSync() async throws {

        let id = UUID()

        let profile = Profile(
            id: id,
            name: "Test",
            phoneNumber: "1234567890",
            email: "test@grr.la",
            address: "City",
            pincode: "111222",
            shippingAddress: "",
            updatedAt: Date(),
            isSynced: false
        )

        try await repo.saveProfile(profile: profile)
        try await useCase.syncProfile()

        let unsynced = try await repo.fetchUnsyncedProfiles()

        XCTAssertTrue(unsynced.isEmpty)
    }
    
}
