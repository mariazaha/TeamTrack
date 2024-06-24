//
//  CreateEmployeeInformation.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/19/24.
//

import Foundation

struct CreateEmployeeInformation {
    var handle: String?
    var inviteCode: String?
    
    func isValid() -> Bool {
        
        guard let handle = handle, !handle.isEmpty else {
            return false
        }
        
        guard let inviteCode = inviteCode, !inviteCode.isEmpty else {
            return false
        }
        
        return true
    }
}
