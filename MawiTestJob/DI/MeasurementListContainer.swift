//
//  MeasurementListContainer.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Swinject

class MeasurementListContainer {
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer) { container in
            container.register(MeasurementListCoordinator.self) { resolver in
                let viewModel = resolver.resolve(MeasurementListViewModelType.self)!
                return MeasurementListCoordinator(measurementListViewModel: viewModel, dependencies: {
                    resolver.resolve(MeasurementListCoordinatorDependencies.self, argument: viewModel)!
                })
            }
            container.register(MeasurementListViewModelType.self) { resolver -> MeasurementListViewModelType in
                let dataSource = resolver.resolve(MeasurementListDataSourceType.self)!
                return MeasurementListViewModel(dataSource: dataSource)
            }
            container.register(MeasurementListDataSourceType.self) { resolver -> MeasurementListDataSourceType in
                MeasurementListDataSource()
            }
            container.register(MeasurementListViewControllerType.self) { resolver -> MeasurementListViewControllerType in
                R.storyboard.measurementList.measurementListViewController()!
            }
            container.register(MeasurementListCoordinatorDependencies.self) {
                (resolver, viewModel: MeasurementListViewControllerType.ViewModelType) -> MeasurementListCoordinatorDependencies in
                let factory = resolver.resolve(MeasurementListVCFactory.self, argument: viewModel)!
                return MeasurementListCoordinatorDependencies(measurementListViewControllerFactory: factory)
            }
            container.register(MeasurementListVCFactory.self) {
                (resolver, viewModel: MeasurementListViewControllerType.ViewModelType) -> MeasurementListVCFactory in
                return { viewModel in
                    let viewController = resolver.resolve(MeasurementListViewControllerType.self)!
                    viewController.inject(viewModel: viewModel)
                    return viewController
                }
            }
        }
    }
    
    public func makeMeasurementListCoordinator() -> MeasurementListCoordinator {
        container.resolve(MeasurementListCoordinator.self)!
    }
}
