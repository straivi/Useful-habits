//
//  HabitNameFieldView.swift
//  MyHabits
//
//  Created by  Matvey on 20.02.2021.
//

import UIKit

class HabitNameFieldView: UIView {
    
    weak var delegate: UITextFieldDelegate? {
        didSet {
            nameTextField.delegate = delegate
        }
    }
    
    var name: String {
        get {
            guard let name = nameTextField.text,
                  name != "" else { return "Новая привычка" }
            return name
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "НАЗВАНИЕ"
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        textField.placeholder = "Пить воду, моргать, дышать и т.п."
        textField.borderStyle = .none
        return textField
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(nameLabel)
        self.addSubview(nameTextField)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        let nameTextFieldConstraints = [
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(nameLabelConstraints + nameTextFieldConstraints)
    }
    
    func clear() {
        nameTextField.text?.removeAll()
    }
}
