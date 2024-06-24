//
//  SignUpPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/3/24.
//

import UIKit

protocol SignUpPresenterProtocol {
    func routeToSignIn() -> ()
    func routeToCompleteSignUp() -> ()
}

class SignUpPresenter {
    weak var view: SignUpView?
    var appService: AppService?
    
    init(view: SignUpView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
    
}

extension SignUpPresenter : SignUpPresenterProtocol {
    
    func routeToSignIn() {
        let signInView = SignInModuleBuilder.build(appService: appService)
        view?.navigationController?.pushViewController(signInView, animated: true)
    }
    
    func routeToCompleteSignUp() {
        let completeSignUpView = CompleteSignUpModuleBuilder.build(appService: appService)
        completeSignUpView.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(completeSignUpView, animated: true)
    }
}

