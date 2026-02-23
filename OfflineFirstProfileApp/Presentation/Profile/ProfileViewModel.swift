//
//  ProfileViewModel.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 23/02/26.
//

import Foundation
class ProfileViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var address: String = ""
    @Published var pincode: String = ""
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private let useCase: ProfileUseCase
    
    init(useCase: ProfileUseCase) {
        self.useCase = useCase
    }
    
    func getProfile() {
        do {
            if let profile = try useCase.fetchProfile() {
                name = profile.name
                phoneNumber = profile.phoneNumber
                email = profile.email
                address = profile.address
                pincode = profile.pincode
            }
        } catch {
            alertMessage = "Failed to load profile"
            showAlert = true
        }
    }
    
    func saveProfile() {
        let profile = Profile(
            id: UUID(),
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            pincode: pincode,
            shippingAddress: "",
            updatedAt: Date(),
            isSynced: false
        )
        
        do {
            try useCase.saveProfile(profile: profile)
            alertMessage = "Profile saved successfully"
            showAlert = true
        } catch {
            alertMessage = "Failed to save profile"
            showAlert = true
        }
    }
    
}
