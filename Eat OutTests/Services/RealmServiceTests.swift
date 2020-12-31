//
//  RealmServiceTests.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import XCTest
import RealmSwift

@testable import Eat_Out

final class RealmServiceTests: XCTestCase {
    var realmConfiguration = Realm.Configuration(inMemoryIdentifier: "")
    var realmInstance: Realm {
        // swiftlint:disable:next force_try
        return try! Realm(configuration: realmConfiguration)
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

    func testGetAll() {
        TestCacheSerive(realmIdentifier: self.name).getRestaurants(from: .good)

        let allRestaurantBest = RealmService.getAll(from: realmInstance)
        guard let firstBest = allRestaurantBest.first, let lastBest = allRestaurantBest.last else {
            XCTFail("All Restaurant sorted by best match doesn't have a first and last")
            return
        }

        XCTAssertEqual(allRestaurantBest.count, 19)
        XCTAssertEqual(firstBest.status, .open)
        XCTAssertEqual(lastBest.status, .closed)
        XCTAssertTrue(firstBest.bestMatchValue > lastBest.bestMatchValue)

        let allRestaurantPrice = RealmService.getAll(from: realmInstance, sortBy: .averageProductPrice)
        guard let firstPrice = allRestaurantPrice.first, let lastPrice = allRestaurantPrice.last else {
            XCTFail("All Restaurant sorted by average price doesn't have a first and last")
            return
        }

        XCTAssertTrue(firstPrice.averageProductPrice > lastPrice.averageProductPrice)

        let allRestaurantDelivery = RealmService.getAll(from: realmInstance, sortBy: .deliveryCosts)
        guard let firstDelivery = allRestaurantDelivery.first, let lastDelivery = allRestaurantDelivery.last else {
            XCTFail("All Restaurant sorted by delivery cost doesn't have a first and last")
            return
        }

        XCTAssertTrue(firstDelivery.deliveryCost > lastDelivery.deliveryCost)

        let allRestaurantDistance = RealmService.getAll(from: realmInstance, sortBy: .distance)
        guard let firstDistance = allRestaurantDistance.first, let lastDistance = allRestaurantDistance.last else {
            XCTFail("All Restaurant sorted by distance doesn't have a first and last")
            return
        }

        XCTAssertTrue(firstDistance.distance > lastDistance.distance)

        // order
        let allRestaurantPriceAsc = RealmService.getAll(
            from: realmInstance,
            sortBy: .averageProductPrice,
            ascending: true
        )
        guard let firstPriceAsc = allRestaurantPriceAsc.first, let lastPriceAsc = allRestaurantPriceAsc.last else {
            XCTFail("All Restaurant sorted by average price doesn't have a first and last")
            return
        }

        XCTAssertTrue(firstPriceAsc.averageProductPrice < lastPriceAsc.averageProductPrice)

        let allRestaurantDeliveryAsc = RealmService.getAll(
            from: realmInstance,
            sortBy: .deliveryCosts,
            ascending: true
        )
        guard let firstDeliveryAsc = allRestaurantDeliveryAsc.first,
              let lastDeliveryAsc = allRestaurantDeliveryAsc.last else {
            XCTFail("All Restaurant sorted by delivery cost doesn't have a first and last")
            return
        }

        XCTAssertTrue(firstDeliveryAsc.deliveryCost < lastDeliveryAsc.deliveryCost)

        let allRestaurantDistanceAsc = RealmService.getAll(from: realmInstance, sortBy: .distance, ascending: true)
        guard let firstDistanceAsc = allRestaurantDistanceAsc.first,
              let lastDistanceAsc = allRestaurantDistanceAsc.last else {
            XCTFail("All Restaurant sorted by distance doesn't have a first and last")
            return
        }

        XCTAssertTrue(firstDistanceAsc.distance < lastDistanceAsc.distance)
    }

    func testSave() {
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

        let rest2 = Restaurant(
            id: "5",
            name: "Fiver",
            averageProductPrice: 5,
            bestMatchValue: 5,
            deliveryCost: 5,
            distance: 5,
            minimumCost: 5,
            newestLevel: 5,
            popularity: 5,
            rating: 5,
            isFavourited: false,
            statusString: "closed",
            statusInt: 2
        )

        RealmService.save([rest1, rest2], to: realmInstance)
        let all = RealmService.getAll(from: realmInstance)
        XCTAssertEqual(all.count, 2)

        XCTAssertEqual(all[0].id, "9")
        XCTAssertEqual(all[0].name, "Niner")
        XCTAssertEqual(all[0].averageProductPrice, 9)
        XCTAssertEqual(all[0].bestMatchValue, 9)
        XCTAssertEqual(all[0].deliveryCost, 9)
        XCTAssertEqual(all[0].distance, 9)
        XCTAssertEqual(all[0].minimumCost, 9)
        XCTAssertEqual(all[0].newestLevel, 9)
        XCTAssertEqual(all[0].popularity, 9)
        XCTAssertEqual(all[0].rating, 9)
        XCTAssertEqual(all[0].isFavourited, true)
        XCTAssertEqual(all[0].costLevel, .budget)
        XCTAssertEqual(all[0].status, .open)

        XCTAssertEqual(all[1].id, "5")
        XCTAssertEqual(all[1].name, "Fiver")
        XCTAssertEqual(all[1].averageProductPrice, 5)
        XCTAssertEqual(all[1].bestMatchValue, 5)
        XCTAssertEqual(all[1].deliveryCost, 5)
        XCTAssertEqual(all[1].distance, 5)
        XCTAssertEqual(all[1].minimumCost, 5)
        XCTAssertEqual(all[1].newestLevel, 5)
        XCTAssertEqual(all[1].popularity, 5)
        XCTAssertEqual(all[1].rating, 5)
        XCTAssertEqual(all[1].isFavourited, false)
        XCTAssertEqual(all[1].costLevel, .budget)
        XCTAssertEqual(all[1].status, .closed)
    }

    func testFavourite() {
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

        RealmService.save([rest1], to: realmInstance)
        let all = RealmService.getAll(from: realmInstance)
        XCTAssertEqual(all.count, 1)
        XCTAssertEqual(all[0].isFavourited, true)

        RealmService.favouriteRestaurant(rest1, in: realmInstance)
        XCTAssertEqual(all[0].isFavourited, false)

        RealmService.favouriteRestaurant(rest1, in: realmInstance)
        XCTAssertEqual(all[0].isFavourited, true)
    }
}
