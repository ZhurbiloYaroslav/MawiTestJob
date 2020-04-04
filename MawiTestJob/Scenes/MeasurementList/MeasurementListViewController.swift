//
//  MeasurementListViewController.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol MeasurementListViewControllerType: Presentable {
    typealias ViewModelType = MeasurementListViewModelType
    func inject(viewModel: ViewModelType)
}

class MeasurementListViewController: UIViewController, MeasurementListViewControllerType {
    
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        bindViewModel()
        viewModel?.input.viewDidLoad.onNext(())
    }
    
    private func bindViewModel() {
        viewModel?.output.bkgColor
            .subscribe(onNext: { [weak self] color in
                self?.view.backgroundColor = color
            }).disposed(by: disposeBag)
    }
}

extension MeasurementListViewController {
    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}
