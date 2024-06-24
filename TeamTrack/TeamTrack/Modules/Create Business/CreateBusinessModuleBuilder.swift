//
//  CreateBusinessModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/16/24.
//

import UIKit

class CreateBusinessModuleBuilder {
    
    static func build(appService: AppService?) -> CreateBusinessView {
        let view = CreateBusinessView()
        let interactor = CreateBusinessInteractor(
            view: view,
            appService: appService
        )
        let presenter = CreateBusinessPresenter(
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}
