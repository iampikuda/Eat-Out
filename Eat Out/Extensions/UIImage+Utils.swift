//
//  UIImage+Utils.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

extension UIImage {
    convenience init?(imageName: ImageName) {
        self.init(named: imageName.rawValue)
    }
}
