//
//  AlertViewModel.swift
//  Goals
//
//  Created by mihail on 11.10.2023.
//

import Foundation

struct AlertViewModel {
    let title: String
    let message: String
    let buttonTitle: String
    let buttonTitleTwo: String?
    let complition: () -> Void
    
    init(title: String, message: String, buttonTitle: String, buttonTitleTwo: String? = nil, complition: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.buttonTitleTwo = buttonTitleTwo
        self.complition = complition
    }
}
