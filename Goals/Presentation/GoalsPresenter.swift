//
//  GoalsPresenter.swift
//  Goals
//
//  Created by mihail on 10.10.2023.
//

import Foundation

final class GoalsPresenter {
    let goalFactory = GoalFactory.instance
    var index = 0
    private let viewController: GoalsViewControllerProtocol?
    
    init(viewController: GoalsViewControllerProtocol?){
        self.viewController = viewController
        goalFactory.viewControllerDelegate = self
    }
    
    
}

extension GoalsPresenter: GoalFactoryDelegate {
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
        goalFactory.statistic?.days = modelView.days
    }
    
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
