//
//  InfoNavigationController.swift
//  MyHabits
//
//  Created by  Matvey on 18.02.2021.
//

import UIKit

class InfoNavigationController: UIViewController {
    
    let navCV = UINavigationController()
    let infoViewController = InfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
        
    private func setupController() {
        addChild(navCV)
        view.addSubview(navCV.view)
        
        navCV.setViewControllers([infoViewController], animated: false)
    }
}
