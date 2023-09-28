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
    private var goals: [Goal] = [Goal(name: "диета 30 дней",
                                      discription: "в",
                                      days: 30,
                                      state: .isNotDone),
                                 Goal(name: "Читать",
                                      discription: "read",
                                      days: 7,
                                      state: .isCurrent),
                                 Goal(name: "Занятия по программированию",
                                      discription: "learning",
                                      days: 2,
                                      state: .isNotDone),
                                 Goal(name: "Пробежка на 21 день",
                                      discription: "",
                                      days: 21,
                                      state: .isCurrent)]
    
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
        goals.append(Goal(name: goalString, discription: "", days: countDays, state: .isCurrent))
        viewControllerDelegate?.didReceiveNextGoal(goal: goals.last)
    }
}
