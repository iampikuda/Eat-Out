//
//  UIColor+Utils.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

extension UIColor {
    static var primary: UIColor { return UIColor(hex: 0xFC8001) }
}

extension UIColor {
    convenience init(hex: UInt64) {
        var (a, r, g, b) = (hex >> 24 & 0xFF, hex >> 16 & 0xFF, hex >> 8 & 0xFF, hex & 0xFF)
        if a == 0 {
            a = 0xFF
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
