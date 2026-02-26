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
    
    func fetchProfile() async throws -> Profile? {
        try await context.perform {
            let request: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
            request.fetchLimit = 1
            
            guard let entity = try self.context.fetch(request).first else {
                return nil
            }
            
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
    }
        
    func saveProfile(profile: Profile) async throws {
        try await context.perform {
            let request: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", profile.id as CVarArg)
            request.fetchLimit = 1
            
            let existing = try self.context.fetch(request).first
            let entity = existing ?? ProfileEntity(context: self.context)
            
            entity.id = profile.id
            entity.name = profile.name
            entity.phoneNumber = profile.phoneNumber
            entity.email = profile.email
            entity.address = profile.address
            entity.pincode = profile.pincode
            entity.shippingAddress = profile.shippingAddress
            entity.updatedAt = profile.updatedAt
            entity.isSynced = profile.isSynced
            
            try self.context.save()
        }
    }
    
    func fetchUnsyncedProfiles() async throws -> [Profile] {
        try await context.perform {
            let request: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
            request.predicate = NSPredicate(format: "isSynced == false")
            
            return try self.context.fetch(request).map {
                Profile(
                    id: $0.id ?? UUID(),
                    name: $0.name ?? "",
                    phoneNumber: $0.phoneNumber ?? "",
                    email: $0.email ?? "",
                    address: $0.address ?? "",
                    pincode: $0.pincode ?? "",
                    shippingAddress: $0.shippingAddress ?? "",
                    updatedAt: $0.updatedAt,
                    isSynced: $0.isSynced
                )
            }
        }
    }
    
    func makeProfileAsSynced(id: UUID) async throws {
        try await context.perform {
            let request: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            if let entity = try self.context.fetch(request).first {
                entity.isSynced = true
                try self.context.save()
            }
        }
    }
    
}
