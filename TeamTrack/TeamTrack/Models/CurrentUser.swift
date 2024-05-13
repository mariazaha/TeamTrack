//
//  CurrentUser.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import Foundation
import FirebaseAuth

class CurrentUser {
    private(set) var uid: String?
    private(set) var displayName: String?
    private(set) var username: String?
    private(set) var email: String?
    
    var company: Company?
    
    func populate(from user: User?) {
        self.uid = user?.uid
        self.displayName = user?.displayName
        self.email = user?.email
    }
    
    func update(displayName: String) {
        self.displayName = displayName
    }
}
