//
//  Profile.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 23/02/26.
//

import Foundation
struct Profile: Codable {
    let id: UUID
    let name: String
    let phoneNumber: String
    let email: String
    let address: String
    let pincode: String
    let shippingAddress: String
    let updatedAt: Date?
    let isSynced: Bool
}
