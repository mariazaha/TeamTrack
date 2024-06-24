//
//  CreateEmployeeModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/19/24.
//

import UIKit

class CreateEmployeeModuleBuilder {
    
    static func build(appService: AppService?) -> CreateEmployeeView {
        let view = CreateEmployeeView()
        let interactor = CreateEmployeeInteractor(
            view: view,
            appService: appService
        )
        let presenter = CreateEmployeePresenter(
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}
