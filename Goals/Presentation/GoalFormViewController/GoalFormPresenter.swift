//
//  GoalFormPresenter.swift
//  Goals
//
//  Created by mihail on 11.10.2023.
//

import Foundation

final class GoalFormPresenter {
    
    //MARK: - Privates properties
    private var viewControllerDelegate: GoalFactoryDelegate?
    private let goalFactory = GoalFactory.instance
    
    //MARK: - Init
    init() {
        self.viewControllerDelegate = goalFactory.viewControllerDelegate
    }
    
    //MARK: - Public methods
    func addNewGoal(name goalString: String, days countDays: Int) {
        guard let statistic = goalFactory.statistic else { return }
        statistic.name = goalString
        statistic.days = addDays(countDays)
        let newGoal = Goal(name: statistic.name ?? "", description: nil, days: statistic.days ?? [] )
        
        statistic.store(goal: newGoal)
        
        viewControllerDelegate?.didShowLastGoal(index: goalFactory.goalsCount - 1)
    }
    
    //MARK: - Privates methods
    private func addDays(_ num: Int) -> [Day] {
        var array: [Day] = []
        for _ in 1...num {
            array.append(Day())
        }
        return array
    }
}
