//
//  Target.swift
//  Goals
//
//  Created by mihail on 23.09.2023.
//

import Foundation

struct Goal: Codable {
    let name: String
    let discription: String?
    var days: [Day]
   
}

struct Day: Codable {
    var state: TargetState
    let discription: String?
    
    init(state: TargetState = .isNotCurrent, discription: String = "") {
        self.state = state
        self.discription = discription
    }
    
}

enum TargetState: Codable {
    case isNotDone, isDone, isCurrent, isNotCurrent
}
