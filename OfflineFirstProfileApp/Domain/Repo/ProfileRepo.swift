//
//  ProfileRepo.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 23/02/26.
//

import Foundation
protocol ProfileRepo {
    func fetchProfile() throws -> Profile?
    func saveProfile(profile: Profile) throws
}
