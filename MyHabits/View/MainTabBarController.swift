//
//  MainTabBarController.swift
//  MyHabits
//
//  Created by  Matvey on 16.02.2021.
//

import UIKit

class MainTabBarController: UIViewController {
    
    let tabBar = UITabBarController()
    let habitsController = HabitsNavigationController()
    let infoController = InfoNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        addChild(tabBar)
        view.addSubview(tabBar.view)
        habitsController.tabBarItem = UITabBarItem(title: "Habits", image: AppImage.habitsTabIcon, tag: 1)
        infoController.tabBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle.fill"), tag: 2)
        tabBar.viewControllers = [habitsController, infoController]
    }
}
