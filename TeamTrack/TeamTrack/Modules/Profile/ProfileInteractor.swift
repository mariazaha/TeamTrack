//
//  ProfileInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import UIKit

protocol ProfileInteractorProtocol {
    func computeViewTitle() -> ()
    func computeProfileView() -> ()
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
        let viewTitle = appService?.authService?.currentUser?.displayName ?? "Profile"
        view?.set(viewTitle: viewTitle)
    }
    
    func computeProfileView() {
        switch appService?.authService?.authenticationState {
        case .authenticated:
            view?.configureSignedInState()
        default:
            view?.configureSignedOutState()
        }
    }
    
}
