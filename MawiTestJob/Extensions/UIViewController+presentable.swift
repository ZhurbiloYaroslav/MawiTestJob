//
//  UIViewController+presentable.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

extension UIViewController: UIViewControllerGettable {
    func getUIViewController() -> UIViewController { self }
}
