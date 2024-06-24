//
//  AccountSettingsPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import UIKit

protocol AccountSettingsPresenterProtocol {
    
}

class AccountSettingsPresenter {
    weak var view: AccountSettingsView?
    var appService: AppService?
    
    init(view: AccountSettingsView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension AccountSettingsPresenter : AccountSettingsPresenterProtocol {
    
}
