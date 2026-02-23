//
//  CoreDataProfileRepo.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 23/02/26.
//

import Foundation
import CoreData

final class CoreDataProfileRepo: ProfileRepo {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchProfile() throws -> Profile? {
        let request: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
        request.fetchLimit = 1
        let result = try context.fetch(request).first
        
        guard let entity = result else { return nil }
        
        return Profile(
            id: entity.id ?? UUID(),
            name: entity.name ?? "",
            phoneNumber: entity.phoneNumber ?? "",
            email: entity.email ?? "",
            address: entity.address ?? "",
            pincode: entity.pincode ?? "",
            shippingAddress: entity.shippingAddress ?? "",
            updatedAt: entity.updatedAt,
            isSynced: entity.isSynced
        )
    }
    
    func saveProfile(profile: Profile) throws {
        let request: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
           request.fetchLimit = 1
           let currentProfile = try context.fetch(request).first

           let entity = currentProfile ?? ProfileEntity(context: context)
           entity.id = profile.id
           entity.name = profile.name
           entity.phoneNumber = profile.phoneNumber
           entity.email = profile.email
           entity.address = profile.address
           entity.pincode = profile.pincode
           entity.shippingAddress = profile.shippingAddress
           entity.updatedAt = Date()
           entity.isSynced = profile.isSynced
           
           try context.save()
    }
    
}
