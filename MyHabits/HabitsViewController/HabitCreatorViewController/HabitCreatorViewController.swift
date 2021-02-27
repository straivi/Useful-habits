//
//  HabitCreatorViewController.swift
//  MyHabits
//
//  Created by  Matvey on 20.02.2021.
//

import UIKit

class HabitCreatorViewController: UIViewController {
    
    private let nameView = HabitNameFieldView()
    private let colorView = HabitColorPickerView()
    private let dateView = HabitTimePickerView()
    
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
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]
        
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(colorView)
        stackView.addArrangedSubview(dateView)
        
        NSLayoutConstraint.activate(stackViewConstraints)
        
        nameView.delegate = self
        colorView.delegate = self
    }
    
    private func setupBarButtonItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Схранить",
                                                            style: .done,
                                                           target: self,
                                                           action: #selector(saveHabit))
    }
    
    @objc private func saveHabit() {
        print("save habit")
        let habit = Habit(name: nameView.name, date: Date(), color: colorView.selectedColor ?? .purple)
        print(habit.name, habit.date, habit.color)
        HabitsStore.shared.habits.append(habit)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancel() {
        print("cancel habit")
        self.dismiss(animated: true, completion: nil)
    }
}

extension HabitCreatorViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorView.selectedColor = viewController.selectedColor
    }
}

extension HabitCreatorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
