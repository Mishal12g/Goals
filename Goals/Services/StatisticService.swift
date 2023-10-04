//
//  StatisticService.swift
//  Goals
//
//  Created by mihail on 04.10.2023.
//

import Foundation

final class StatisticService {
    
//    var name: String? {
//        get {
//            UserDefaults.standard.string(forKey: Keys.name.rawValue)
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: Keys.name.rawValue)
//        }
//    }
//    
//    var days: [Day]? {
//        get {
//            UserDefaults.standard.array(forKey: "goals") as? [Day]
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: Keys.days.rawValue)
//        }
//
//    }
    
    var goals: [Goal]? {
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.goals.rawValue),
                  let record = try? JSONDecoder().decode([Goal].self, from: data) else {
                return nil
            }
            return record
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            UserDefaults.standard.setValue(data, forKey: Keys.goals.rawValue)
        }
    }
    
    func store(goals: [Goal]) {
        guard let current = self.goals else { return }
        self.goals = current + goals
    }
    
    private enum Keys: String {
        case goals
    }
}
