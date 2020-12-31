//
//  Restaurant.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import Foundation
import RealmSwift

final class Restaurant: Object {
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

    var status: RestaurantStatus {
        return RestaurantStatus(statusString)
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

extension Restaurant: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, name, sortingValues
        case statusString = "status"
    }
}

extension Restaurant {
    convenience init(
        id: String,
        name: String = "",
        averageProductPrice: Float = 0,
        bestMatchValue: Float = 0,
        deliveryCost: Float = 0,
        distance: Float = 0,
        minimumCost: Float = 0,
        newestLevel: Float = 0,
        popularity: Float = 0,
        rating: Float = 0,
        isFavourited: Bool = false,
        statusString: String = "",
        statusInt: Int = 0
    ) {
        self.init()
        self.id = id
        self.name = name
        self.averageProductPrice = averageProductPrice
        self.bestMatchValue = bestMatchValue
        self.deliveryCost = deliveryCost
        self.distance = distance
        self.minimumCost = minimumCost
        self.newestLevel = newestLevel
        self.popularity = popularity
        self.rating = rating
        self.isFavourited = isFavourited
        self.statusString = statusString
        self.statusInt = statusInt
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
