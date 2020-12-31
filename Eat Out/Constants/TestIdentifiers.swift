//
//  TestIdentifiers.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 31/12/2020.
//

enum TestIdentifiers: String {
    case homeCollectionView
    case sortCollectionView
    case heartImageView
    case favouriteButton
    case homeSearchField
    case homeControllerNav
    case homeCollectionViewCellNameLabel

    static func sortCell(sorter: Sorter) -> String {
        return "sort cell \(sorter.rawValue)"
    }

    static func cellStatus(_ status: RestaurantStatus) -> String {
        return "homeCollectionView cell statuc view \(status.rawValue)"
    }
}
