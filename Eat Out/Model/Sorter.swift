//
//  Sorter.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import Foundation

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
        case .bestMatch: return "Best Match"
        case .averageProductPrice: return "Price"
        case .deliveryCosts: return "Delivery cost"
        case .distance: return "Distance"
        case .minCost: return "Minimum cost"
        case .newest: return "Newest"
        case .popularity: return "Popularity"
        case .ratingAverage: return "Rating"
        }
    }
}
