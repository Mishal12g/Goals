//
//  FactoryTarget.swift
//  Goals
//
//  Created by mihail on 23.09.2023.
//

import Foundation

final class GoalFactory {
    let statistic: StatisticService?
    
    init(statistic: StatisticService?) {
        self.statistic = statistic
    }
    //MARK: - Public properties
    static var instance: GoalFactory = GoalFactory(statistic: StatisticService())
    var viewControllerDelegate: GoalFactoryDelegate?
    
    var goalsCount: Int {
        get {
            goals.count
        }
    }
    
    //MARK: - Privates properties
    var goals: [Goal?] {
        get {
            statistic?.goals ?? []
        }
    }
    
    func requestNextGoal(index: Int) {
        guard let goal = goals[index] else { return }
        
        viewControllerDelegate?.didReceiveGoal(goal: goal)
    }
    
    //MARK: Public methods
    func addDescription(_ str: String) {
        statistic?.goals?[viewControllerDelegate?.index ?? 0].days[viewControllerDelegate?.indexPath ?? 0].description = str
    }
}
