//
//  FormDescriptionDayPresenter.swift
//  Goals
//
//  Created by mihail on 11.10.2023.
//

import Foundation

final class FormDescriptionDayPresenter {
    
    //MARK: Privates properties
    private let goalFactory = GoalFactory.instance
    private var indexPath = IndexPath()
    private var index: Int = 0
    
    //MARK: Init
    init(indexPath: IndexPath, index: Int) {
        self.indexPath = indexPath
        self.index = index
    }
    
    //MARK: - Privates methods
    func addDescription(_ str: String) {
        guard let dataSource = goalFactory.dataSource else { return }

        dataSource.goals?[index].days[indexPath.item].description = str
    }
}
