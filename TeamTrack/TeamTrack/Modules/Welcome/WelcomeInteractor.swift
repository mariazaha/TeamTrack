//
//  WelcomeInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/17/24.
//

import UIKit

protocol WelcomeInteractorProtocol {
    func computeSubtitle() -> ()
}

class WelcomeInteractor {
    private weak var view : WelcomeView?
    private var appService : AppService?
    
    init(view: WelcomeView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension WelcomeInteractor : WelcomeInteractorProtocol {
    func computeSubtitle() {
        switch appService?.authService?.currentUser?.accountType {
        case .owner:
            view?.set(subtitle: "You can now create projects and manage your team.")
        case .employee:
            view?.set(subtitle: "You will now be able to streamline your workflow and collaborate closer with your team.")
        case nil:
            return
        }
    }
}
