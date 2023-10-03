//
//  ViewController.swift
//  Goals
//
//  Created by mihail on 22.09.2023.
//

import UIKit

class ViewController: UIViewController, GoalFactoryDelegate {
    
    //MARK: - IB Outlets
    @IBOutlet weak var goalsIndexLabel: UILabel!
    @IBOutlet weak var goalNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Privates property
    private let buttonCellIdentifier = "Cell"
    private let goalFactory = GoalFactory.instance
    private var index = 0
    
    //MARK: - Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()
        goalFactory.viewControllerDelegate = self
        goalNameLabel.text = nil
        goalsIndexLabel.text = nil
        goalFactory.backStepGoal(index: index)
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
}

