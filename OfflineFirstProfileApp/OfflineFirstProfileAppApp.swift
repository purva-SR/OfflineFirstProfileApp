//
//  OfflineFirstProfileAppApp.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 20/02/26.
//

import SwiftUI
import Combine

@main
struct OfflineFirstProfileAppApp: App {
    let coreDataStack = CoreDataStack.shared
    
    private let networkMonitor = NetworkMonitor()
        
    @State private var cancellables = Set<AnyCancellable>()

    var body: some Scene {
        WindowGroup {
            let repo = CoreDataProfileRepo(context: coreDataStack.viewContext)
            let useCase = ProfileUseCase(repo: repo)
            let profileViewModel = ProfileViewModel(useCase: useCase)
            
            ProfileView(viewModel: profileViewModel)
                .onAppear {
                    setupNetworkMonitoring()
                }
        }
    }
    
    private func setupNetworkMonitoring() {
        networkMonitor.statusPublisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .filter { $0 }
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { _ in
                Task {
                    await triggerSync()
                }
            }
            .store(in: &cancellables)
        
        networkMonitor.startMonitoring()
    }
    
    private func triggerSync() async {
        let backgroundContext = coreDataStack.container.newBackgroundContext()
        let backgroundRepo = CoreDataProfileRepo(context: backgroundContext)
        
        let syncUseCase = SyncProfileUseCase(
            repo: backgroundRepo,
            syncService: FileSyncService()
        )
        
        do {
            try await syncUseCase.syncProfile()
        } catch {
            fatalError("Sync failed")
        }
    }
}
