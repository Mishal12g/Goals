//
//  StatisticService.swift
//  Goals
//
//  Created by mihail on 04.10.2023.
//

import Foundation

final class StatisticService {
    
    var name: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.name.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.name.rawValue)
        }
    }
    
    var days: [Day]? {
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.days.rawValue),
                  let record = try? JSONDecoder().decode([Day].self, from: data) else {
                return nil
            }
            return record
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            UserDefaults.standard.setValue(data, forKey: Keys.days.rawValue)
        }
    }
    
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
    
    func store(goal: Goal) {
        if var current = self.goals {
            current.append(goal)
            self.goals? = current
        } else {
            var array: [Goal] = []
            array.append(goal)
            self.goals = array
        }
        
    }
    
    private enum Keys: String {
        case goals, days, name
    }
}
