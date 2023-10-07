//
//  GoalFactoryDelegate.swift
//  Goals
//
//  Created by mihail on 06.10.2023.
//

import UIKit

protocol GoalFactoryDelegate {
    func didReceiveGoal(goal: Goal?)
    func showLastGoal(index: Int)
    var startLabel: UILabel! { get set }
    var index: Int { get }
    var indexPath: Int { get }
}
