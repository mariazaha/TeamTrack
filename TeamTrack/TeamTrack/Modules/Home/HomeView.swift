//
//  HomeView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 01.05.2024.
//

import UIKit

class HomeView: UIViewController {
    
    var presenter: HomePresenterProtocol?
    var interactor: HomeInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}

extension HomeView {
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

