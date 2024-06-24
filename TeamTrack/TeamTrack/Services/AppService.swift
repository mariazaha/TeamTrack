//
//  AppService.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/2/24.
//

import Foundation

class AppService {
    
    var authService: AuthService?
    var userService: UserService?
    var businessService: BusinessService?
    var projectService: ProjectService?
    
    init(
        authService: AuthService?,
        userService: UserService?,
        businessService: BusinessService?,
        projectService: ProjectService?
    ) {
        self.authService = authService
        self.userService = userService
        self.businessService = businessService
        self.projectService = projectService
    }
    
}
