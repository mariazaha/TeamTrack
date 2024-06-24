//
//  WelcomePresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/17/24.
//

import UIKit

protocol WelcomePresenterProtocol {
    func getStartedTapped() -> ()
}

class WelcomePresenter {
    private weak var view: WelcomeView?
    private var appService: AppService?
    
    init(view: WelcomeView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension WelcomePresenter : WelcomePresenterProtocol {
    
    func getStartedTapped() {
        view?.navigationController?.popToRootViewController(animated: true)
    }
}
