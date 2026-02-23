//
//  OfflineFirstProfileAppApp.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 20/02/26.
//

import SwiftUI

@main
struct OfflineFirstProfileAppApp: App {
    let coreDataStack = CoreDataStack.shared

    var body: some Scene {
        WindowGroup {
            let repo = CoreDataProfileRepo(
                context: coreDataStack.container.viewContext
            )
            let useCase = ProfileUseCase(repo: repo)
            let profileViewModel = ProfileViewModel(useCase: useCase)
            ProfileView(viewModel: profileViewModel)
        }
    }
}
