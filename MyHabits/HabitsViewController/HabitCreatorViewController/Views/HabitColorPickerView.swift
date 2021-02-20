//
//  HabitColorPickerView.swift
//  MyHabits
//
//  Created by  Matvey on 20.02.2021.
//

import UIKit

class HabitColorPickerView: UIView {
    
    weak var delegate: UIColorPickerViewControllerDelegate? {
        didSet {
            colorPicker.delegate = delegate
        }
    }
    
    var selectedColor = AppColor.accentColor {
        didSet {
            colorPickerView.backgroundColor = selectedColor
        }
    }
    
    private let colorPicker = UIColorPickerViewController()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "ЦВЕТ"
        label.textAlignment = .left
        return label
    }()
    
    private let colorPickerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        self.addSubview(colorPickerView)
        colorPickerView.translatesAutoresizingMaskIntoConstraints = false
        let colorPickerViewConstraints = [
            colorPickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            colorPickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorPickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            colorPickerView.heightAnchor.constraint(equalToConstant: 30),
            colorPickerView.widthAnchor.constraint(equalTo: colorPickerView.heightAnchor)
        ]
        colorPickerView.backgroundColor = selectedColor
        
        NSLayoutConstraint.activate(titleLabelConstraints + colorPickerViewConstraints)
    }
    
    private func setupActions() {
        colorPickerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openColorPicker)))
    }
    
    @objc private func openColorPicker() {
        guard let vc = delegate as? UIViewController else { return }
        vc.present(colorPicker, animated: true)
    }
}
