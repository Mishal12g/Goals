//
//  GoalFormViewController.swift
//  Goals
//
//  Created by mihail on 28.09.2023.
//

import UIKit

protocol GoalFormDelegate {
    
}

final class GoalFormViewController: UIViewController, GoalFormDelegate, UITextFieldDelegate {
    //MARK: - IB Outlets
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalDaysLabel: UILabel!
    @IBOutlet weak var goalFormField: UITextField!
    @IBOutlet weak var dayFormField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    //MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        validationBoarderGoalTextField(false)
        validationBoarderDayTextField(false)
        initSetup()
        dayFormField.delegate = self
    }
    
    //MARK: - IB Action
    //MARK: - Text Fields
    @IBAction func onGoalTextField(_ sender: Any) {
        if goalFormField.text?.isEmpty == true {
            validationBoarderGoalTextField(true)
        } else {
            validationBoarderGoalTextField(false)
        }
    }
    
    @IBAction func onDaysTextField(_ sender: Any) {
        if dayFormField.text?.isEmpty == true {
            validationBoarderDayTextField(true)
        } else {
            validationBoarderDayTextField(false)
        }
    }
    
    //MARK: - Buttons
    @IBAction func onDoneButton(_ sender: Any) {
        if goalFormField.text?.isEmpty == true {
            validationBoarderGoalTextField(true)
            return
        } else if dayFormField.text?.isEmpty == true {
            validationBoarderDayTextField(true)
            return
        } else {
            
            validationBoarderGoalTextField(false)
            validationBoarderDayTextField(false)
            
            guard let numDays = dayFormField.text else { return }
            guard let text = goalFormField.text else { return }
            GoalFactory.instance.addNewGoal(name: text,
                                            days: Int(numDays) ?? 0)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Validadion
    private func validationBoarderGoalTextField(_ isEmpty: Bool) {
        goalFormField.layer.borderWidth = 1
        goalFormField.layer.cornerRadius = 5
        goalFormField.layer.borderColor = isEmpty ? UIColor.red.cgColor : UIColor.gray.cgColor
    }
    
    private func validationBoarderDayTextField(_ isEmpty: Bool) {
        dayFormField.layer.borderWidth = 1
        dayFormField.layer.cornerRadius = 5
        dayFormField.layer.borderColor = isEmpty ? UIColor.red.cgColor : UIColor.gray.cgColor
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
    
    //MARK: Delegates
    //MARK: UI Text Field Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}
