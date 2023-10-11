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
    let complition: () -> Void
}
