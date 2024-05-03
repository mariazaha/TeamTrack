//
//  ForgotPasswordInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
//

import UIKit

protocol ForgotPasswordInteractorProtocol {
    func computeViewTitle() -> ()
}

class ForgotPasswordInteractor {
    weak var view: ForgotPasswordView?
    var appService: AppService?
    
    init(view: ForgotPasswordView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension ForgotPasswordInteractor : ForgotPasswordInteractorProtocol {
    func computeViewTitle() {
        view?.set(viewTitle: "Forgot Password")
    }
}
