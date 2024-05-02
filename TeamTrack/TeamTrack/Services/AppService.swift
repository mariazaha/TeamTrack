//
//  AppService.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import Foundation

class AppService {
    
    var authService: AuthService?
    
    init(authService: AuthService?) {
        self.authService = authService
    }
    
}
