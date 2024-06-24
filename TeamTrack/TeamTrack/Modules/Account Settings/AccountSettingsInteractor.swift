//
//  AccountSettingsInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import UIKit

protocol AccountSettingsInteractorProtocol {
    func computeViewTitle() -> ()
    func computeAccountEmail() -> ()
}

class AccountSettingsInteractor {
    weak var view: AccountSettingsView?
    var appService: AppService?
    
    init(view: AccountSettingsView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension AccountSettingsInteractor : AccountSettingsInteractorProtocol {
    func computeViewTitle() {
        view?.set(viewTitle: "Account Settings")
    }
    
    func computeAccountEmail() {
        guard let email = appService?.authService?.currentUser?.email, !email.isEmpty else {
            return
        }
        view?.set(email: email)
    }
}
