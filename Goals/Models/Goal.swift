//
//  Target.swift
//  Goals
//
//  Created by mihail on 23.09.2023.
//

import Foundation

struct Goal {
    let name: String
    let discription: String
    let days: Int
    var state: TargetState
}

enum TargetState {
    case isNotDone, isDone, isCurrent
}
