//
//  FactoryTarget.swift
//  Goals
//
//  Created by mihail on 23.09.2023.
//

import Foundation

final class GoalFactory {
    //MARK: Public properties
    let statistic: StatisticService?
    
    //MARK: Init
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
    
    var goals: [Goal?] {
        get {
            statistic?.goals ?? []
        }
    }
    
    //MARK: - Public methods
    func requestNextGoal(index: Int) {
        guard let goal = goals[index] else { return }
        
        viewControllerDelegate?.didReceiveGoal(goal: goal)
    }
}
