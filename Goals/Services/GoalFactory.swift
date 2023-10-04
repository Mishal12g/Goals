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
    
    //MARK: - Public properties
    static var instance: GoalFactory = GoalFactory()
    
    var goalsCount: Int {
        get {
            goals.count
        }
    }
    
    //MARK: - Privates properties
    var viewControllerDelegate: GoalFactoryDelegate?
    private var goals: [Goal] = [  Goal(name: "Читать",
                                        discription: "read",
                                        days: [Day(discription: "sdasdas"), Day(discription: "sdasdas"), Day(discription: "sdasdas"), Day(discription: ""),Day(discription: "")]),
                                   Goal(name: "Занятия по программированию",
                                        discription: "learning",
                                        days:[Day(discription: ""), Day(discription: ""),Day(discription: ""),Day(discription: "")]),
                                   Goal(name: "Пробежка на 21 день",
                                        discription: "",
                                        days: [Day(state: .isDone, discription: ""),Day( discription: "")])]
    
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
        viewControllerDelegate?.didReceiveNextGoal(goal: goals.last)
    }
}
