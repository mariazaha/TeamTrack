//
//  WelcomeModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/17/24.
//

import UIKit

class WelcomeModuleBuilder {
    
    static func build(appService: AppService?) -> WelcomeView {
        let view = WelcomeView()
        let interactor = WelcomeInteractor(
            view: view,
            appService: appService
        )
        let presenter = WelcomePresenter(
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }

}
