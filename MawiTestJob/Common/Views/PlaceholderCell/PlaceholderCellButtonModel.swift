//
//  PlaceholderCellButtonModel.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import BonMot

protocol PlaceholderCellButtonModelling {
    var title: NSAttributedString { get }
    var backgroundColor: UIColor { get }
    var buttonAction: () -> Void { get }
}

extension PlaceholderCellButtonModelling {
    static var textStyle: StringStyle {
        StringStyle(.font(UIFont.defaultFont(.regular, size: 14)),
                    .color(.white))
    }
}

struct PlaceholderCellErrorButtonModel: PlaceholderCellButtonModelling {
    var title: NSAttributedString {
        "Try again later".styled(with: Self.textStyle)
    }
    var backgroundColor: UIColor { #colorLiteral(red: 0.9582068324, green: 0.2639927566, blue: 0.2124654949, alpha: 1) }
    var buttonAction: () -> Void
}

struct PlaceholderCellEmptyButtonModel: PlaceholderCellButtonModelling {
    var title: NSAttributedString {
        "Reload".styled(with: Self.textStyle)
    }
    var backgroundColor: UIColor { #colorLiteral(red: 0.1301785111, green: 0.5873633027, blue: 0.9524403214, alpha: 1) }
    var buttonAction: () -> Void
}
