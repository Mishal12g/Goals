//
//  ViewController.swift
//  Goals
//
//  Created by mihail on 22.09.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, GoalFactoryDelegate{

    

    //MARK: Privaties property
    private var countButtons: Int = 0 // Укажите нужное количество кнопок
    private let buttonCellIdentifier = "ButtonCell"
    private var goalFactory: GoalFactoryProtocol?
    private var currentGoal: Goal?
    private var dayStr: String?
    private var index = -1
    private let indexTotal = 3
    
    //MARK: IBOutlets
    @IBOutlet weak var goalsIndexLabel: UILabel!
    @IBOutlet weak var goalNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var daysTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    
    //MARK: Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()
        goalFactory = GoalFactory(delegate: self)
        goalNameLabel.text = nil
        goalsIndexLabel.text = nil
    }
    //MARK: IBActions methods
    @IBAction func onRightButton(_ sender: Any) {
        guard let goalFactory = goalFactory else { return }
        
        index = min(index + 1, goalFactory.goals.count - 1)
        goalFactory.nextStepGoal(index: index)
    }
    
    @IBAction func onLeftButton(_ sender: Any) {
        index = max(index - 1, 0)
        goalFactory?.backStepGoal(index: index)
    }
    
    @IBAction func onDoneButten(_ sender: Any) {
        
        daysTextField.resignFirstResponder()
        goalTextField.resignFirstResponder()
        setupCollectionView()
    }
    
    //MARK: Public Methods
    
    //MARK: GoalFactoryDelegate
    func didReceiveNextGoal(goal: Goal?) {
        guard let goal = goal else { return }
        
        currentGoal = goal
        show(convert(goal: goal))
    }
    
    func convert(goal: Goal) -> GoalModelView {
        let modelView = GoalModelView(name: goal.name,
                                      dayStr: String(goal.days),
                                      stateColor: goal.state == .isCurrent ? .gray : .blue)
        countButtons = goal.days
        
        return modelView
    }
    
    func show(_ modelView: GoalModelView) {
        goalNameLabel.text = modelView.name
        goalsIndexLabel.text = "\(index + 1) / \(indexTotal) "
            
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
