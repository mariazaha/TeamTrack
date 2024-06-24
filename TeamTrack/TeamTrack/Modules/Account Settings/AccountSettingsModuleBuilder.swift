//
//  AccountSettingsModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import UIKit

class AccountSettingsModuleBuilder {
    static func build (appService: AppService?) -> AccountSettingsView {
        
        let view = AccountSettingsView()
        let interactor = AccountSettingsInteractor(
            view: view,
            appService: appService
        )
        let presenter = AccountSettingsPresenter (
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
}
