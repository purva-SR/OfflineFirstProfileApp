//
//  ProfileRepo.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 23/02/26.
//

import Foundation
protocol ProfileRepo {
    func fetchProfile() async throws -> Profile?
    func saveProfile(profile: Profile) async throws
    func fetchUnsyncedProfiles() async throws -> [Profile]
    func makeProfileAsSynced(id: UUID) async throws
}
