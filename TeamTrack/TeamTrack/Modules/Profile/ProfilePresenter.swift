//
//  ProfilePresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/2/24.
//

import UIKit

protocol ProfilePresenterProtocol {
    func routeToSignUp() -> ()
    func routeToSignIn() -> ()
    func routeToSettings() -> ()
    func routeToCreateProject() -> ()
    func routeTo(project: Project) -> ()
}

class ProfilePresenter {
    var view : ProfileView?
    var appService: AppService?
    
    init(view: ProfileView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension ProfilePresenter : ProfilePresenterProtocol {
    
    func routeToSignUp() {
        let signUpView = SignUpModuleBuilder.build(appService: appService)
        view?.navigationController?.pushViewController(signUpView, animated: true)
    }
    
    func routeToSignIn() {
        let signInView = SignInModuleBuilder.build(appService: appService)
        view?.navigationController?.pushViewController(signInView, animated: true)
    }
    
    func routeToSettings() {
        let settingsView = SettingsModuleBuilder.build(appService: appService)
        view?.navigationController?.pushViewController(settingsView, animated: true)
    }
    
    func routeToCreateProject() {
        let createProjectView = CreateProjectModuleBuilder.build(appService: appService)
        view?.navigationController?.pushViewController(createProjectView, animated: true)
    }
    
    func routeTo(project: Project) {
//        let projectView = ProjectModuleBuilder.build(appService: appService, project: Project)
//        view?.navigationController?.pushViewController(projectView, animated: true)
    }
}
