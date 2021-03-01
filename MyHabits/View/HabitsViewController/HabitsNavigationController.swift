//
//  HabitsNavigationController.swift
//  MyHabits
//
//  Created by  Matvey on 16.02.2021.
//

import UIKit

class HabitsNavigationController: UIViewController {
    
    let navCV = UINavigationController()
    let habitsViewController = HabitsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        habitsViewController.title = "Сегодня"
        navCV.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navCV.navigationBar.scrollEdgeAppearance = appearance
    }
    
        
    private func setupController() {
        addChild(navCV)
        view.addSubview(navCV.view)
        navCV.setViewControllers([habitsViewController], animated: false)
    }
}
