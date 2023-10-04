//
//  ViewController.swift
//  Goals
//
//  Created by mihail on 22.09.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GoalFactoryDelegate {
    
    //MARK: - IB Outlets
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
        goalFactory.backStepGoal(index: index)
        setupCollectionView()
    }
    
    //MARK: - IB Actions methods
    @IBAction func onRightButton(_ sender: Any) {
        
        index = min(index + 1, goalFactory.goalsCount - 1)
        goalFactory.nextStepGoal(index: index)
    }
    
    @IBAction func onLeftButton(_ sender: Any) {
        index = max(index - 1, 0)
        goalFactory.backStepGoal(index: index)
        
    }
    
    //MARK: - Public Methods
    //MARK: - GoalFactoryDelegate
    func didReceiveNextGoal(goal: Goal?) {
        guard let goal = goal else { return }
        
        show(convert(goal: goal))
    }
    
    func convert(goal: Goal) -> GoalModelView {
        let modelView = GoalModelView(name: goal.name,
                                      description: goal.discription,
                                      days: goal.days)
        
        return modelView
    }
    
    func show(_ modelView: GoalModelView) {
        let indexTotal = goalFactory.goalsCount
        goalsIndexLabel.text = "\(index+1)/\(indexTotal)"
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
    
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LabelCollectionViewCell else {
            return LabelCollectionViewCell()
        }
        //        cell.button.setTitle("\(indexPath.row + 1)", for: .normal)
        cell.label.font = .boldSystemFont(ofSize: 40)
        cell.backgroundColor = .black
        cell.label.text = "\(indexPath.row + 1)"
        cell.layer.cornerRadius = 10
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Нажата ячейка в секции \(indexPath.section), элемент \(indexPath.item + 1)")
    }
}

