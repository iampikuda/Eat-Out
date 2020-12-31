//
//  AppCoordinator.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

final class AppCoordinator {

    let window: UIWindow
    let cacheService: CacheService

    init(window: UIWindow, cacheService: CacheService) {
        self.window = window
        self.cacheService = cacheService

        self.cacheService.delegate = self
        self.cacheService.getRestaurants(from: .good)
    }

    final func startApp() {
        let vc = HomeViewController(viewModel: HomeViewModel(), sortViewModel: SortViewModel())
        window.rootViewController = UINavigationController(rootViewController: vc)
    }
}

extension AppCoordinator: CacheDelegate {
    func gotError(_ error: Error) {
        assertionFailure(error.localizedDescription)
    }
}
