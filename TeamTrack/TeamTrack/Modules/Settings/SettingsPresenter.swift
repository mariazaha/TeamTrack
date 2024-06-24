//
//  SettingsPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/28/24.
//

import UIKit

protocol SettingsPresenterProtocol {
    func routeToAccountSettings() -> ()
}

class SettingsPresenter {
    weak var view: SettingsView?
    var appService: AppService?
    
    init(view: SettingsView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
    
}

extension SettingsPresenter : SettingsPresenterProtocol {
    func routeToAccountSettings() {
        let accountSettingsView = AccountSettingsModuleBuilder.build(appService: appService)
        view?.navigationController?.pushViewController(accountSettingsView, animated: true)
    }
}
