//
//  SignUpInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
//

import UIKit

protocol SignUpInteractorProtocol {
    func computeViewTitle() -> ()
}

class SignUpInteractor {
    weak var view : SignUpView?
    var appService : AppService?
    
    init(view: SignUpView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension SignUpInteractor : SignUpInteractorProtocol {
    func computeViewTitle() {
        view?.set(viewTitle: "Sign Up")
    }
}
