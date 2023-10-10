//
//  ViewController.swift
//  Goals
//
//  Created by mihail on 22.09.2023.
//

import UIKit

protocol GoalsViewControllerProtocol {
    func changeGoalsIndexLabel(_ str: String?)
    func reloadData()
    func changeGoalNameLabel(_ str: String) 
}

class GoalsViewController: UIViewController, GoalsViewControllerProtocol{
    
    //MARK: - IB Outlets
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var goalsIndexLabel: UILabel!
    @IBOutlet weak var goalNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    
    //MARK: - Public property
    var indexPath = 0
    
    //MARK: - Privates property
    private var presenter: GoalsPresenter!
    private let goalFactory = GoalFactory.instance
    
    //MARK: - Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = GoalsPresenter(viewController: self)
        addButton.titleLabel?.text = nil
        goalNameLabel.text = nil
        goalsIndexLabel.text = nil
        displaySettingsGoals()
        setupCollectionView()
    }
    
    //MARK: - IB Actions methods
    @IBAction func onDeleteGoal(_ sender: Any) {
        presenter.deleteGoal()
    }
    
    @IBAction func onRightButton(_ sender: Any) {
        if goalFactory.goalsCount != 0 {
            presenter.index = min(presenter.index + 1, goalFactory.goalsCount - 1)
            goalFactory.requestNextGoal(index: presenter.index)
            collectionView.reloadData()
        }
    }
    
    @IBAction func onLeftButton(_ sender: Any) {
        if goalFactory.goalsCount != 0 {
            presenter.index = max(presenter.index - 1, 0)
            goalFactory.requestNextGoal(index: presenter.index)
            collectionView.reloadData()
        }
    }
}

extension GoalsViewController {
    
    //MARK: Privates Methods

    
    private func displaySettingsGoals() {
        startLabel.isHidden = true
        startLabel.text = "Нет целей.."
        startLabel.font = UIFont.systemFont(ofSize: 30)
        if goalFactory.goalsCount != 0 {
            goalFactory.requestNextGoal(index: presenter.index)
        } else {
            startLabel.isHidden = false
        }
    }
    
    //MARK: - Setup collection view
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.size.width/3.5,
                                 height: collectionView.frame.size.width/3.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func changeGoalsIndexLabel(_ str: String?) {
        guard let str = str else {
            goalsIndexLabel.text = "Нет Целей"
            return
        }
        
        goalsIndexLabel.text = str
    }
    
    func changeGoalNameLabel(_ str: String) {
        goalNameLabel.text = str
    }
}

//MARK: - Extension GoalFactoryDelegate


//MARK: - Extension CollectionView
extension GoalsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: - Collection View delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goalFactory.statistic?.days?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LabelCollectionViewCell else {
            return LabelCollectionViewCell()
        }
        
        cell.label.font = .boldSystemFont(ofSize: 40)
        
        switch goalFactory.statistic?.days?[indexPath.item].state {
        case .isNotDone:
            cell.backgroundColor = .red
        case .isDone:
            cell.backgroundColor = .green
        case .isCurrent:
            cell.backgroundColor = .yellow
        case .isNotCurrent:
            cell.backgroundColor = .gray
        case .none:
            print("no elements")
        }
        
        cell.label.text = "\(indexPath.row + 1)"
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let description = goalFactory.goals[presenter.index]?.days[indexPath.item].description else { return }
        
        let alert = UIAlertController(title: "Результат \(indexPath.item + 1) дня ",
                                      message: description,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Выйти", style: .default) {_ in
            
        }
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            let isDone = UIAction(title: "Выполнена", identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self.goalFactory.statistic?.goals?[self.presenter.index].days[indexPath.item].state = .isDone
                self.goalFactory.requestNextGoal(index: self.presenter.index)
                collectionView.reloadData()
            }
            
            let isNotdone = UIAction(title: "Не выполнена", identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self.goalFactory.statistic?.goals?[self.presenter.index].days[indexPath.item].state = .isNotDone
                self.goalFactory.requestNextGoal(index:self.presenter.index)
                collectionView.reloadData()
            }
            
            let writeResult = UIAction(title: "Записать результат дня", identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self.indexPath = indexPath.item
                let storyboard = UIStoryboard(name: "Main", bundle: nil) // Замените "Main" на имя вашего сториборда
                let formDescriptionDayController = storyboard.instantiateViewController(withIdentifier: "FormDescriptionDayViewController") as! FormDescriptionDayViewController
                formDescriptionDayController.modalPresentationStyle = .fullScreen
                self.present(formDescriptionDayController, animated: false, completion: nil)
            }
            
            return UIMenu(title: "",
                          image: nil,
                          identifier: nil,
                          options: UIMenu.Options.displayInline,
                          children: [isDone, isNotdone, writeResult])
        }
        return config
    }
}
