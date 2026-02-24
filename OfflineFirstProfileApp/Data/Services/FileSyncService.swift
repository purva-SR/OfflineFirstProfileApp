//
//  FileSyncService.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 24/02/26.
//

import Foundation
class FileSyncService {
    
    func sync(profile: Profile) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try encoder.encode([
            "id": profile.id.uuidString,
            "name": profile.name,
            "phone_number": profile.phoneNumber,
            "email": profile.email,
            "address": profile.address,
            "pincode": profile.pincode,
            "shipping_address": profile.shippingAddress
        ])
        
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("SyncedProfile.json")
        
        try data.write(to: url)
    }
}
