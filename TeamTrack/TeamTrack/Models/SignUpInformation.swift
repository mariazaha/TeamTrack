//
//  SignUpInformation.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/6/24.
//

import Foundation

struct SignUpInformation {
    var name: String?
    var email: String?
    var password: String?
    var confirmedPassword: String?
    
    func isValid() -> Bool {
        
        guard let name = name, !name.isEmpty else {
            return false
        }
        
        guard let email = email, !email.isEmpty else {
            return false
        }
        
        guard let password = password, let confirmedPassword = confirmedPassword, password == confirmedPassword else {
            return false
        }
        
        return true
    }
}
