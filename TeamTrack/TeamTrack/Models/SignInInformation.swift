//
//  SignInInformation.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/13/24.
//

import Foundation

struct SignInInformation {
    var email: String?
    var password: String?
    
    func isValid() -> Bool {
        
        guard let email = email, !email.isEmpty else {
            return false
        }
        
        guard let password = password, !password.isEmpty else {
            return false
        }
        
        return true
    }
}
