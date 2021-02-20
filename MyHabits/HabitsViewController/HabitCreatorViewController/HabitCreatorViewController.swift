//
//  HabitCreatorViewController.swift
//  MyHabits
//
//  Created by  Matvey on 20.02.2021.
//

import UIKit

class HabitCreatorViewController: UIViewController {
    
    private let nameView = NameTextFieldView()
    
    override func viewDidLoad() {
        setupViews()
        setupBarButtonItems()
    }
    
    private func setupViews() {
        title = "Создать"
        view.backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        stackView.addArrangedSubview(nameView)
        
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    private func setupBarButtonItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Схранить",
                                                            style: .done,
                                                           target: self,
                                                           action: #selector(saveHabit))
    }
    
    @objc private func saveHabit() {
        print("create habit")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancel() {
        print("cancel habit")
        self.dismiss(animated: true, completion: nil)
    }
}
