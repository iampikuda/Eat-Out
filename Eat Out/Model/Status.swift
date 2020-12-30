//
//  Status.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import Foundation

enum Status: Int {
    case open = 0
    case orderAhead = 1
    case closed = 2

    init(_ statusString: String) {
        switch statusString.lowercased() {
        case "open":
            self = .open
        case "closed":
            self = .closed
        case "order ahead":
            self = .orderAhead
        default:
            assertionFailure("Case does not exist, please add")
            self = .open
        }
    }
}
