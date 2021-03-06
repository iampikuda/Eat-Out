//
//  UIView+Utils.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }

    func addCorners(radius: CGFloat, lr: Bool = false, ll: Bool = false, tr: Bool = false, tl: Bool = false) {
        layer.cornerRadius = radius
        layer.maskedCorners = []

        if lr { layer.maskedCorners.insert(.layerMaxXMaxYCorner) }
        if ll { layer.maskedCorners.insert(.layerMinXMaxYCorner) }
        if tr { layer.maskedCorners.insert(.layerMaxXMinYCorner) }
        if tl { layer.maskedCorners.insert(.layerMinXMinYCorner) }
    }

    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
}
