//
//  String+Utils.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import Foundation

extension String {
    var timeOfDayString: String {
        #if DEBUG
        if TestingService.isUnderTest {
            return "Good morning"
        }
        #endif

        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 0..<12:
            return "Good morning"
        case 12..<17:
            return "Good afternoon"
        default:
            return "Good evening"
        }
    }
}
