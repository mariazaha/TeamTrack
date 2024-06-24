//
//  CompleteSignUpInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/16/24.
//

import UIKit

protocol CompleteSignUpInteractorProtocol {
    func computeViewTitle() -> ()
    func set(accountType: AccountType) -> ()
}

class CompleteSignUpInteractor {
    private weak var view : CompleteSignUpView?
    private var appService : AppService?
    private var accountType: AccountType?
    
    init(view: CompleteSignUpView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension CompleteSignUpInteractor : CompleteSignUpInteractorProtocol {
    func computeViewTitle() {
        view?.set(viewTitle: "Account Type")
    }
    
    func set(accountType: AccountType) {
        appService?.authService?.currentUser?.update(accountType: accountType)
        view?.enableContinueButton()
    }
}
