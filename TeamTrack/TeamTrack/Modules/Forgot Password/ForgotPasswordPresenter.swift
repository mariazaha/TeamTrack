//
//  ForgotPasswordPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
//

import UIKit

protocol ForgotPasswordPresenterProtocol {
    
}

class ForgotPasswordPresenter {
    weak var view: ForgotPasswordView?
    var appService: AppService?
    
    init(view: ForgotPasswordView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension ForgotPasswordPresenter : ForgotPasswordPresenterProtocol {
    
    
}

