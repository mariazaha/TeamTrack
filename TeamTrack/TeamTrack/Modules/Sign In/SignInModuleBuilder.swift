//
//  SignInModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/3/24.
//

import UIKit

class SignInModuleBuilder {
    
    static func build(appService: AppService?) -> SignInView {
        let view = SignInView()
        let interactor = SignInInteractor(
            view: view,
            appService: appService
        )
        let presenter = SignInPresenter(
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}

