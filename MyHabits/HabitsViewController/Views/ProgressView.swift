//
//  ProgressView.swift
//  MyHabits
//
//  Created by  Matvey on 21.02.2021.
//

import UIKit

class ProgressView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.text = "Всё получится!"
        return label
    }()
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.text = "0%"
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.progress = 0.5
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        if let subleyer = view.layer.sublayers?[1] {
            subleyer.cornerRadius = 4
        }
        view.subviews[1].clipsToBounds = true
        view.backgroundColor = AppColor.systemFill
        return view
    }()
    
    var percent: Int = 0 {
        didSet {
            percentLabel.text = "\(percent)%"
            progressBar.progress = Float(percent) / 100
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12)
        ]
        
        self.addSubview(percentLabel)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        let percentLabelConstraints = [
            percentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            percentLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ]
        
        self.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        let progressBarConstraints = [
            progressBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: percentLabel.trailingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            progressBar.heightAnchor.constraint(equalToConstant: 7)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints + percentLabelConstraints + progressBarConstraints)
    }
}
