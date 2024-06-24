//
//  SignUpInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/3/24.
//

import UIKit

protocol SignUpInteractorProtocol {
    func computeViewTitle() -> ()
    func textFieldDidChange(type: CustomTextFieldType, text: String) -> ()
    func signUpTapped() -> ()
}

class SignUpInteractor {
    weak var view : SignUpView?
    var appService : AppService?
    
    private var signUpInformation: SignUpInformation
    
    init(view: SignUpView, appService: AppService?) {
        self.view = view
        self.appService = appService
        self.signUpInformation = SignUpInformation()
    }
}

extension SignUpInteractor : SignUpInteractorProtocol {
    func computeViewTitle() {
        view?.set(viewTitle: "Sign Up")
    }
    
    func textFieldDidChange(type: CustomTextFieldType, text: String) {
        switch type {
        case .name:
            signUpInformation.name = text
        case .email:
            signUpInformation.email = text
        case .password:
            signUpInformation.password = text
        case .confirmPassword:
            signUpInformation.confirmedPassword = text
        default:
            break
        }
        
        signUpInformationDidChange()
    }
    
    private func signUpInformationDidChange() {
        view?.setSignUpButton(enabled: signUpInformation.isValid())
    }
    
    func signUpTapped() {
        view?.view.endEditing(true)
        view?.setSignUpButton(enabled: false)
        view?.startActivityIndicator()
        
        let currentSignUpInformation = signUpInformation
        
        appService?.authService?.signUp(with: currentSignUpInformation, completion: { [weak self] authResult in
            switch authResult {
            case .success():
                self?.view?.signUpSuccessful()
            case .failure(let error):
                self?.view?.signUpFailed(with: error.rawValue)
            }
        })
    }
}
