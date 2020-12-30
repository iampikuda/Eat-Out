//
//  RealmUpdateDelegate.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import Foundation

protocol RealmUpdateDelegate: class {
    func gotInitialUpdate()
    func reloadEverything()
    func gotError(_ error: Error)
}
