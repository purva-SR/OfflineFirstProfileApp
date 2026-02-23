//
//  ProfileUseCase.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 23/02/26.
//

import Foundation
struct ProfileUseCase {
    private let repo: ProfileRepo
    
    init(repo: ProfileRepo) {
        self.repo = repo
    }
    
    func fetchProfile() throws -> Profile? {
        try repo.fetchProfile()
    }
    
    func saveProfile(profile: Profile) throws {
        
        let updatedProfile = Profile(
            id: profile.id,
            name: profile.name,
            phoneNumber: profile.phoneNumber,
            email: profile.email,
            address: profile.address,
            pincode: profile.pincode,
            shippingAddress: "\(profile.address) - \(profile.pincode)",
            updatedAt: Date(),
            isSynced: false
        )
        
        try repo.saveProfile(profile: updatedProfile)
    }

}
