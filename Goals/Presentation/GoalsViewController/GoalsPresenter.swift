//
//  GoalsPresenter.swift
//  Goals
//
//  Created by mihail on 10.10.2023.
//

import Foundation

final class GoalsPresenter {
    //MARK: - Public properties
    var index = 0
    
    //MARK: - Privates properties
    private let goalFactory = GoalFactory.instance
    private let viewController: GoalsViewControllerProtocol?
    
    //MARK: - Init
    init(viewController: GoalsViewControllerProtocol?){
        self.viewController = viewController
        goalFactory.viewControllerDelegate = self
    }
}

extension GoalsPresenter {
    
    //MARK: - Public methods
    func buttonsHandlerForTransition(_ step: Bool) {
        if step {
            if goalFactory.goalsCount != 0 {
                index = min(index + 1, goalFactory.goalsCount - 1)
                goalFactory.requestNextGoal(index: index)
                viewController?.reloadData()
            }
        } else {
            if goalFactory.goalsCount != 0 {
                index = max(index - 1, 0)
                goalFactory.requestNextGoal(index: index)
                viewController?.reloadData()
            }
        }
    }
    
    func deleteGoal() {
        if index == goalFactory.goalsCount - 1 && index != 0{
            remove()
            index -= 1
            goalFactory.requestNextGoal(index: index)
        } else if goalFactory.goalsCount - 1 == 0 {
            remove()
            viewController?.changeGoalsIndexLabel(nil)
            viewController?.changeGoalNameLabel("")
            viewController?.isHidenStartLabel(hide: false)
        } else {
            remove()
            goalFactory.requestNextGoal(index: index)
        }
        
        viewController?.reloadData()
    }
    
    //MARK: - Privates methods
    private func remove() {
        if !(goalFactory.dataSource?.goals?.isEmpty ?? false) {
            goalFactory.dataSource?.goals?[index].days.removeAll()
            goalFactory.dataSource?.goals?.remove(at: index)
            goalFactory.dataSource?.days?.removeAll()
        }
    }
    
    private func convert(goal: Goal) -> GoalModelView {
        let modelView = GoalModelView(name: goal.name,
                                      description: goal.description ?? "",
                                      days: goal.days)
        
        return modelView
    }
    
    private func show(_ modelView: GoalModelView) {
        let indexTotal = goalFactory.goalsCount
        viewController?.changeGoalsIndexLabel("\(index+1)/\(indexTotal)")
        viewController?.changeGoalNameLabel(modelView.name)
        goalFactory.dataSource?.days = modelView.days
    }
}

//MARK: - GoalFactoryDelegate
extension GoalsPresenter: GoalFactoryDelegate {
    func didShowLastGoal(index: Int) {
        self.index = index
        let indexTotal = goalFactory.goalsCount
        goalFactory.requestNextGoal(index: self.index)
        viewController?.changeGoalsIndexLabel("\(self.index + 1)/\(indexTotal)")
        viewController?.reloadData()
    }
    
    func didReceiveGoal(goal: Goal?) {
        guard let goal = goal else {
            viewController?.changeGoalsIndexLabel(nil)
            return
        }
        
        show(convert(goal: goal))
    }
}
