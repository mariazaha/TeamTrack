//
//  AccountSettingsView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
//

import UIKit

class AccountSettingsView : UIViewController {
    var presenter: AccountSettingsPresenterProtocol?
    var interactor: AccountSettingsInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}

extension AccountSettingsView {
    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
    }
    
    private func configureNavigation() {
        interactor?.computeViewTitle()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = ColorService.tintColor()
    }
    
    func set(viewTitle: String) {
        title = viewTitle
    }
    
}



