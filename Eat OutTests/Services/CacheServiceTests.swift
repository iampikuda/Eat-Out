//
//  CacheServiceTests.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import XCTest
import RealmSwift

@testable import Eat_Out

class CacheServiceTests: XCTestCase {
    var realmConfiguration = Realm.Configuration(inMemoryIdentifier: "")
    var realmInstance: Realm {
        // swiftlint:disable:next force_try
        return try! Realm(configuration: realmConfiguration)
    }

    var allRestaurants: Results<Restaurant> {
        return realmInstance.objects(Restaurant.self)
    }

    override func setUp() {
        super.setUp()
        self.realmConfiguration = Realm.Configuration(inMemoryIdentifier: self.name)
    }

    override func tearDown() {
        super.tearDown()
        try! realmInstance.safeWrite {
            self.realmInstance.deleteAll()
        }
    }

    func testGoodJson() {
        let spyDelegate = CacheSpyDelegate()
        let cacheService = TestCacheSerive(realmIdentifier: self.name)
        cacheService.delegate = spyDelegate
        cacheService.getRestaurants(from: .good)

        XCTAssertEqual(allRestaurants.count, 19)
        XCTAssertNil(spyDelegate.error)
    }

    func testBadJson() {
        let spyDelegate = CacheSpyDelegate()
        let cacheService = TestCacheSerive(realmIdentifier: self.name)
        cacheService.delegate = spyDelegate
        cacheService.getRestaurants(from: .bad)

        XCTAssertEqual(allRestaurants.count, 0)
        XCTAssertNotNil(spyDelegate.error)
    }
}
