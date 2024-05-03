//
//  ForgotPasswordView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 03.05.2024.
//

import UIKit

class ForgotPasswordView : UIViewController {
    var presenter: ForgotPasswordPresenterProtocol?
    var interactor: ForgotPasswordInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}
extension ForgotPasswordView {
    private func configureNavigation () {
        view.backgroundColor = ColorService.systemBackground()
    }
    private func configureView(){
        interactor?.computeViewTitle()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = ColorService.tintColor()
    }
    
    func set(viewTitle: String) {
        title = viewTitle
    }
}
