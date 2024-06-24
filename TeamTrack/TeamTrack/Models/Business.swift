//
//  Business.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/2/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

class Business {
    var name: String?
    var handle: String?
    var ownerId: String?
    var inviteCode: String?
    
    func populate(from document: DocumentSnapshot) {
        
        if let name = document["name"] as? String {
            self.name = name
        }
        
        if let handle = document["handle"] as? String {
            self.handle = handle
        }
        
        if let ownerId = document["ownerId"] as? String {
            self.ownerId = ownerId
        }
        
        if let inviteCode = document["inviteCode"] as? String {
            self.inviteCode = inviteCode
        }
        
    }
    
    func isValid() -> Bool {
        
        guard let name = name, !name.isEmpty else {
            return false
        }
        
        guard let handle = handle, !handle.isEmpty else {
            return false
        }
        
        guard let inviteCode = inviteCode, inviteCode.count > 5 else {
            return false
        }
        
        return true
    }
    
    func documentData() -> [String: Any] {
        var dict = [String: Any]()
        dict["name"] = name
        dict["handle"] = handle
        dict["ownerId"] = ownerId
        dict["inviteCode"] = inviteCode
        return dict
    }
}
