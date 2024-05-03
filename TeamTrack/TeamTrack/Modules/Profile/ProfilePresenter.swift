//
//  ProfilePresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import UIKit

protocol ProfilePresenterProtocol {
    
}

class ProfilePresenter {
    var view : HomeView?
    var appService: AppService?
    
    init(view: HomeView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension ProfilePresenter : ProfilePresenterProtocol {
    
}
