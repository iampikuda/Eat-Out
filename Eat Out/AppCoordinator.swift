//
//  AppCoordinator.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
//import RealmSwift
//import SwiftyUserDefaults

final class AppCoordinator {

    let window: UIWindow

//    var user: User?
//
//    var realmInstance: Realm {
//        // swiftlint:disable:next force_try
//        return try! Realm()
//    }

    init(window: UIWindow) {
        self.window = window
    }

    final func setUserIfPossible() {
//        if let currentUser = UserDataService.getAll(from: realmInstance).first {
//            self.user = currentUser
//            if currentUser.hasToken {
//                let vm = HomeViewModel()
//                pushVC(.home(vm: vm))
//            } else {
//                let vm = LoginViewModel()
//                pushVC(.login(vm: vm))
//            }
//        } else {
//            let vm = LoginViewModel()
//            pushVC(.login(vm: vm))
//        }
    }

    final func startApp() {
//        self.setUserIfPossible()
        window.rootViewController = ViewController()
    }
}
