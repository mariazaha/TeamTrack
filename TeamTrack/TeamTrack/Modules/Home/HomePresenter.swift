//
//  HomePresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/1/24.
//

import UIKit

protocol HomePresenterProtocol {
    
}

class HomePresenter {
    weak var view: HomeView?
    var appService: AppService?
    
    init(view: HomeView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
    
}

extension HomePresenter : HomePresenterProtocol {
    
}
