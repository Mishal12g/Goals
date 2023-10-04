//
//  FactoryTarget.swift
//  Goals
//
//  Created by mihail on 23.09.2023.
//

import Foundation

protocol GoalFactoryDelegate {
    func didReceiveNextGoal(goal: Goal?)
}

final class GoalFactory {
    let statistic = StatisticService()

    //MARK: - Public properties
    static var instance: GoalFactory = GoalFactory()
    
    var goalsCount: Int {
        get {
            goals.count
        }
    }
    
    //MARK: - Privates properties
    var viewControllerDelegate: GoalFactoryDelegate?
    //TODO: Исправить ошибку с нулевым значением.
    private var goals: [Goal?] {
        get {
            statistic.goals ?? []
        }
    }
    
    //MARK: Public methods
    func nextStepGoal(index: Int) {
        let currentGoal =  goals[index]
        viewControllerDelegate?.didReceiveNextGoal(goal: currentGoal)
    }
    
    func backStepGoal(index: Int) {
        let currentGoal =  goals[index]
        viewControllerDelegate?.didReceiveNextGoal(goal: currentGoal)
    }
    
    func addNewGoal(name goalString: String, days countDays: Int) {
        statistic.store(goals: [Goal(name: goalString, discription: "dsa", days: addDays(countDays) )])
        print(statistic.goals ?? "")
        viewControllerDelegate?.didReceiveNextGoal(goal: goals.first ?? nil)
    }
    
    func addDays(_ num: Int) -> [Day?] {
        var array: [Day] = []
        for _ in 1...num {
            array.append(Day())
        }
        
        return array
    }
}
