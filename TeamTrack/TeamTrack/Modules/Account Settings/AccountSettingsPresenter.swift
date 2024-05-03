//
//  AccountSettingsPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
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
