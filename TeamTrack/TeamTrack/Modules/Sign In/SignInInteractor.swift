//
//  SignInInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
//

import UIKit

protocol SignInInteractorProtocol {
    func computeViewTitle() -> ()
    func textFieldDidChange(type: CustomTextFieldType, text: String) -> ()
    func signInTapped() -> ()
}

class SignInInteractor {
    weak var view : SignInView?
    var appService : AppService?
    
    private var signInInformation: SignInInformation
    
    init(view: SignInView, appService: AppService?) {
        self.view = view
        self.appService = appService
        self.signInInformation = SignInInformation()
    }
}

extension SignInInteractor : SignInInteractorProtocol {
    func computeViewTitle() {
        view?.set(viewTitle: "Sign In")
    }
    
    func textFieldDidChange(type: CustomTextFieldType, text: String) {
        switch type {
        case .email:
            signInInformation.email = text
        case .password:
            signInInformation.password = text
        default:
            break
        }
        
        signUpInformationDidChange()
    }
    
    private func signUpInformationDidChange() {
        view?.setSignInButton(enabled: signInInformation.isValid())
    }
    
    func signInTapped() {
        view?.view.endEditing(true)
        view?.setSignInButton(enabled: false)
        view?.startActivityIndicator()
        
        let currentSignInInformation = signInInformation
        
        appService?.authService?.signIn(with: currentSignInInformation, completion: { [weak self] authResult in
            self?.view?.endActivityIndicator()
            switch authResult {
            case .success():
                self?.view?.signInSuccessful()
            case .failure(let error):
                self?.view?.signInFailed(with: error.rawValue)
            }
        })
    }
}
