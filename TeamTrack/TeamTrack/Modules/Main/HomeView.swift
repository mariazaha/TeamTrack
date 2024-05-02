//
//  HomeView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 01.05.2024.
//

import UIKit

class HomeView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
    }
    
    private func configureNavigation() {
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = ColorService.tintColor()
    }

}

