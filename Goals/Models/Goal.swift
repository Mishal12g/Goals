//
//  Target.swift
//  Goals
//
//  Created by mihail on 23.09.2023.
//

import Foundation

struct Goal: Codable {
    let name: String
    var description: String?
    var days: [Day]
   
}

struct Day: Codable {
    var state: TargetState
    var description: String?
    
    init(state: TargetState = .isNotCurrent) {
        self.state = state
    }
    
}

enum TargetState: Codable {
    case isNotDone, isDone, isCurrent, isNotCurrent
}
