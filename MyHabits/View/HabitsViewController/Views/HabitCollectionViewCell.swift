//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by  Matvey on 01.03.2021.
//

import UIKit

struct HabitCellModel {
    var title: String
    var timeToRepeatText: String
    var dayCountsText: String
    var tintColor: UIColor
}

class HabitCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "Привычка"
        return label
    }()
    
    private let timeToRepeatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Каждый день в 00:00"
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()
    
    private let repeatCountsTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "Подряд: 0"
        label.textAlignment = .left
        label.textColor = .systemGray2
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(pointSize: 36)
        button.setImage(UIImage(systemName: "circle", withConfiguration: config), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: config), for: .selected)
        button.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: config), for: .highlighted)
        button.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: config), for: .disabled)
        button.tintColor = .darkText
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let viewConstraints = [self.heightAnchor.constraint(equalToConstant: 130)]
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -88)
        ]
        
        self.addSubview(timeToRepeatLabel)
        timeToRepeatLabel.translatesAutoresizingMaskIntoConstraints = false
        let repeatTimeLabelConstraints = [
            timeToRepeatLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            timeToRepeatLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeToRepeatLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ]
        
        self.addSubview(repeatCountsTitle)
        repeatCountsTitle.translatesAutoresizingMaskIntoConstraints = false
        let repeatCountConstraints = [
            repeatCountsTitle.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            repeatCountsTitle.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            repeatCountsTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ]
        
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonConstraints = [
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 47),
            button.heightAnchor.constraint(equalToConstant: 36),
            button.widthAnchor.constraint(equalToConstant: 36),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -26),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -47)
        ]
        
        NSLayoutConstraint.activate(viewConstraints + titleConstraints + repeatTimeLabelConstraints + repeatCountConstraints + buttonConstraints)
    }
    
    func configure(_ model: HabitCellModel) {
        titleLabel.text = model.title
        timeToRepeatLabel.text = model.timeToRepeatText
        repeatCountsTitle.text = model.dayCountsText
        titleLabel.textColor = model.tintColor
        button.tintColor = model.tintColor
    }
}
