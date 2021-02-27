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
        title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = AppColor.systemBackground
        let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let progressView = ProgressView()
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
}
