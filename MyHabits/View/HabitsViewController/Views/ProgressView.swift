//
//  ProgressView.swift
//  MyHabits
//
//  Created by  Matvey on 21.02.2021.
//

import UIKit

class ProgressView: UICollectionReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.text = "Всё получится!"
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return label
    }()
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.text = "0%"
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        if let subleyer = view.layer.sublayers?[1] {
            subleyer.cornerRadius = 4
        }
        view.subviews[1].clipsToBounds = true
        view.backgroundColor = AppColor.systemFill
        return view
    }()
    
    var percent: Float = 0 {
        didSet {
            percentLabel.text = "\(Int((percent * 100).rounded()))%"
            self.progressBar.progress = percent
        }
    }
    
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
        
        self.addSubview(percentLabel)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        let percentLabelConstraints = [
            percentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            percentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ]
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: percentLabel.leadingAnchor),
        ]
        
        self.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        let progressBarConstraints = [
            progressBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ]
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3.5)
        
        NSLayoutConstraint.activate(titleLabelConstraints + percentLabelConstraints + progressBarConstraints)
    }
}
