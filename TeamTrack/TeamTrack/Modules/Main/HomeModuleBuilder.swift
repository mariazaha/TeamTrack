//
//  HomeModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 01.05.2024.
//

import UIKit

class HomeModuleBuilder {
    
    static func build(appService: AppService?) -> HomeView {
        let view = HomeView()
        let interactor = HomeInteractor(
            view: view,
            appService: appService
        )
        let presenter = HomePresenter()
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}
