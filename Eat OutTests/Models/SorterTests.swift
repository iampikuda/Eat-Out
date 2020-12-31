//
//  SorterTests.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import XCTest

@testable import Eat_Out

class SorterTests: XCTestCase {
    func testAllCases() {
        XCTAssertEqual(Sorter.allCases.count, 8)
    }

    func testRawValues() {
        let sort1 = Sorter.bestMatch
        let sort2 = Sorter.averageProductPrice
        let sort3 = Sorter.ratingAverage
        let sort4 = Sorter.deliveryCosts
        let sort5 = Sorter.distance
        let sort6 = Sorter.minCost
        let sort7 = Sorter.newest
        let sort8 = Sorter.popularity

        XCTAssertEqual(sort1.rawValue, "bestMatchValue")
        XCTAssertEqual(sort2.rawValue, "averageProductPrice")
        XCTAssertEqual(sort3.rawValue, "rating")
        XCTAssertEqual(sort4.rawValue, "deliveryCost")
        XCTAssertEqual(sort5.rawValue, "distance")
        XCTAssertEqual(sort6.rawValue, "minimumCost")
        XCTAssertEqual(sort7.rawValue, "newestLevel")
        XCTAssertEqual(sort8.rawValue, "popularity")
    }

    func testSortText() {
        let sort1 = Sorter.bestMatch
        let sort2 = Sorter.averageProductPrice
        let sort3 = Sorter.ratingAverage
        let sort4 = Sorter.deliveryCosts
        let sort5 = Sorter.distance
        let sort6 = Sorter.minCost
        let sort7 = Sorter.newest
        let sort8 = Sorter.popularity

        XCTAssertEqual(sort1.sortText, "Best Match")
        XCTAssertEqual(sort2.sortText, "Price")
        XCTAssertEqual(sort3.sortText, "Rating")
        XCTAssertEqual(sort4.sortText, "Delivery cost")
        XCTAssertEqual(sort5.sortText, "Distance")
        XCTAssertEqual(sort6.sortText, "Minimum cost")
        XCTAssertEqual(sort7.sortText, "Newest")
        XCTAssertEqual(sort8.sortText, "Popularity")
    }
}
