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
        
    }
    
    override func start() {
        navigationController.pushViewController(viewController: {
            dependencies
                .measurementNewViewControllerFactory(measurementNewViewModel)
                .getUIViewController()
        }, animated: true)
    }
}
