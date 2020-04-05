//
//  UINavigationController+pushFactory.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

extension UINavigationController {
    func pushViewController(viewController factory: () -> UIViewController, animated: Bool) {
        pushViewController(factory(), animated: animated)
    }
    func addChild(viewController factory: () -> UIViewController) {
        addChild(factory())
    }
    func present(viewController factory: () -> UIViewController, animated: Bool, completion: (() -> Void)?) {
        present(factory(), animated: animated, completion: completion)
    }
}
