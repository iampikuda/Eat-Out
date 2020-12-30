//
//  SortViewModel.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

protocol SortViewModelProtocol: class {
    var numberOfSections: Int { get }
    var numberOfItems: Int { get }

    func textAt(_ indexPath: IndexPath) -> String
    func sortAt(_ indexPath: IndexPath) -> Sorter
}

final class SortViewModel: SortViewModelProtocol {

    let dataSource = Sorter.allCases

    var numberOfSections: Int {
        return 1
    }

    var numberOfItems: Int {
        return dataSource.count
    }

    func textAt(_ indexPath: IndexPath) -> String {
        return dataSource[indexPath.row].sortText
    }

    func sortAt(_ indexPath: IndexPath) -> Sorter {
        return dataSource[indexPath.row]
    }
}
