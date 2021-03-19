//
//  HabitTimePickerView.swift
//  MyHabits
//
//  Created by  Matvey on 20.02.2021.
//

import UIKit

class HabitTimePickerView: UIView {
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "ВРЕМЯ"
        label.textAlignment = .left
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "Каждый день в "
        label.textAlignment = .left
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .inline
        return picker
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(titlelabel)
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titlelabel.topAnchor.constraint(equalTo: self.topAnchor),
            titlelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titlelabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        self.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        let pickerContraints = [
            datePicker.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 5),
            datePicker.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor)
        ]
        
        self.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        let textLabelConctraints = [
            textLabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 7),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: datePicker.leadingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints + pickerContraints + textLabelConctraints)
    }
    
    func clear() {
        datePicker.setDate(Date(), animated: false)
    }
}
