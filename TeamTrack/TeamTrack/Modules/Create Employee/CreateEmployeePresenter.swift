//
//  CreateEmployeePresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/19/24.
//

import UIKit

protocol CreateEmployeePresenterProtocol {
    func routeToWelcome() -> ()
}

class CreateEmployeePresenter {
    private weak var view: CreateEmployeeView?
    private var appService: AppService?
    
    init(view: CreateEmployeeView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension CreateEmployeePresenter : CreateEmployeePresenterProtocol {
    
    private func dismissToProfileView() {
        view?.navigationController?.popToRootViewController(animated: true)
    }
    
    func routeToWelcome() {
        let welcomeView = WelcomeModuleBuilder.build(appService: appService)
        view?.navigationController?.pushViewController(welcomeView, animated: true)
    }
}
