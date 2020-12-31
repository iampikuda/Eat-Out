//
//  SceneDelegate.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private(set) var appCoordinator: AppCoordinator!

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard !TestingService.isUnitTest else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        #if DEBUG
        if TestingService.isUITest {
            prepareForUITest()
        }
        #endif
        appCoordinator = AppCoordinator(window: window, cacheService: CacheService())
        appCoordinator.startApp()

        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

private extension SceneDelegate {
    func prepareForUITest() {
        do {
            let realm = try Realm()
            try realm.safeWrite {
                realm.deleteAll()
            }
        } catch {}
    }
}
