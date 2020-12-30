//
//  UIBarButtonItem+Utils.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

extension UIBarButtonItem {
    static func makeButton(
        _ target: Any?,
        action: Selector,
        imageName: ImageName,
        imageColor: UIColor = UIColor.black,
        width: CGFloat = 44,
        height: CGFloat = 44
    ) -> UIBarButtonItem {

        let button = UIButton(type: .custom)
        button.setImage(UIImage(imageName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .right
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = imageColor

        let barButton = UIBarButtonItem.init(customView: button)
        barButton.customView?.widthAnchor.constraint(equalToConstant: width).isActive = true
        barButton.customView?.heightAnchor.constraint(equalToConstant: height).isActive = true

        return barButton
    }
}
