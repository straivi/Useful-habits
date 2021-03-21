//
//  HabitCreatorViewController.swift
//  MyHabits
//
//  Created by  Matvey on 20.02.2021.
//

import UIKit

protocol HabitCreatorViewControllerDelegate: class {
    func didCreateHabit()
}

class HabitCreatorViewController: UIViewController {
    
    private let nameView = HabitNameFieldView()
    private let colorView = HabitColorPickerView()
    private let dateView = HabitTimePickerView()
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let habit: Habit?
    
    weak var delegate: HabitCreatorViewControllerDelegate?
    
    var onUpdate: (() -> Void)?
    
    init() {
        self.habit = nil
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupBarButtonItems()
        title = "Создать"
    }
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupBarButtonItems()
        title = "Править"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
    }
    
    private func setupViews() {
        
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
        
        view.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        let deleteConstraints = [
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints + deleteConstraints)
        
        nameView.delegate = self
        colorView.delegate = self
        
        if habit == nil {
            deleteButton.isHidden = true
        }
    }
    
    //MARK: setup Actions
    private func setupBarButtonItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        let saveItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabit))
        if habit != nil {
            saveItem.action = #selector(updateHabit)
        }
        navigationItem.rightBarButtonItem = saveItem
        deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
    }
    
    @objc private func saveHabit() {
        print("save habit")
        let habit = Habit(name: nameView.name, date: dateView.datePicker.date, color: colorView.selectedColor ?? .purple)
        HabitsStore.shared.habits.append(habit)
        self.delegate?.didCreateHabit()
        self.dismiss(animated: true) {
            self.nameView.clear()
            self.colorView.clear()
            self.dateView.clear()
        }
    }
    
    @objc private func cancel() {
        print("cancel habit")
        self.dismiss(animated: true) {
            self.nameView.clear()
            self.colorView.clear()
            self.dateView.clear()
        }
    }
    
    @objc private func updateHabit() {
        guard let habit = habit else { return }
        habit.name = nameView.name
        habit.color = colorView.selectedColor ?? .purple
        habit.date = dateView.datePicker.date
        if let onUpdate = onUpdate { onUpdate() }
        self.dismiss(animated: true) {
            self.nameView.clear()
            self.colorView.clear()
            self.dateView.clear()
        }
        print("habit was update")
        
    }
    
    @objc private func deleteHabit() {
        guard let habit = habit,
              let index = HabitsStore.shared.habits.firstIndex(of: habit) else { return }
        HabitsStore.shared.habits.remove(at: index)
        
        print("habit was deleted")
        self.dismiss(animated: true) {
            self.nameView.clear()
            self.colorView.clear()
            self.dateView.clear()
//            guard let parent = self.parent?.parent?.navigationController else {
//                print("not nav")
//                return }
//            parent.popToRootViewController(animated: true)
        }
        if let onUpdate = onUpdate { onUpdate() }
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
