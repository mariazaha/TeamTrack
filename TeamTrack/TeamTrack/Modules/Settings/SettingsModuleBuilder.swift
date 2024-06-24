//
//  SettingsModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/28/24.
//

import UIKit

class SettingsModuleBuilder {
    
    static func build(appService: AppService?) -> SettingsView {
        let view = SettingsView()
        let interactor = SettingsInteractor(
            view: view,
            appService: appService
        )
        let presenter = SettingsPresenter(
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}
