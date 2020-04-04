//
//  RootCoordinator.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Interface
typealias RootViewControllerFactory = (RootViewControllerType.ViewModelType) -> RootViewControllerType
typealias MeasurementListCoordinatorFactory = () -> MeasurementListCoordinator

protocol RootCoordinatorDependenciesType  {
    var rootViewControllerFactory: RootViewControllerFactory { get }
    var measurementListCoordinatorFactory: MeasurementListCoordinatorFactory { get }
}

// MARK: - Implementation
struct RootCoordinatorDependencies: RootCoordinatorDependenciesType {
    var rootViewControllerFactory: RootViewControllerFactory
    var measurementListCoordinatorFactory: MeasurementListCoordinatorFactory
}

class RootCoordinator: BaseCoordinator {
    private let dependencies: RootCoordinatorDependenciesType
    private let rootViewModel: RootViewControllerType.ViewModelType
    private weak var rootViewController: RootViewControllerType?
    private let disposeBag = DisposeBag()
    
    init(rootViewModel: RootViewControllerType.ViewModelType, dependencies: () -> RootCoordinatorDependenciesType) {
        self.dependencies = dependencies()
        self.rootViewModel = rootViewModel
        super.init()
        bindRootViewModel()
    }
    
    override func start() {
        // Intentionally left blank
    }
    
    private func bindRootViewModel() {
        rootViewModel.output.setInitialScreen
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.navigateToMeasurementListScreen()
            }).disposed(by: disposeBag)
    }
    
    private func navigateToMeasurementListScreen() {
        let coordinator = dependencies.measurementListCoordinatorFactory()
        let viewController = coordinator.toPresentable()
        coordinator.start(coordinator: self)
        rootViewController?.update(childVC: viewController)
    }
}

extension RootCoordinator: UIWindowConfigurable {
    func configure(in window: UIWindow) {
        window.rootViewController = {
            let rootVC = dependencies.rootViewControllerFactory(rootViewModel)
            rootViewController = rootVC
            return rootVC.toPresentable()
        }()
        window.makeKeyAndVisible()
    }
}
