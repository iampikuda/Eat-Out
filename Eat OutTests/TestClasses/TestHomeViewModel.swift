//
//  TestHomeViewModel.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import Foundation
import RealmSwift

@testable import Eat_Out

final class TestHomeViewModel: HomeViewModel {
    override var realmInstance: Realm {
        return try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: realmIdentifier))
    }

    let realmIdentifier: String

    init(realmIdentifier: String) {
        self.realmIdentifier = realmIdentifier
    }
}
