//
//  SignInInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/3/24.
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
            switch authResult {
            case .success():
                self?.checkIfAccountWasCreated()
            case .failure(let error):
                self?.view?.endActivityIndicator()
                self?.view?.signInFailed(with: error.rawValue)
            }
        })
    }
    
    private func checkIfAccountWasCreated() {
        guard let uid = appService?.authService?.currentUser?.uid else {
            view?.endActivityIndicator()
            view?.signInFailed(with: AuthenticationError.other.rawValue)
            return
        }
        
        appService?.userService?.fetchUser(uid: uid, completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.endActivityIndicator()

                switch result {
                case .success(let appUser):
                    self?.appService?.authService?.currentUser?.merge(from: appUser)
                    self?.appService?.authService?.cacheCurrentUser()
                    self?.view?.signInSuccessful()
                case .failure(let failure):
                    switch failure {
                    case .userAccountIncomplete:
                        self?.view?.completeSignUp()
                    default:
                        self?.view?.signInFailed(with: failure.rawValue)
                    }
                }
            }
        })
    }
}
