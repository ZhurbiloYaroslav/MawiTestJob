//
//  MeasurementNewCoordinator.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import RxSwift

typealias MeasurementNewVCFactory = (_ viewModel: MeasurementNewViewControllerType.ViewModelType) -> MeasurementNewViewControllerType
typealias MeasurementNewCoordinatorFactory = () -> MeasurementNewCoordinator

struct MeasurementNewCoordinatorDependencies {
    var measurementNewViewControllerFactory: MeasurementNewVCFactory
}

class MeasurementNewCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let dependencies: MeasurementNewCoordinatorDependencies
    private let measurementNewViewModel: MeasurementNewViewControllerType.ViewModelType
    private weak var measurementNewViewController: MeasurementNewViewControllerType?
    //
    private var chartViewModel: ChartViewModelType?
    
    init(measurementNewViewModel: MeasurementNewViewControllerType.ViewModelType, dependencies: () -> MeasurementNewCoordinatorDependencies) {
        self.dependencies = dependencies()
        self.measurementNewViewModel = measurementNewViewModel
        super.init()
        configureNavigation()
    }
    
    private func configureNavigation() {
        // Write comment here
        measurementNewViewModel.output
            .embedChartView.subscribe(onNext: { [weak self] in
                self?.embedChartView()
        }).disposed(by: disposeBag)
        // Write comment here
        measurementNewViewModel.output
            .didFinishCoordinator.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.parentCoordinator?.didFinish(coordinator: self)
            }).disposed(by: disposeBag)
    }
    
    override func start() {
        let viewControllerType = dependencies.measurementNewViewControllerFactory(measurementNewViewModel)
        navigationController.pushViewController(viewControllerType.getUIViewController(), animated: true)
        measurementNewViewController = viewControllerType
    }
    
    private func embedChartView() {
        guard let measurementNewViewController = measurementNewViewController
            else { return }
        let chartViewModel = ChartViewModel()
        let chartViewController = R.storyboard.chartView.chartViewController()!
        chartViewController.inject(viewModel: chartViewModel)
        measurementNewViewController.embed(chartViewController: chartViewController)
        self.chartViewModel = chartViewModel
    }
}
