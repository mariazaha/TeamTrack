//
//  ForgotPasswordInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/2/24.
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
