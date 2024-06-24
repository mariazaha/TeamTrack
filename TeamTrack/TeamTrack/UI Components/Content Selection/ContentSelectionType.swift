//
//  ContentSelectionType.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/17/24.
//

import UIKit

enum ContentSelectionType {
    case employee
    case owner
    
    var title: String {
        switch self {
        case .employee:
            return "Employee"
        case .owner:
            return "Business Owner"
        }
    }
    
    var subtitle: String {
        switch self {
        case .employee:
            return "Join a team and streamline your workflow."
        case .owner:
            return "Manage your team and grow your business."
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .employee:
            return IconService.outline.employee
        case .owner:
            return IconService.outline.businessOwner
        }
    }
}
