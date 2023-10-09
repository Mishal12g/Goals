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
    
    func getTarget(_ index: Int) {
        viewControllerDelegate?.didReceiveGoal(goal: goals[index])
    }
    
    func addDescription(_ str: String) {
        statistic?.goals?[viewControllerDelegate?.index ?? 0].days[viewControllerDelegate?.indexPath ?? 0].description = str
    }
    
    func deleteGoal() {
        if !(statistic?.goals?.isEmpty ?? false) {
            statistic?.goals?[viewControllerDelegate?.index ?? 0].days.removeAll()
            statistic?.goals?.remove(at: viewControllerDelegate?.index ?? 0)
        }
    }
    
    func addNewGoal(name goalString: String, days countDays: Int) {
        statistic?.name = goalString
        statistic?.days = addDays(countDays)
        let newGoal = Goal(name: statistic?.name ?? "", description: nil, days: statistic?.days ?? [] )
        
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
