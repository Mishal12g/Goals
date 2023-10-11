//
//  FactoryTarget.swift
//  Goals
//
//  Created by mihail on 23.09.2023.
//

import Foundation

final class GoalFactory {
    //MARK: Public properties
    let dataSource: DataSource?
    
    //MARK: Init
    init(statistic: DataSource?) {
        self.dataSource = statistic
    }
    
    //MARK: - Public properties
    static var instance: GoalFactory = GoalFactory(statistic: DataSource())
    var viewControllerDelegate: GoalFactoryDelegate?
    
    var goalsCount: Int {
        get {
            goals.count
        }
    }
    
    var goals: [Goal?] {
        get {
            dataSource?.goals ?? []
        }
    }
    
    //MARK: - Public methods
    func requestNextGoal(index: Int) {
        guard let goal = goals[index] else { return }
        
        viewControllerDelegate?.didReceiveGoal(goal: goal)
    }
}
