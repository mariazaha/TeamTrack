//
//  SignInPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
//

import UIKit

protocol SignInPresenterProtocol {
    func routeToSignUp () -> ()
}

class SignInPresenter {
    weak var view : SignInView?
    var appService : AppService?
    
    init(view: SignInView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}
extension SignInPresenter : SignInPresenterProtocol {
    func routeToSignUp() {
        let signUpView = SignUpModuleBuilder.build(appService: appService)
        view?.navigationController?.pushViewController(signUpView, animated: true)
    }
    
    
}
