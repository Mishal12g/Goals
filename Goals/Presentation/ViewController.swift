//
//  ViewController.swift
//  Goals
//
//  Created by mihail on 22.09.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK: Privaties property
    private var countButtons: Int = 0 // Укажите нужное количество кнопок
    private let buttonCellIdentifier = "ButtonCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var goalNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var daysTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    
    //MARK: Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()
        goalNameLabel.text = nil
        setupCollectionView()
    }
    
    @IBAction func onDoneButten(_ sender: Any) {
        daysTextField.resignFirstResponder()
        goalTextField.resignFirstResponder()
        goalNameLabel.text = goalTextField.text
        guard let num = Int(daysTextField.text ?? "0") else { return }
        countButtons = num
        setupCollectionView()
    }
    
    //MARK: SETUP COLLECTIONVIEW BUTTONS
    func setupCollectionView() {
        // Настройте UICollectionViewFlowLayout для сетки
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 100) // Размер ячейки

        collectionView.collectionViewLayout = layout

        // Установите self как источник данных
        collectionView.dataSource = self
        collectionView.delegate = self

        // Зарегистрируйте пользовательскую ячейку
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: buttonCellIdentifier)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countButtons
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCellIdentifier, for: indexPath) as! ButtonCollectionViewCell
        
        cell.button.setTitle("День \(indexPath.item + 1)", for: .normal)
        return cell
    }
}




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
