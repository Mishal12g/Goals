//
//  FactoryTarget.swift
//  Goals
//
//  Created by mihail on 23.09.2023.
//

import Foundation
protocol GoalFactoryProtocol {
    func nextStepGoal(index: Int)
    func backStepGoal(index: Int)
    
    var goals: [Goal] { get }
}

protocol GoalFactoryDelegate {
    func didReceiveNextGoal(goal: Goal?)
}

final class GoalFactory: GoalFactoryProtocol {
    
    var goals: [Goal] = [Goal(name: "Run",
                                      discription: "evry day run",
                                      days: 21,
                                      state: .isNotDone),
                                 Goal(name: "read biblie",
                                      discription: "read",
                                      days: 7,
                                      state: .isCurrent),
                                 Goal(name: "Proger",
                                      discription: "learning",
                                      days: 2,
                                      state: .isNotDone)]
    
    private var delegate: GoalFactoryDelegate?
    
    //MARK: INIT
    init(delegate: GoalFactoryDelegate?) {
        self.delegate = delegate
    }
    
    //MARK: Public methods
    
    func nextStepGoal(index: Int) {
        let currentGoal =  goals[index]
        delegate?.didReceiveNextGoal(goal: currentGoal)
    }
    
    func backStepGoal(index: Int) {
        
        let currentGoal =  goals[index]
        delegate?.didReceiveNextGoal(goal: currentGoal)
        
    }
    
    
}
