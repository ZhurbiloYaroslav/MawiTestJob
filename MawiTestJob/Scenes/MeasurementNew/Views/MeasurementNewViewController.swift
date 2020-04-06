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

protocol MeasurementNewViewControllerType: class, UIViewControllerGettable {
    typealias ViewModelType = MeasurementNewViewModelType
    func inject(viewModel: ViewModelType)
    func embed(chartViewController: UIViewController)
}

class MeasurementNewViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModelType?
    
    @IBOutlet private weak var chartViewContainer: UIView!
    private weak var embededChartViewController: UIViewController?
    
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

    private func addToChartViewContainer(chartVC: UIViewController) {
        addChild(chartVC)
        chartVC.view.frame = chartViewContainer.bounds
        chartViewContainer.addSubview(chartVC.view)
        chartVC.didMove(toParent: self)
    }
}

extension MeasurementNewViewController: MeasurementNewViewControllerType {
    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
    
    func embed(chartViewController: UIViewController) {
        if embededChartViewController != nil {
            addToChartViewContainer(chartVC: chartViewController)
            embededChartViewController?.willMove(toParent: nil)
            embededChartViewController?.view.removeFromSuperview()
            embededChartViewController?.removeFromParent()
            embededChartViewController = chartViewController
        } else {
            addToChartViewContainer(chartVC: chartViewController)
            embededChartViewController = chartViewController
        }
    }
}

