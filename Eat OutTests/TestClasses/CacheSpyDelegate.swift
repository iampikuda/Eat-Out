//
//  CacheSpyDelegate.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import Foundation

@testable import Eat_Out

final class CacheSpyDelegate: CacheDelegate {
    var error: Error?

    func gotError(_ error: Error) {
        self.error = error
    }
}
