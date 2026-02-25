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
        encoder.dateEncodingStrategy = .iso8601
        
        let data = try encoder.encode(profile)
        
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("SyncedProfile.json")
        
        try data.write(to: url)
    }
}
