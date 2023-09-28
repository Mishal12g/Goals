//
//  GoalFactoryProtocol.swift
//  Goals
//
//  Created by mihail on 28.09.2023.
//

import Foundation

protocol GoalFactoryProtocol {
    func nextStepGoal(index: Int)
    func backStepGoal(index: Int)
}
