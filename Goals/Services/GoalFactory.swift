//
//  FactoryTarget.swift
//  Goals
//
//  Created by mihail on 23.09.2023.
//

import Foundation
import UIKit

protocol GoalFactoryDelegate {
    func didReceiveNextGoal(goal: Goal?)
    func showLastGoal(index: Int)
    var startLabel: UILabel! { get set }
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
        let newGoal = Goal(name: goalString, discription: nil, days: addDays(countDays) )
        
        statistic.store(goal: newGoal)
        viewControllerDelegate?.didReceiveNextGoal(goal: self.goals.last ?? nil)
        viewControllerDelegate?.showLastGoal(index: goals.count - 1)
    }
    
    func addDays(_ num: Int) -> [Day?] {
        viewControllerDelegate?.startLabel.isHidden = true
        var array: [Day] = []
        for _ in 1...num {
            array.append(Day())
        }
        
        return array
    }
}
