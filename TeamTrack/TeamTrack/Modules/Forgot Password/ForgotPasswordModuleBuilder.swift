//
//  ForgotPasswordModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/2/24.
//

import UIKit

class ForgotPasswordModuleBuilder {
    
    static func build(appService: AppService?) -> ForgotPasswordView {
        let view = ForgotPasswordView()
        let interactor = ForgotPasswordInteractor(
            view: view,
            appService: appService
        )
        let presenter = ForgotPasswordPresenter(
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}

