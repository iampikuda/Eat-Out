//
//  TestCacheSerive.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import Foundation
import RealmSwift

@testable import Eat_Out

final class TestCacheSerive: CacheService {
    override var realmInstance: Realm {
        // swiftlint:disable:next force_try
        return try! Realm(configuration: realmConfiguration)
    }

    let realmConfiguration: Realm.Configuration

    init(realmIdentifier: String) {
        self.realmConfiguration = Realm.Configuration(inMemoryIdentifier: realmIdentifier)
    }

    override func getRestaurants(from fileName: FileName) {
        do {
            let data = try JsonService().getRestaurantData(from: fileName)
            let Restaurants = try JSONDecoder().decode(RestaurantMeta.self, from: data).restaurants
            RealmService.save(Restaurants, to: self.realmInstance)
        } catch {
            self.delegate?.gotError(error)
        }
    }
}

