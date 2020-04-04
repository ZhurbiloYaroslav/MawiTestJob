//
//  RootDIContainer.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Swinject
import RxSwift

class RootDIContainer {
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer) { container in
            container.register(RootCoordinator.self) { resolver -> RootCoordinator in
                let viewModel = resolver.resolve(RootViewModelType.self)!
                return RootCoordinator(rootViewModel: viewModel, dependencies: {
                    resolver.resolve(RootCoordinatorDependenciesType.self)!
                })
            }
            container.register(RootViewModelType.self) { resolver -> RootViewModelType in
                RootViewModel()
            }
            container.register(RootViewControllerType.self) { resolver -> RootViewControllerType in
                RootViewController()
            }
            container.register(RootCoordinatorDependenciesType.self) { resolver -> RootCoordinatorDependenciesType in
                return RootCoordinatorDependencies(rootViewControllerFactory: resolver.resolve(RootViewControllerFactory.self)!,
                                                   measurementListCoordinatorFactory: resolver.resolve(MeasurementListCoordinatorFactory.self)!)
            }
            container.register(RootViewControllerFactory.self) { resolver -> RootViewControllerFactory in
                return { viewModel -> RootViewControllerType in
                    let viewController = resolver.resolve(RootViewControllerType.self)!
                    viewController.inject(viewModel: viewModel)
                    return viewController
                }
            }
            container.register(MeasurementListCoordinatorFactory.self) { _ in
                return {
                    MeasurementListContainer(parentContainer: container).makeMeasurementListCoordinator()
                }
            }
        }
    }
    
    func makeRootCoordinator() -> RootCoordinator {
        container.resolve(RootCoordinator.self)!
    }
}
