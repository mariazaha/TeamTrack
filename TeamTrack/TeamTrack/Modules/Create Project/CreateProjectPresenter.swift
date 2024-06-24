//
//  CreateProjectPresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import UIKit

protocol CreateProjectPresenterProtocol {
    
}

class CreateProjectPresenter {
    weak var view: CreateProjectView?
    var appService: AppService?
    
    init(view: CreateProjectView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension CreateProjectPresenter : CreateProjectPresenterProtocol {
    
}
