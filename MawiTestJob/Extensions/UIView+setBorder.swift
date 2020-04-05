//
//  UIView+setBorder.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

extension UIView {
    public func setBorder(_ borderWidth: CGFloat = 1, color: UIColor, radius: CGFloat, clip: Bool = true) {
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
        layer.cornerRadius = radius
        clipsToBounds = clip
    }
    public func setRoundCorners(color: UIColor = .clear) {
        setBorder(color: color, radius: bounds.height / 2)
    }
}
