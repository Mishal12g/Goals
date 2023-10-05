//
//  ViewController.swift
//  Goals
//
//  Created by mihail on 22.09.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GoalFactoryDelegate {
    
    //MARK: - IB Outlets
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var goalsIndexLabel: UILabel!
    @IBOutlet weak var goalNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Privates property
    private let goalFactory = GoalFactory.instance
    private var index = 0
    
    //MARK: - Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()
        goalFactory.viewControllerDelegate = self
        goalNameLabel.text = nil
        goalsIndexLabel.text = nil
        displaySettingsGoals()
        setupCollectionView()
    }
    
    //MARK: - IB Actions methods
    @IBAction func onRightButton(_ sender: Any) {
        if goalFactory.goalsCount != 0 {
            index = min(index + 1, goalFactory.goalsCount - 1)
            goalFactory.nextStepGoal(index: index)
            collectionView.reloadData()
        }
    }
    
    @IBAction func onLeftButton(_ sender: Any) {
        if goalFactory.goalsCount != 0 {
            index = max(index - 1, 0)
            goalFactory.backStepGoal(index: index)
            collectionView.reloadData()
        }
    }
    
    func showLastGoal(index: Int) {
        self.index = index
        let indexTotal = goalFactory.goalsCount
        goalFactory.nextStepGoal(index: self.index)
        goalsIndexLabel.text = "\(self.index + 1)/\(indexTotal)"
        collectionView.reloadData()
    }
        
    //MARK: Privates Methods
    private func convert(goal: Goal) -> GoalModelView {
        let modelView = GoalModelView(name: goal.name,
                                      description: goal.discription ?? "",
                                      days: goal.days)
        
        return modelView
    }
    
    private func show(_ modelView: GoalModelView) {
        let indexTotal = goalFactory.goalsCount
        goalsIndexLabel.text = "\(index+1)/\(indexTotal)"
        goalNameLabel.text = modelView.name
        goalFactory.statistic?.days = modelView.days
    }
    
    private func displaySettingsGoals() {
        startLabel.isHidden = true
        startLabel.text = "Нет целей.."
        startLabel.font = UIFont.systemFont(ofSize: 30)
        if goalFactory.goalsCount != 0 {
            goalFactory.backStepGoal(index: index)
        } else {
            startLabel.isHidden = false
        }
    }
    
    //MARK: - Setup collection view
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.size.width/3.5,
                                 height: collectionView.frame.size.width/3.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    //MARK: Delegates
    //MARK: - GoalFactoryDelegate
    func didReceiveGoal(goal: Goal?) {
        guard let goal = goal else {
            goalNameLabel.text = "Нет Целей"
            return
        }
        
        show(convert(goal: goal))
    }
    
    //MARK: - Collection View delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goalFactory.statistic?.days?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LabelCollectionViewCell else {
            return LabelCollectionViewCell()
        }
        
        cell.label.font = .boldSystemFont(ofSize: 40)
        
        switch goalFactory.statistic?.days?[indexPath.item].state {
        case .isNotDone:
            cell.backgroundColor = .red
        case .isDone:
            cell.backgroundColor = .green
        case .isCurrent:
            cell.backgroundColor = .yellow
        case .isNotCurrent:
            cell.backgroundColor = .gray
        case .none:
            cell.backgroundColor = .black
        }
        
        cell.label.text = "\(indexPath.row + 1)"
        cell.layer.cornerRadius = 10
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Нажата ячейка в секции \(indexPath.section), элемент \(indexPath.item + 1)")
//        goalFactory.statistic?.goals?[index].days[indexPath.item].state = .isCurrent
//        goalFactory.getTarget(index)
//        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, 
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            let isDone = UIAction(title: "Выполнена", identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self.goalFactory.statistic?.goals?[self.index].days[indexPath.item].state = .isDone
                self.goalFactory.getTarget(self.index)
                collectionView.reloadData()
            }
            
            let isNotdone = UIAction(title: "Не выполнена", identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self.goalFactory.statistic?.goals?[self.index].days[indexPath.item].state = .isNotDone
                self.goalFactory.getTarget(self.index)
                collectionView.reloadData()
            }

            
            return UIMenu(title: "",
                          image: nil, 
                          identifier: nil,
                          options: UIMenu.Options.displayInline,
                          children: [isDone, isNotdone])
        }
        return config
    }
}

