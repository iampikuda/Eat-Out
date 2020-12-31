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

final class CacheService {
    weak var delegate: CacheDelegate?

    func getRestuarants() {
        let q = DispatchQueue(label: "RealmBackgound", qos: .background, attributes: .concurrent)
        q.async {
            do {
                let data = try JsonService().getRestuarantData()
                let restuarants = try JSONDecoder().decode(RestuarantMeta.self, from: data).restaurants
                let realm = try Realm()
                RealmService.save(restuarants, to: realm)
            } catch {
                self.delegate?.gotError(error)
            }
        }
    }
}
