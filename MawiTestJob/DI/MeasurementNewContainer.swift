//
//  MeasurementNewContainer.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Swinject

class MeasurementNewContainer {
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer) { container in
            container.register(MeasurementNewCoordinator.self) { resolver in
                let viewModel = resolver.resolve(MeasurementNewViewModelType.self)!
                return MeasurementNewCoordinator(measurementNewViewModel: viewModel, dependencies: {
                    resolver.resolve(MeasurementNewCoordinatorDependencies.self, argument: viewModel)!
                })
            }
            container.register(MeasurementNewViewModelType.self) { resolver -> MeasurementNewViewModelType in
                MeasurementNewViewModel()
            }
            container.register(MeasurementNewViewControllerType.self) { resolver -> MeasurementNewViewControllerType in
                R.storyboard.measurementNew.measurementNewViewController()!
            }
            container.register(MeasurementNewCoordinatorDependencies.self) {
                (resolver, viewModel: MeasurementNewViewControllerType.ViewModelType) -> MeasurementNewCoordinatorDependencies in
                let factory = resolver.resolve(MeasurementNewVCFactory.self, argument: viewModel)!
                return MeasurementNewCoordinatorDependencies(measurementNewViewControllerFactory: factory)
            }
            container.register(MeasurementNewVCFactory.self) {
                (resolver, viewModel: MeasurementNewViewControllerType.ViewModelType) -> MeasurementNewVCFactory in
                return { viewModel in
                    let viewController = resolver.resolve(MeasurementNewViewControllerType.self)!
                    viewController.inject(viewModel: viewModel)
                    return viewController
                }
            }
        }
    }
    
    public func makeMeasurementNewCoordinator() -> MeasurementNewCoordinator {
        container.resolve(MeasurementNewCoordinator.self)!
    }
}
