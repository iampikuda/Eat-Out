//
//  CALayer+Utils.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

extension CALayer {
    func applyShadow(_ shadowInfo: ShadowInfo?, cornerRadius: CGFloat) {
        guard let shadowInfo = shadowInfo else { return }
        masksToBounds = false
        shadowColor = shadowInfo.color.cgColor
        shadowOpacity = shadowInfo.alpha
        shadowOffset = CGSize(width: shadowInfo.x, height: shadowInfo.y)
        shadowRadius = shadowInfo.blur / 2.0

        if shadowInfo.spread == 0 {
            shadowPath = nil
        } else {
            let dx = -shadowInfo.spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        }

        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
    }
}

struct ShadowInfo: Equatable {
    static var defaultDropShadow: ShadowInfo {
        return ShadowInfo(
            color: .black,
            alpha: 0.25,
            x: 0,
            y: 1,
            blur: 5,
            spread: 0
        )
    }

    /// Shadow color
    let color: UIColor
    /// Shadow opacity
    let alpha: Float
    /// Horizontal offset
    let x: CGFloat
    /// Vertical offset
    let y: CGFloat
    /// Shadow blue
    let blur: CGFloat
    /// Padding on X & Y
    let spread: CGFloat
}

class ShadowView: UIView {
    public var shadowInfo: ShadowInfo? = ShadowInfo.defaultDropShadow

    override var bounds: CGRect {
        didSet {
            guard oldValue != bounds else { return }
            self.layer.applyShadow(self.shadowInfo, cornerRadius: self.layer.cornerRadius)
        }
    }
}
