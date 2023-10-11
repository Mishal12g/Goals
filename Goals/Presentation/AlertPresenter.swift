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
    
    init(alertModel: AlertViewModel, delegate: UIViewController) {
        self.alertModel = alertModel
        self.delegate = delegate
    }
    
    func showAlert() {
        let alert = UIAlertController(title: alertModel.title ,
                                      message: alertModel.message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonTitle, style: .default) {_ in
            self.alertModel.complition()
        }
        
        alert.addAction(action)
        self.delegate?.present(alert, animated: true)
    }
}
