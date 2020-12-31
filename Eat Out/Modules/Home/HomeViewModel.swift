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

    func restaurantAt(_ indexPath: IndexPath) -> Restaurant
    func favouriteResturant(_ restaurant: Restaurant)
}

class HomeViewModel: HomeViewModelProtocol {
    var notificationToken: NotificationToken?
    weak var realmDelegate: RealmUpdateDelegate?

    var numberOfRows: Int {
        return filtered ? filteredArray.count : allRestaurant.count
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

    var allRestaurant: Results<Restaurant> {
        return RealmService.getAll(from: realmInstance, sortBy: sorter, ascending: ascendingOrder)
    }

    var filteredArray: [Restaurant] {
        return allRestaurant.filter({ $0.name.lowercased().contains(filterText.lowercased()) })
    }

    init() {
        self.setupObserver()
    }

    func restaurantAt(_ indexPath: IndexPath) -> Restaurant {
        return filtered ? filteredArray[indexPath.row] : allRestaurant[indexPath.row]
    }

    func setupObserver() {
        notificationToken = allRestaurant.observe { [weak self] (change) in
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

    func favouriteResturant(_ Restaurant: Restaurant) {
        RealmService.favouriteRestaurant(Restaurant, in: realmInstance)
    }
}
