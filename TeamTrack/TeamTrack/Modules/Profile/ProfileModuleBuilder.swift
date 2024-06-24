//
//  ProfileModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/2/24.
//

import UIKit

class ProfileModuleBuilder {
    
    static func build(appService: AppService?) -> ProfileView {
        let view = ProfileView()
        let interactor = ProfileInteractor(
            view: view,
            appService: appService
        )
        let presenter = ProfilePresenter(
            view: view,
            appService: appService
        )
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}
