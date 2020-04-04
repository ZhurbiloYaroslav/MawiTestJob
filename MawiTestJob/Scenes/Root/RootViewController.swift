//
//  RootViewController.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import RxSwift

protocol RootViewControllerType: class, Presentable {
    typealias ViewModelType = RootViewModelType
    func inject(viewModel: ViewModelType)
    func update(childVC: UIViewController)
}

class RootViewController: UIViewController {
    private var current: UIViewController?
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.input.viewDidLoad.onNext(())
    }
    
    private func set(newChildVC: UIViewController) {
        if current != nil {
            add(newChildVC: newChildVC)
            current?.willMove(toParent: nil)
            current?.view.removeFromSuperview()
            current?.removeFromParent()
            current = newChildVC
        } else {
            add(newChildVC: newChildVC)
            current = newChildVC
        }
    }
    
    private func add(newChildVC: UIViewController) {
        addChild(newChildVC)
        newChildVC.view.frame = view.bounds
        view.addSubview(newChildVC.view)
        newChildVC.didMove(toParent: self)
    }
}

extension RootViewController: RootViewControllerType {
    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
    
    func update(childVC: UIViewController) {
        set(newChildVC: childVC)
    }
}
