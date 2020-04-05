//
//  MeasurementListCoordinator.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import RxSwift

typealias MeasurementListVCFactory = (_ viewModel: MeasurementListViewControllerType.ViewModelType) -> MeasurementListViewControllerType

struct MeasurementListCoordinatorDependencies {
    var measurementListViewControllerFactory: MeasurementListVCFactory
}

class MeasurementListCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let dependencies: MeasurementListCoordinatorDependencies
    private let measurementListViewModel: MeasurementListViewControllerType.ViewModelType
    
    init(measurementListViewModel: MeasurementListViewControllerType.ViewModelType, dependencies: () -> MeasurementListCoordinatorDependencies) {
        self.dependencies = dependencies()
        self.measurementListViewModel = measurementListViewModel
        super.init()
        configureNavigation()
    }
    
    private func configureNavigation() {
        measurementListViewModel.output
            .navigateToStartNewMeasurement
            .subscribe(onNext: { [weak self] timePeriod in
                self?.navigateToAddNewMeasurementScreen()
            }).disposed(by: disposeBag)
    }
    
    override func start() {
        navigationController.addChild(viewController: {
            dependencies
                .measurementListViewControllerFactory(measurementListViewModel)
                .getUIViewController()
        })
    }
}

extension MeasurementListCoordinator {
    private func navigateToAddNewMeasurementScreen() {
        // Implementation for testing purposes
        // TODO: Implement it with coordinator
        navigationController.present(viewController: {
            MeasurementNewViewController()
        }, animated: true, completion: nil)
    }
}
