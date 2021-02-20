//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by  Matvey on 16.02.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private let tableView = UITableViewController()
    private let habitCreatorViewController = HabitCreatorViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBarButtonItems()
    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(createHabit))
    }
    
    @objc private func createHabit() {
        print("create habbit")
        let creatorNavigation = UINavigationController(rootViewController: habitCreatorViewController)
        present(creatorNavigation, animated: true)
    }

    
    private func setupViews() {
        view.backgroundColor = .yellow
        
        addChild(tableView)
        view.addSubview(tableView.view)
        tableView.didMove(toParent: self)
    }
}
