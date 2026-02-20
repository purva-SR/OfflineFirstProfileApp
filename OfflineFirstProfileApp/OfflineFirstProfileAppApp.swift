//
//  OfflineFirstProfileAppApp.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 20/02/26.
//

import SwiftUI

@main
struct OfflineFirstProfileAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
