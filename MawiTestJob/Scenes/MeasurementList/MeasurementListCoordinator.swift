//
//  MeasurementListCoordinator.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Interface
typealias MeasurementListVCFactory = (_ viewModel: MeasurementListViewControllerType.ViewModelType) -> MeasurementListViewControllerType

protocol MeasurementListCoordinatorDependenciesType  {
    var measurementListViewControllerFactory: MeasurementListVCFactory { get }
}

// MARK: - Implementation
struct MeasurementListCoordinatorDependencies: MeasurementListCoordinatorDependenciesType {
    var measurementListViewControllerFactory: MeasurementListVCFactory
}

class MeasurementListCoordinator: BaseCoordinator, Presentable {
    private let dependencies: MeasurementListCoordinatorDependenciesType
    private let measurementListViewModel: MeasurementListViewControllerType.ViewModelType
    
    init(measurementListViewModel: MeasurementListViewControllerType.ViewModelType, dependencies: () -> MeasurementListCoordinatorDependenciesType) {
        self.measurementListViewModel = measurementListViewModel
        self.dependencies = dependencies()
    }
    
    override func start() {
        // Intentionally left blank
    }
    
    func toPresentable() -> UIViewController {
        dependencies.measurementListViewControllerFactory(measurementListViewModel)
            .toPresentable()
    }
}
