//
//  ViewController.swift
//  Goals
//
//  Created by mihail on 22.09.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, GoalFactoryDelegate {
    //MARK: - IB Outlets
    @IBOutlet weak var goalsIndexLabel: UILabel!
    @IBOutlet weak var goalNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Privates property
    private var countButtons: Int = 0 // Укажите нужное количество кнопок
    private let buttonCellIdentifier = "ButtonCell"
    private let goalFactory = GoalFactory.instance
    private var currentGoal: Goal?
    private var dayStr: String?
    private var index = 0
    
    //MARK: - Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()
        goalFactory.viewControllerDelegate = self
        goalNameLabel.text = nil
        goalsIndexLabel.text = nil
        goalFactory.backStepGoal(index: index)
    }
    
    //MARK: - IB Actions methods
    @IBAction func onRightButton(_ sender: Any) {
        
        index = min(index + 1, goalFactory.goalsCount - 1)
        goalFactory.nextStepGoal(index: index)
    }
    
    @IBAction func onLeftButton(_ sender: Any) {
        index = max(index - 1, 0)
        goalFactory.backStepGoal(index: index)
        
    }
    
    //MARK: - Public Methods
    //MARK: - GoalFactoryDelegate
    func didReceiveNextGoal(goal: Goal?) {
        guard let goal = goal else { return }
        
        currentGoal = goal
        show(convert(goal: goal))
    }
    
    func convert(goal: Goal) -> GoalModelView {
        let modelView = GoalModelView(name: goal.name,
                                      days: goal.days,
                                      dayStr: goal.discription,
                                      stateColor: goal.state == .isCurrent ? .gray : .green)
        
        return modelView
    }
    
    func show(_ modelView: GoalModelView) {
        let indexTotal = goalFactory.goalsCount
        
        goalNameLabel.text = modelView.name
        goalsIndexLabel.text = "\(index + 1) / \(indexTotal) "
        countButtons = modelView.days

        setupCollectionView()
    }
    
    
    //MARK: - SETUP COLLECTIONVIEW BUTTONS
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
       
        cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
        cell.button.setTitle("\(dayStr ?? "") \(indexPath.item + 1)", for: .normal)
        
        return cell
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Обработка нажатия на кнопку
        if let title = sender.currentTitle {
            print("Нажата кнопка с заголовком: \(title)")
        }
        

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
