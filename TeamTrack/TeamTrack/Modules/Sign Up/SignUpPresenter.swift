//
//  SignUpPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
//

import UIKit

protocol SignUpPresenterProtocol {
    
}

class SignUpPresenter {
    weak var view: SignUpView?
    var appService: AppService?
    
    init(view: SignUpView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
    
}

extension SignUpPresenter : SignUpPresenterProtocol {
    
}

