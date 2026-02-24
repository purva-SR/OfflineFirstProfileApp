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
            try syncService.sync(profile: profile)
            try await repo.makeProfileAsSynced(id: profile.id)
        }
    }
}
