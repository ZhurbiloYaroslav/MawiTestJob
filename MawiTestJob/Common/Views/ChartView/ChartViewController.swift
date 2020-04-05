//
//  ChartViewController.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Charts

protocol ChartViewControllerType: UIViewControllerGettable {
    typealias ViewModelType = ChartViewModelType
    func inject(viewModel: ViewModelType)
}

class ChartViewController: UIViewController {
    
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

extension ChartViewController: ChartViewControllerType {
    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}
