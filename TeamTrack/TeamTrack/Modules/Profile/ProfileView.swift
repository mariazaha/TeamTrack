//
//  ProfileView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import UIKit

class ProfileView: UIViewController {

    var presenter: ProfilePresenterProtocol?
    var interactor: ProfileInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

}

extension ProfileView {
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
