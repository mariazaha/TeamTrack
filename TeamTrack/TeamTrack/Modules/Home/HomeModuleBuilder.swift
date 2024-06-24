//
//  HomeModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/1/24.
//

import UIKit

class HomeModuleBuilder {
    
    static func build(appService: AppService?) -> HomeView {
        let view = HomeView()
        let interactor = HomeInteractor(
            view: view,
            appService: appService
        )
        let presenter = HomePresenter(
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}
