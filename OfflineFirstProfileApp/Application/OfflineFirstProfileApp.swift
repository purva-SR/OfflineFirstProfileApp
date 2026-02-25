//
//  OfflineFirstProfileApp.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 20/02/26.
//

import SwiftUI

@main
struct OfflineFirstProfileApp: App {
    
    init() {
        NetworkMonitor.shared.startMonitoring()
        SyncManager.shared.startObserving()
    }

    var body: some Scene {
        WindowGroup {
            let repo = CoreDataProfileRepo(context: CoreDataStack.shared.viewContext)
            let useCase = ProfileUseCase(repo: repo)
            let profileViewModel = ProfileViewModel(useCase: useCase)
            ProfileView(viewModel: profileViewModel)
        }
    }
}
