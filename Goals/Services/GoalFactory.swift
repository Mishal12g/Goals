//
//  FactoryTarget.swift
//  Goals
//
//  Created by mihail on 23.09.2023.
//

import Foundation
import UIKit

protocol GoalFactoryDelegate {
    func didReceiveGoal(goal: Goal?)
    func showLastGoal(index: Int)
    var startLabel: UILabel! { get set }
}

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
    
    //MARK: Public methods
    func nextStepGoal(index: Int) {
        let currentGoal =  goals[index]
        viewControllerDelegate?.didReceiveGoal(goal: currentGoal)
    }
    
    func backStepGoal(index: Int) {
        let currentGoal =  goals[index]
        viewControllerDelegate?.didReceiveGoal(goal: currentGoal)
    }
    
    func getTarget(_ index: Int) {
        viewControllerDelegate?.didReceiveGoal(goal: goals[index])
    }
    
    func addNewGoal(name goalString: String, days countDays: Int) {
        statistic?.name = goalString
        statistic?.days = addDays(countDays)
        let newGoal = Goal(name: statistic?.name ?? "", discription: nil, days: statistic?.days ?? [] )
        
        statistic?.store(goal: newGoal)
        viewControllerDelegate?.didReceiveGoal(goal: self.goals.last ?? nil)
        viewControllerDelegate?.showLastGoal(index: goals.count - 1)
    }
    
    //MARK: Privates Methods
    private func addDays(_ num: Int) -> [Day] {
        viewControllerDelegate?.startLabel.isHidden = true
        var array: [Day] = []
        for _ in 1...num {
            array.append(Day())
        }
        
        return array
    }
}
