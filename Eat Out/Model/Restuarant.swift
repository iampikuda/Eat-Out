//
//  Restuarant.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import Foundation
import RealmSwift

final class Restuarant: Object {
    @objc dynamic var id: String = "-1"
    @objc dynamic var name: String = ""

    @objc dynamic var averageProductPrice: Float = 0.0
    @objc dynamic var bestMatchValue: Float = 0.0
    @objc dynamic var deliveryCost: Float = 0.0
    @objc dynamic var distance: Float = 0.0
    @objc dynamic var minimumCost: Float = 0.0
    @objc dynamic var newestLevel: Float = 0.0
    @objc dynamic var popularity: Float = 0.0
    @objc dynamic var rating: Float = 0.0

    @objc dynamic var isFavourited: Bool = false

    @objc private dynamic var statusString: String = ""
    // For sorting
    @objc private dynamic var statusInt: Int = 0

    var costLevel: CostLevel {
        return CostLevel(cost: averageProductPrice)
    }

    var status: Status {
        return Status(statusString)
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        statusString = try container.decode(String.self, forKey: .statusString)
        statusInt = status.rawValue

        let sortingValues = try container.decode(SortValues.self, forKey: .sortingValues)

        averageProductPrice = sortingValues.averageProductPrice
        bestMatchValue = sortingValues.bestMatch
        deliveryCost = sortingValues.deliveryCosts
        distance = sortingValues.distance
        minimumCost = sortingValues.minCost
        newestLevel = sortingValues.newest
        popularity = sortingValues.popularity
        rating = sortingValues.ratingAverage
    }
}

extension Restuarant: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, name, sortingValues
        case statusString = "status"
    }
}

struct SortValues: Decodable {
    var averageProductPrice: Float
    var bestMatch: Float
    var deliveryCosts: Float
    var distance: Float
    var minCost: Float
    var newest: Float
    var popularity: Float
    var ratingAverage: Float
}
