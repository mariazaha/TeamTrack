//
//  ProfileModuleBuilder.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import UIKit

class ProfileModuleBuilder {
    
    static func build(appService: AppService?) -> ProfileView {
        let view = ProfileView()
        let interactor = ProfileInteractor(
            view: view,
            appService: appService
        )
        let presenter = ProfilePresenter()
        
        view.interactor = interactor
        view.presenter = presenter
        
        return view
    }
    
}
