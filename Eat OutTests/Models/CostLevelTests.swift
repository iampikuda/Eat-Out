//
//  CostLevelTests.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import XCTest

@testable import Eat_Out

class CostLevelTests: XCTestCase {
    func testInit() {
        let cost1 = CostLevel(cost: 0)
        let cost2 = CostLevel(cost: 20)
        let cost3 = CostLevel(cost: 900)
        let cost4 = CostLevel(cost: 1200)
        let cost5 = CostLevel(cost: 1900)
        let cost6 = CostLevel(cost: 2000)
        let cost7 = CostLevel(cost: 2800)
        let cost8 = CostLevel(cost: 3000)
        let cost9 = CostLevel(cost: 9000)
        let cost10 = CostLevel(cost: 20000)

        XCTAssertEqual(cost1, .budget)
        XCTAssertEqual(cost2, .budget)
        XCTAssertEqual(cost3, .budget)
        XCTAssertEqual(cost4, .average)
        XCTAssertEqual(cost5, .expensive)
        XCTAssertEqual(cost6, .expensive)
        XCTAssertEqual(cost7, .baller)
        XCTAssertEqual(cost8, .baller)
        XCTAssertEqual(cost9, .baller)
        XCTAssertEqual(cost10, .baller)

        XCTAssertEqual(cost1.rawValue, "€")
        XCTAssertEqual(cost2.rawValue, "€")
        XCTAssertEqual(cost3.rawValue, "€")
        XCTAssertEqual(cost4.rawValue, "€€")
        XCTAssertEqual(cost5.rawValue, "€€€")
        XCTAssertEqual(cost6.rawValue, "€€€")
        XCTAssertEqual(cost7.rawValue, "€€€€")
        XCTAssertEqual(cost8.rawValue, "€€€€")
        XCTAssertEqual(cost9.rawValue, "€€€€")
        XCTAssertEqual(cost10.rawValue, "€€€€")
    }
}
