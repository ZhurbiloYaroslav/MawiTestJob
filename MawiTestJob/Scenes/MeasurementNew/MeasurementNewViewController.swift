//
//  MeasurementNewViewController.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol MeasurementNewViewControllerType: UIViewControllerGettable {
    typealias ViewModelType = MeasurementNewViewModelType
    func inject(viewModel: ViewModelType)
}

class MeasurementNewViewController: UIViewController, MeasurementNewViewControllerType {
    
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel?.input.viewDidLoad.onNext(())
    }
    
    deinit {
        viewModel?.input.viewWillDeinit.onNext(())
    }
    
    private func bindViewModel() {
        
    }
}

extension MeasurementNewViewController {
    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}
