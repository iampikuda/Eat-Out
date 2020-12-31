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
    var filterText: String { get set }

    var numberOfRows: Int { get }
    var numberOfSection: Int { get }

    func restuarantAt(_ indexPath: IndexPath) -> Restuarant
    func favouriteResturant(_ restuarant: Restuarant)
}

final class HomeViewModel: HomeViewModelProtocol {
    var notificationToken: NotificationToken?
    weak var realmDelegate: RealmUpdateDelegate?

    var numberOfRows: Int {
        return filtered ? filteredArray.count : allRestuarant.count
    }

    var numberOfSection: Int {
        return 1
    }

    var realmInstance: Realm {
        // swiftlint:disable:next force_try
        return try! Realm()
    }

    var ascendingOrder = false
    var sorter: Sorter = .bestMatch
    var filterText: String = ""
    var filtered: Bool {
        return filterText != ""
    }

    var allRestuarant: Results<Restuarant> {
        return RealmService.getAll(from: realmInstance, sortBy: sorter, ascending: ascendingOrder)
    }

    var filteredArray: [Restuarant] {
        return allRestuarant.filter({ $0.name.lowercased().contains(filterText.lowercased()) })
    }

    init() {
        self.setupObserver()
    }

    func restuarantAt(_ indexPath: IndexPath) -> Restuarant {
        return filtered ? filteredArray[indexPath.row] : allRestuarant[indexPath.row]
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

    func favouriteResturant(_ restuarant: Restuarant) {
        RealmService.favouriteRestuarant(restuarant, in: realmInstance)
    }
}
