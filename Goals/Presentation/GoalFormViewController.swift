//
//  GoalFormViewController.swift
//  Goals
//
//  Created by mihail on 28.09.2023.
//

import UIKit
protocol GoalFormDelegate {
    
}

final class GoalFormViewController: UIViewController, GoalFormDelegate {
    //MARK: - IB Outlets
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalDaysLabel: UILabel!
    @IBOutlet weak var goalFormField: UITextField!
    @IBOutlet weak var dayFormField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    //MARK: - Overrides Methods
    override func viewDidLoad() {
        initSetup()
    }
    
    //MARK: - IB Action
    @IBAction func onDoneButton(_ sender: Any) {
        guard let numDays = dayFormField.text else { return }
        guard let text = goalFormField.text else { return }
        GoalFactory.instance.addNewGoal(name: text,
                                        days: Int(numDays) ?? 0)
    }
    
    //MARK: - Privates Methods
    private func initSetup() {
        goalLabel.text = "Цель"
        goalLabel.font = UIFont.boldSystemFont(ofSize: 25)
        goalLabel.numberOfLines = 2
        goalDaysLabel.text = "Введите количество дней"
        goalDaysLabel.font = UIFont.boldSystemFont(ofSize: 25)
        goalDaysLabel.numberOfLines = 2
        
        goalFormField.placeholder = "Введите вашу цель.."
        dayFormField.placeholder = "0"
        
        doneButton.setTitle("Добавить", for: .normal)
    }
}
