//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by  Matvey on 12.03.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let habit: Habit
    
    var onUpdate: (() -> Void)?
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupBarButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViews() {
        var constraints: [NSLayoutConstraint] = []
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        constraints += tableConstraints
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupBarButtons() {
        let editButton = UIButton(type: .system)
        editButton.setTitle("Править", for: .normal)
        editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        let editBarItem = UIBarButtonItem(customView: editButton)
        navigationItem.rightBarButtonItem = editBarItem
    }
    
    @objc private func editAction() {
        let vc = HabitCreatorViewController(habit: habit)
        vc.onUpdate = self.onUpdate
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
}

//MARK: UITableViewDataSource
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: .zero)
        let dates: [Date] = {
            var list = HabitsStore.shared.dates
            list.reverse()
            return list
        }()
        let date = dates[indexPath.row]
        let isTracked = HabitsStore.shared.habit(habit, isTrackedIn: date)
        cell.textLabel?.text = DateConverter.dateToString(date)
        if isTracked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Активность"
    }
}

//MARK: UITableViewDelegate
extension HabitDetailsViewController: UITableViewDelegate {
    
}
