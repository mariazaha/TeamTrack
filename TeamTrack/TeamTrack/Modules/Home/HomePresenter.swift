//
//  HomePresenter.swift
//  TeamTrack
//
//  Created by Maria Zaha on 01.05.2024.
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
