//
//  ProfileViewSnapshotTests.swift
//  OfflineFirstProfileAppTests
//
//  Created by Purva on 26/02/26.
//

import XCTest
import SnapshotTesting
@testable import OfflineFirstProfileApp

final class ProfileViewSnapshotTests: XCTestCase {
    
    @MainActor
    func testProfileViewSnapshot() {
        let coreDataStack = CoreDataStack(inMemory: true)
        let repo = CoreDataProfileRepo(context: coreDataStack.viewContext)
        let useCase = ProfileUseCase(repo: repo)
        let viewModel = ProfileViewModel(useCase: useCase)
        let view = ProfileView(viewModel: viewModel)
        
        assertSnapshot(
            of: view,
            as: .image(layout: .device(config: .iPhone13ProMax))
        )
    }
    
}
