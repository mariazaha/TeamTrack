//
//  SignUpModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
//

import UIKit

class SignUpModuleBuilder {
    
    static func build(appService: AppService?) -> SignUpView {
        let view = SignUpView()
        let interactor = SignUpInteractor(
            view: view,
            appService: appService
        )
        let presenter = SignUpPresenter(
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}

