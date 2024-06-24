//
//  CompleteSignUpModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/16/24.
//

import UIKit

class CompleteSignUpModuleBuilder {
    
    static func build(appService: AppService?) -> CompleteSignUpView {
        let view = CompleteSignUpView()
        let interactor = CompleteSignUpInteractor(
            view: view,
            appService: appService
        )
        let presenter = CompleteSignUpPresenter(
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}
