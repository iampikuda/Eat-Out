//
//  HomeViewModel.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import Foundation
import RealmSwift

protocol HomeViewModelProtocol: class {
    var realmDelegate: RealmUpdateDelegate? { get set }
    var ascendingOrder: Bool { get set }
    var sorter: Sorter { get set }

    var numberOfRows: Int { get }
    var numberOfSection: Int { get }

    func restuarantAt(_ indexPath: IndexPath) -> Restuarant
}

final class HomeViewModel: HomeViewModelProtocol {
    var notificationToken: NotificationToken?
    weak var realmDelegate: RealmUpdateDelegate?

    var numberOfRows: Int {
        return allRestuarant.count
    }

    var numberOfSection: Int {
        return 0
    }

    var realmInstance: Realm {
        // swiftlint:disable:next force_try
        return try! Realm()
    }

    var ascendingOrder = false
    var sorter: Sorter = .bestMatch

    var allRestuarant: Results<Restuarant> {
        return RealmService.getAll(from: realmInstance, sortBy: sorter, ascending: ascendingOrder)
    }

    init() {
//        self.setupObserver()
    }

    func restuarantAt(_ indexPath: IndexPath) -> Restuarant {
        return allRestuarant[indexPath.row]
    }

    func setupObserver() {
        notificationToken = allRestuarant.observe { [weak self] (change) in
            switch change {
            case .initial:
                self?.realmDelegate?.gotInitialUpdate()
            case .update:
                self?.realmDelegate?.reloadEverything()
            case .error(let error):
                self?.realmDelegate?.gotError(error)
            }
        }
    }
}
