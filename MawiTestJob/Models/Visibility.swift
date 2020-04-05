//
//  Visibility.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

public enum Visibility {
    case visible, hidden
    var isVisible: Bool { return self == .visible }
    var isHidden: Bool { return self == .hidden }
    
    init(isVisible: Bool) {
        self = isVisible
            ? .visible
            : .hidden
    }
    
    init(isHidden: Bool) {
        self = isHidden
            ? .hidden
            : .visible
    }
}
