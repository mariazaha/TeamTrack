//
//  SignInPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/3/24.
//

import UIKit

protocol SignInPresenterProtocol {
    func routeToSignUp() -> ()
    func routeToCompleteSignUp() -> ()
    func dismissToProfileView() -> ()
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
    
    func dismissToProfileView() {
        view?.navigationController?.popToRootViewController(animated: true)
    }

    func routeToCompleteSignUp() {
        let completeSignUpView = CompleteSignUpModuleBuilder.build(appService: appService)
        completeSignUpView.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(completeSignUpView, animated: true)
    }
}
