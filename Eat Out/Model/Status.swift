//
//  Status.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

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

    var text: String {
        switch self {
        case .open: return ""
        case .orderAhead: return "ORDER AHEAD"
        case .closed: return "CLOSED"
        }
    }

    var isHidden: Bool {
        switch self {
        case .open: return true
        case .orderAhead: return false
        case .closed: return false
        }
    }

    var color: UIColor {
        switch self {
        case .open: return .clear
        case .orderAhead: return .primary
        case .closed: return .red
        }
    }
}
