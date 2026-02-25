//
//  SyncProfileUseCase.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 24/02/26.
//

import Foundation
struct SyncProfileUseCase {
    
    private let repo: ProfileRepo
    private let syncService: FileSyncService
    
    init(repo: ProfileRepo, syncService: FileSyncService) {
        self.repo = repo
        self.syncService = syncService
    }
    
    func syncProfile() async throws {
        let unsyncedProfiles = try await repo.fetchUnsyncedProfiles()
        
        for profile in unsyncedProfiles {
            let updatedProfile = Profile(
                id: profile.id,
                name: profile.name,
                phoneNumber: profile.phoneNumber,
                email: profile.email,
                address: profile.address,
                pincode: profile.pincode,
                shippingAddress: profile.shippingAddress,
                updatedAt: profile.updatedAt,
                isSynced: true
            )
            try syncService.sync(profile: updatedProfile)
            try await repo.makeProfileAsSynced(id: profile.id)
        }
    }
}
