//
//  CreateProjectModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import UIKit

class CreateProjectModuleBuilder {
    static func build (appService: AppService?) -> CreateProjectView {
        
        let view = CreateProjectView()
        let interactor = CreateProjectInteractor(
            view: view,
            appService: appService
        )
        let presenter = CreateProjectPresenter (
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
}
