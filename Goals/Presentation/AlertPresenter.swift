//
//  AlertPresenter.swift
//  Goals
//
//  Created by mihail on 11.10.2023.
//

import UIKit

final class AlertPresenter {
    var delegate: UIViewController?
    var alertModel: AlertViewModel
    var alert = UIAlertController()
    
    init(alertModel: AlertViewModel, delegate: UIViewController) {
        self.alertModel = alertModel
        self.delegate = delegate
    }
    
    func showAlert() {
        alert = UIAlertController(title: alertModel.title ,
                                      message: alertModel.message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonTitle, style: .default) {_ in
            self.alertModel.complition()
        }
        
        alert.addAction(action)
        self.delegate?.present(alert, animated: true)
    }
    
    func showAlertTwoButtons() {
        alert = UIAlertController(title: alertModel.title ,
                                      message: alertModel.message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonTitle, style: .default) {_ in
            self.alertModel.complition()
        }
        
        let actionTwo = UIAlertAction(title: alertModel.buttonTitleTwo, style: .default) {_ in
        }
        
        alert.addAction(actionTwo)
        alert.addAction(action)
        self.delegate?.present(alert, animated: true)
    }
}
