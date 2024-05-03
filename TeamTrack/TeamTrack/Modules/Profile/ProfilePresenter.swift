//
//  ProfilePresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import UIKit

protocol ProfilePresenterProtocol {
    func routeToSignUp() -> ()
    func routeToSignIn() -> ()
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
}
