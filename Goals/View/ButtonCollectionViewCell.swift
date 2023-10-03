//
//  ButtonCollectionViewCell.swift
//  Goals
//
//  Created by mihail on 29.09.2023.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        addSubview(button)
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.backgroundColor = .blue
        button.tintColor = .white
        button.layer.cornerRadius = 10
    }
}
