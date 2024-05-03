//
//  SignInInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
//

import UIKit

protocol SignInInteractorProtocol {
    func computeViewTitle() -> ()
}

class SignInInteractor {
    weak var view : SignInView?
    var appService : AppService?
    
    init(view: SignInView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension SignInInteractor : SignInInteractorProtocol {
    func computeViewTitle() {
        view?.set(viewTitle: "Sign In")
    }
}
