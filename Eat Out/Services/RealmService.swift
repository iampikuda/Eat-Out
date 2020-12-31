//
//  RealmService.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import RealmSwift

struct RealmService {
    static func getAll(from realm: Realm, sortBy: Sorter = .bestMatch, ascending: Bool = false) -> Results<Restaurant> {
        let results = realm.objects(Restaurant.self)
        return results.sorted(by: [
            SortDescriptor(keyPath: "statusInt", ascending: true),
            SortDescriptor(keyPath: sortBy.rawValue, ascending: ascending)
        ])
    }

    static func save(_ items: [Restaurant], to realm: Realm) {
        // swiftlint:disable:next force_try
        try! realm.safeWrite {
            for item in items {
                saveInWrite(item, to: realm)
            }
        }
    }

    static private func saveInWrite(_ item: Restaurant, to realmInWrite: Realm) {
        if let first = realmInWrite.objects(Restaurant.self).filter("id = '\(item.id)'").first {
            item.isFavourited = first.isFavourited
            realmInWrite.add(item, update: .modified)
        } else {
            realmInWrite.add(item)
        }
    }

    static func favouriteRestaurant(_ item: Restaurant, in realm: Realm) {
        // swiftlint:disable:next force_try
        try! realm.safeWrite {
            if let first = realm.objects(Restaurant.self).filter("id = '\(item.id)'").first {
                first.isFavourited.toggle()
            }
        }
    }
}

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
