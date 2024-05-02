//
//  ProfileInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import UIKit

protocol ProfileInteractorProtocol {
    func computeViewTitle() -> ()
}

class ProfileInteractor {
    weak var view: ProfileView?
    var appService: AppService?
    
    init(view: ProfileView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension ProfileInteractor : ProfileInteractorProtocol {
    
    func computeViewTitle() {
        view?.set(viewTitle: "Profile")
    }
    
}
