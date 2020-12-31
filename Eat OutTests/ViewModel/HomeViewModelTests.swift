//
//  HomeViewModelTests.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import XCTest
import RealmSwift

@testable import Eat_Out

class HomeViewModelTests: XCTestCase {
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

    func testFavourite() {
        let vm = TestHomeViewModel(realmIdentifier: self.name)
        TestCacheSerive(realmIdentifier: self.name).getRestaurants(from: .good)
        let all = RealmService.getAll(from: realmInstance)

        XCTAssertEqual(all.filter({ $0.isFavourited == true }).count, 0)

        let restaurant = Restaurant(id: "1")

        vm.favouriteResturant(restaurant)

        XCTAssertEqual(all.filter({ $0.isFavourited == true }).count, 1)

        vm.favouriteResturant(restaurant)

        XCTAssertEqual(all.filter({ $0.isFavourited == true }).count, 0)
    }

    func testRestaurantAt() {
        let vm = TestHomeViewModel(realmIdentifier: self.name)
        TestCacheSerive(realmIdentifier: self.name).getRestaurants(from: .good)
        guard let first = RealmService.getAll(from: realmInstance).first else {
            XCTFail("Can't find first element")
            return
        }

        XCTAssertEqual(vm.restaurantAt(IndexPath(row: 0, section: 0)).id, first.id)

        vm.filterText = "Dam"
        XCTAssertNotEqual(vm.restaurantAt(IndexPath(row: 0, section: 0)).id, first.id)
    }

    func testFilteredArray() {
        let vm = TestHomeViewModel(realmIdentifier: self.name)
        TestCacheSerive(realmIdentifier: self.name).getRestaurants(from: .good)

        XCTAssertEqual(vm.filteredArray.count, 0)

        vm.filterText = "sushi"

        XCTAssertNotEqual(vm.filteredArray.count, 0)

        for rest in vm.filteredArray {
            XCTAssertTrue(rest.name.lowercased().contains("sushi"))
        }
    }

    func testOrder() {
        let vm = TestHomeViewModel(realmIdentifier: self.name)
        vm.ascendingOrder = false
        TestCacheSerive(realmIdentifier: self.name).getRestaurants(from: .good)

        guard let firstAsc = vm.allRestaurant.first else {
            XCTFail("Can't find first element")
            return
        }

        vm.ascendingOrder = true

        guard let firstDesc = vm.allRestaurant.first else {
            XCTFail("Can't find first element")
            return
        }

        XCTAssertNotEqual(firstAsc.id, firstDesc.id)
    }

    func testFiltered() {
        let vm = HomeViewModel()
        XCTAssertFalse(vm.filtered)
        vm.filterText = "q23"
        XCTAssertTrue(vm.filtered)
        vm.filterText = ""
        XCTAssertFalse(vm.filtered)
        vm.filterText = "sushi"
        XCTAssertTrue(vm.filtered)
    }

    func testSorter() {
        let rest1 = Restaurant(id: "1",averageProductPrice: 11, bestMatchValue: 111, deliveryCost: 9870)
        let rest2 = Restaurant(id: "2",averageProductPrice: 200, bestMatchValue: 1981, deliveryCost: 1)
        let rest3 = Restaurant(id: "3",averageProductPrice: 10, bestMatchValue: 1100, deliveryCost: 21)
        let rest4 = Restaurant(id: "4",averageProductPrice: 1111, bestMatchValue: 11, deliveryCost: 31)
        let rest5 = Restaurant(id: "5",averageProductPrice: 999, bestMatchValue: 1, deliveryCost: 11)

        RealmService.save([rest1, rest2, rest3, rest4, rest5], to: realmInstance)

        let vm = TestHomeViewModel(realmIdentifier: self.name)
        XCTAssertEqual(vm.allRestaurant[0].id, "2")

        vm.sorter = .averageProductPrice
        XCTAssertEqual(vm.allRestaurant[0].id, "4")

        vm.sorter = .deliveryCosts
        XCTAssertEqual(vm.allRestaurant[0].id, "1")
    }
}
