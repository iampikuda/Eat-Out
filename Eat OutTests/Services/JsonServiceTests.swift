//
//  JsonServiceTests.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import XCTest

@testable import Eat_Out

final class JsonServiceTests: XCTestCase {
    func testGoodJson() throws {
        XCTAssertNotNil(try JsonService().getRestaurantData(from: .good))
    }

    func testBadJson() {
        XCTAssertThrowsError(try JsonService().getRestaurantData(from: .bad))
    }
}
