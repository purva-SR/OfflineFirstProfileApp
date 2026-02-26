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
    
    func fetchProfile() async throws -> Profile? {
        try await repo.fetchProfile()
    }
    
    func saveProfile(profile: Profile) async throws {
        
        try validate(profile: profile)
        
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
        
        try await repo.saveProfile(profile: updatedProfile)
    }
    
    func validate(profile: Profile) throws {
        
        let trimmedName = profile.name.trimmingCharacters(in: .whitespaces)
        
        guard trimmedName.count >= 3,
              trimmedName.range(of: "^[A-Za-z ]+$", options: .regularExpression) != nil
        else {
            throw ValidationError.invalidName
        }

        guard profile.phoneNumber.range(of: "^[0-9]{10}$", options: .regularExpression) != nil
        else {
            throw ValidationError.invalidPhoneNumber
        }
 
        guard profile.email.range(
            of: #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#,
            options: .regularExpression
        ) != nil
        else {
            throw ValidationError.invalidEmail
        }

        let trimmedAddress = profile.address.trimmingCharacters(in: .whitespaces)
        
        guard trimmedAddress.count >= 5 else {
            throw ValidationError.invalidAddress
        }

        guard profile.pincode.range(of: "^[0-9]{6}$", options: .regularExpression) != nil
        else {
            throw ValidationError.invalidPincode
        }
    }

}
