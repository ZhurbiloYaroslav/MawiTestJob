//
//  BaseViewModelInputsOutputs.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseViewModelInputs {
    /// Notifies when View did load
    var viewDidLoad: AnyObserver<Void> { get }
    /// Deinit notification from UIViewController
    var viewWillDeinit: AnyObserver<Void> { get }
}

protocol BaseViewModelOutputs {
    /// Notifies coordinator to finish flow and remove itself
    var didFinishCoordinator: Observable<Void> { get }
}
