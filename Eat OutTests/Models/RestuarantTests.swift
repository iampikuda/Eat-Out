//
//  RestaurantTests.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import XCTest

@testable import Eat_Out

class RestaurantTests: XCTestCase {
    func testInitAnd() {
        let rest1 = Restaurant(
            id: "9",
            name: "Niner",
            averageProductPrice: 9,
            bestMatchValue: 9,
            deliveryCost: 9,
            distance: 9,
            minimumCost: 9,
            newestLevel: 9,
            popularity: 9,
            rating: 9,
            isFavourited: true,
            statusString: "open",
            statusInt: 0
        )

        XCTAssertEqual(rest1.id, "9")
        XCTAssertEqual(rest1.name, "Niner")
        XCTAssertEqual(rest1.averageProductPrice, 9)
        XCTAssertEqual(rest1.bestMatchValue, 9)
        XCTAssertEqual(rest1.deliveryCost, 9)
        XCTAssertEqual(rest1.distance, 9)
        XCTAssertEqual(rest1.minimumCost, 9)
        XCTAssertEqual(rest1.newestLevel, 9)
        XCTAssertEqual(rest1.popularity, 9)
        XCTAssertEqual(rest1.rating, 9)
        XCTAssertEqual(rest1.isFavourited, true)
        XCTAssertEqual(rest1.costLevel, .budget)
        XCTAssertEqual(rest1.status, .open)
    }
}
