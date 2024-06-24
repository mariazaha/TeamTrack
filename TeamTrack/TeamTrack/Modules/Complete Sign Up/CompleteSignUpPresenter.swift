//
//  CompleteSignUpPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/16/24.
//

import UIKit

protocol CompleteSignUpPresenterProtocol {
    func routeToNextStep() -> ()
}

class CompleteSignUpPresenter {
    private weak var view: CompleteSignUpView?
    private var appService: AppService?
    
    init(view: CompleteSignUpView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension CompleteSignUpPresenter : CompleteSignUpPresenterProtocol {
    
    func routeToNextStep() {
        switch appService?.authService?.currentUser?.accountType {
        case .owner:
            let createBusinessView = CreateBusinessModuleBuilder.build(appService: appService)
            view?.navigationController?.pushViewController(createBusinessView, animated: true)
        case .employee:
            let createEmployeeView = CreateEmployeeModuleBuilder.build(appService: appService)
            view?.navigationController?.pushViewController(createEmployeeView, animated: true)
        case nil:
            dismissToProfileView()
        }
    }
    
    private func dismissToProfileView() {
        view?.navigationController?.popToRootViewController(animated: true)
    }
}
