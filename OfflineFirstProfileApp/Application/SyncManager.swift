//
//  SyncManager.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 25/02/26.
//

import Foundation
import Combine

final class SyncManager {

    static let shared = SyncManager()

    private var cancellables = Set<AnyCancellable>()
    private var isSyncing = false
    
    let syncCompleted = PassthroughSubject<Void, Never>()

    private init() {}

    func startObserving() {
        observeNetwork()
    }

    private func observeNetwork() {
        NetworkMonitor.shared.$isOnline
            .filter { $0 }
            .sink { _ in
                Task {
                    await self.triggerSyncIfNeeded()
                }
            }
            .store(in: &cancellables)
    }

    func triggerSyncIfNeeded() async {
        guard NetworkMonitor.shared.isOnline, !isSyncing else {
            return
        }
        isSyncing = true
        defer { isSyncing = false }
        
        let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
        let repo = CoreDataProfileRepo(context: backgroundContext)
        do {
            let unsyncedProfiles = try await repo.fetchUnsyncedProfiles()
            guard !unsyncedProfiles.isEmpty else { return }
            
            let syncUseCase = SyncProfileUseCase(
                repo: repo,
                syncService: FileSyncService()
            )
            
            try await syncUseCase.syncProfile()
            
            DispatchQueue.main.async {
                self.syncCompleted.send()
            }
        } catch {
            // Sync failed.
        }
    }
}
