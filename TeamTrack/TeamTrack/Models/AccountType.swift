//
//  AccountType.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/16/24.
//

import Foundation

enum AccountType : Int {
    case owner = 1
    case employee = 2
    
    static func accountType(for id: Int) -> AccountType? {
        switch id {
        case 1:
            return .owner
        case 2:
            return .employee
        default:
            return nil
        }
    }
}
