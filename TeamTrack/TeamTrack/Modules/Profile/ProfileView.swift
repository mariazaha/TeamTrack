//
//  ProfileView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import UIKit

class ProfileView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
    }
    
    private func configureNavigation() {
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = ColorService.tintColor()
    }

}
