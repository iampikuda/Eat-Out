//
//  RestaurantStatusTests.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import XCTest

@testable import Eat_Out

class RestaurantStatusTests: XCTestCase {
    func testInit() {
        let stat1 = RestaurantStatus("open")
        let stat2 = RestaurantStatus("closed")
        let stat3 = RestaurantStatus("order ahead")

        XCTAssertEqual(stat1, .open)
        XCTAssertEqual(stat2, .closed)
        XCTAssertEqual(stat3, .orderAhead)
    }

    func testDynamic() {
        let stat1 = RestaurantStatus("open")
        let stat2 = RestaurantStatus("closed")
        let stat3 = RestaurantStatus("order ahead")

        XCTAssertEqual(stat1.text, "")
        XCTAssertEqual(stat1.isHidden, true)
        XCTAssertEqual(stat1.color, .clear)

        XCTAssertEqual(stat2.text, "CLOSED")
        XCTAssertEqual(stat2.isHidden, false)
        XCTAssertEqual(stat2.color, .red)

        XCTAssertEqual(stat3.text, "ORDER AHEAD")
        XCTAssertEqual(stat3.isHidden, false)
        XCTAssertEqual(stat3.color, .primary)
    }
}
