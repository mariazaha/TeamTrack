//
//  TabBarController.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/1/24.
//

import UIKit

class TabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(tabs: Tabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.home, tabs.profile]
        configureTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemeneted")
    }
    
    private func configureTabBar() {
        tabBar.isTranslucent = true
        tabBar.backgroundColor = ColorService.systemBackground()
        tabBar.tintColor = ColorService.tintColor()
        tabBar.shadowImage = UIImage()
    }
    
}
