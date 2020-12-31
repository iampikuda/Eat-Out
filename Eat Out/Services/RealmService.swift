//
//  RealmService.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import RealmSwift

enum Sorter: String, CaseIterable {
    case bestMatch = "bestMatchValue"
    case averageProductPrice
    case ratingAverage = "rating"
    case deliveryCosts = "deliveryCost"
    case distance
    case minCost = "minimumCost"
    case newest = "newestLevel"
    case popularity

    var sortText: String {
        switch self {
        case .averageProductPrice: return "Price"
        case .bestMatch: return "Best Match"
        case .deliveryCosts: return "Delivery cost"
        case .distance: return "Distance"
        case .minCost: return "Minimum cost"
        case .newest: return "Newest"
        case .popularity: return "Popularity"
        case .ratingAverage: return "Rating"
        }
    }
}

struct RealmService {
    static func getAll(from realm: Realm, sortBy: Sorter = .bestMatch, ascending: Bool = false) -> Results<Restuarant> {
        let results = realm.objects(Restuarant.self)
        return results.sorted(by: [
            SortDescriptor(keyPath: "statusInt", ascending: true),
            SortDescriptor(keyPath: sortBy.rawValue, ascending: ascending)
        ])
    }

    static func save(_ items: [Restuarant], to realm: Realm) {
        // swiftlint:disable:next force_try
        try! realm.safeWrite {
            for item in items {
                saveInWrite(item, to: realm)
            }
        }
    }

    static func saveInWrite(_ item: Restuarant, to realmInWrite: Realm) {
        if let first = realmInWrite.objects(Restuarant.self).filter("id = '\(item.id)'").first {
            item.isFavourited = first.isFavourited
            realmInWrite.add(item, update: .modified)
        } else {
            realmInWrite.add(item)
        }
    }

    static func favouriteRestuarant(_ item: Restuarant, in realm: Realm) {
        // swiftlint:disable:next force_try
        try! realm.safeWrite {
            item.isFavourited.toggle()
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
