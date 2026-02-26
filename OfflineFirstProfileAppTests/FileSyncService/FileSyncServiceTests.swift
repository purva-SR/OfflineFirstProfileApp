//
//  FileSyncServiceTests.swift
//  OfflineFirstProfileAppTests
//
//  Created by Purva on 26/02/26.
//

import XCTest
@testable import OfflineFirstProfileApp

final class FileSyncServiceTests: XCTestCase {
    
    var service: FileSyncService!
    
    override func setUp() {
        super.setUp()
        service = FileSyncService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testSyncSavesFile() throws {
        
        let profile = Profile(
            id: UUID(),
            name: "New User",
            phoneNumber: "1234567890",
            email: "user@grr.la",
            address: "City street",
            pincode: "1000001",
            shippingAddress: "",
            updatedAt: Date(),
            isSynced: true
        )
        
        try service.sync(profile: profile)
        
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("SyncedProfile.json")
        
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
    }
}
