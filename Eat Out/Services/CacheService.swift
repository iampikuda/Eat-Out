//
//  CacheService.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import RealmSwift

protocol CacheDelegate: class {
    func gotError(_ error: Error)
}

class CacheService {
    weak var delegate: CacheDelegate?

    var realmInstance: Realm {
        // swiftlint:disable:next force_try
        return try! Realm()
    }

    func getRestaurants(from fileName: FileName) {
        let q = DispatchQueue(label: "RealmBackgound", qos: .background, attributes: .concurrent)
        q.async {
            do {
                let data = try JsonService().getRestaurantData(from: fileName)
                let Restaurants = try JSONDecoder().decode(RestaurantMeta.self, from: data).restaurants
                RealmService.save(Restaurants, to: self.realmInstance)
            } catch {
                self.delegate?.gotError(error)
            }
        }
    }
}
