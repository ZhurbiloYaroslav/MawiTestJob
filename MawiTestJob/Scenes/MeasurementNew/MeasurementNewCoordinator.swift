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
    
    init(measurementNewViewModel: MeasurementNewViewControllerType.ViewModelType, dependencies: () -> MeasurementNewCoordinatorDependencies) {
        self.dependencies = dependencies()
        self.measurementNewViewModel = measurementNewViewModel
        super.init()
        configureNavigation()
    }
    
    private func configureNavigation() {
        // Write comment here
        measurementNewViewModel.output
            .didFinishCoordinator.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.parentCoordinator?.didFinish(coordinator: self)
            }).disposed(by: disposeBag)
    }
    
    override func start() {
        navigationController.pushViewController(viewController: {
            dependencies
                .measurementNewViewControllerFactory(measurementNewViewModel)
                .getUIViewController()
        }, animated: true)
    }
}
