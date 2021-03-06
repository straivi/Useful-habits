//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by  Matvey on 16.02.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private static let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = .zero
        return layout
    }()
    private let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: collectionLayout)
        collection.contentInset = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
        return collection
    }()
    private let habitCreatorViewController = HabitCreatorViewController()
    
    private let itemInRow = 1
    private let contentInset = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
    private let sectionInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBarButtonItems()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProgressView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ProgressView.self))
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        habitCreatorViewController.delegate = self
    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(createHabit))
    }
    
    @objc
    private func createHabit() {
        let creatorNavigation = UINavigationController(rootViewController: habitCreatorViewController)
        present(creatorNavigation, animated: true)
    }
    
    private func setupViews() {
        collectionView.backgroundColor = AppColor.systemBackground
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    
    private func createCellModel(habit: Habit) -> HabitCellModel {
        let closure = { [weak habit, weak self] in
            guard let habit = habit else { return }
            HabitsStore.shared.track(habit)
            self?.collectionView.reloadData()
        }
        
        let cellModel = HabitCellModel(title: habit.name, timeToRepeatText: habit.dateString, dayCountsText: "Подряд: \(habit.trackDates.count)", tintColor: habit.color, isAlreadyTakenToday: habit.isAlreadyTakenToday, onTake: closure)
        return cellModel
    }
}

//MARK: UICollectionViewDataSource
extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabitsStore.shared.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
        let habit = HabitsStore.shared.habits[indexPath.row]
        let model = createCellModel(habit: habit)
        cell.configure(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ProgressView.self), for: indexPath) as? ProgressView else {
            return UICollectionReusableView()
        }
        headerView.percent = HabitsStore.shared.todayProgress
        return headerView
    }
}

//MARK: UICollectionViewDelegate
extension HabitsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HabitDetailsViewController(habit: HabitsStore.shared.habits[indexPath.row])
        vc.title = HabitsStore.shared.habits[indexPath.row].name
        let closure: (() -> Void)? = { [weak self] in
            HabitsStore.shared.save()
            self?.collectionView.reloadData()
            self?.navigationController?.popToRootViewController(animated: true)
        }
        vc.onUpdate = closure
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

            let indexPath = IndexPath(row: 0, section: section)
            let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
            return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.frame.width - contentInset.right - CGFloat(itemInRow) * contentInset.left
        return CGSize(width: availableWidth, height: 130)
    }
}

//MARK: HabitCreatorViewControllerDelegate
extension HabitsViewController: HabitCreatorViewControllerDelegate {
    func didCreateHabit() {
        collectionView.reloadData()
    }
}
