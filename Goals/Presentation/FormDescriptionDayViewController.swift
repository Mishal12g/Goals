//
//  FormDescriptionDay.swift
//  Goals
//
//  Created by mihail on 06.10.2023.
//

import UIKit

class FormDescriptionDayViewController: UIViewController {
    //MARK: IB Outlets
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextView!
    
    //MARK: Privates properties
    private let goalFactory = GoalFactory.instance
    private var index: Int = 0
    
    //MARK: Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        keyboard()
        viewSetingsTextField()
    }

    //MARK: IB actions methods
    @IBAction func but(_ sender: Any) {
        guard var text = textField.text else { return }
        
        text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !text.isEmpty {
            let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
            addDescription(trimmedText)
        }
        
        dismiss(animated: false, completion: nil)
    }
}

extension FormDescriptionDayViewController {
    //MARK: - Privates methods
    func addDescription(_ str: String) {
//        guard let statistic = goalFactory.statistic,
//              let index = delegate?.index,
//              let indexPath = delegate?.indexPath else { return }
//        
//        statistic.goals?[index].days[indexPath].description = str
    }
    
    //MARK: Keyboard methods show/hide
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            buttonBottomConstraint.constant = keyboardHeight
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        buttonBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func keyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func viewSetingsTextField() {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 5.0
        textField.becomeFirstResponder()
    }
}
