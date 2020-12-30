//
//  CostLevel.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import Foundation

enum CostLevel: String {
    case budget = "€"
    case average = "€€"
    case expensive = "€€€"
    case baller = "€€€€"

    init(cost: Float) {
        if cost <= 900 {
            self = .budget
        } else if cost > 900 && cost <= 1500 {
            self = .average
        } else if cost > 1500 && cost <= 2600 {
            self = .expensive
        } else {
            self = .baller
        }
    }
}
