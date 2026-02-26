//
//  ValidationError.swift
//  OfflineFirstProfileApp
//
//  Created by Purva on 26/02/26.
//

import Foundation
enum ValidationError: LocalizedError {
    case invalidName
    case invalidPhoneNumber
    case invalidEmail
    case invalidAddress
    case invalidPincode
    
    var errorDescription: String? {
        switch self {
        case .invalidName:
            return "Name must be at least 3 characters."
        case .invalidPhoneNumber:
            return "Phone number must be 10 digits."
        case .invalidEmail:
            return "Invalid email."
        case .invalidAddress:
            return "Address must be at least 5 characters."
        case .invalidPincode:
            return "Pincode must be 6 digits."
        }
    }
}
