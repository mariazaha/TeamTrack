//
//  HomeInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 01.05.2024.
//

import UIKit

protocol HomeInteractorProtocol {
    func computeViewTitle() -> ()
}

class HomeInteractor {
    weak var view: HomeView?
    var appService: AppService?
    
    init(view: HomeView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension HomeInteractor : HomeInteractorProtocol {
    
    func computeViewTitle() {
        view?.set(viewTitle: "Home")
    }
    
}
