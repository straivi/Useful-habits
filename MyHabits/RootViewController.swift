//
//  RootViewController.swift
//  MyHabits
//
//  Created by  Matvey on 15.02.2021.
//

import UIKit

class RootViewController: UIViewController {
    
    let tabBar = MainTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        addChild(tabBar)
        view.addSubview(tabBar.view)
        tabBar.didMove(toParent: self)
    }
}
