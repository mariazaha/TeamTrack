//
//  CreateBusinessPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/16/24.
//

import UIKit

protocol CreateBusinessPresenterProtocol {
    func routeToWelcome() -> ()
}

class CreateBusinessPresenter {
    private weak var view: CreateBusinessView?
    private var appService: AppService?
    
    init(view: CreateBusinessView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension CreateBusinessPresenter : CreateBusinessPresenterProtocol {
    
    private func dismissToProfileView() {
        view?.navigationController?.popToRootViewController(animated: true)
    }
    
    func routeToWelcome() {
        let welcomeView = WelcomeModuleBuilder.build(appService: appService)
        view?.navigationController?.pushViewController(welcomeView, animated: true)
    }
}
