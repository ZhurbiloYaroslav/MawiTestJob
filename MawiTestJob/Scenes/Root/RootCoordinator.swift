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

// MARK: - Implementation
struct RootCoordinatorDependencies {
    let windowFactory: () -> UIWindow
    let rootViewControllerFactory: RootViewControllerFactory
    let measurementListCoordinatorFactory: MeasurementListCoordinatorFactory
}

class RootCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let dependencies: RootCoordinatorDependencies
    private let rootViewModel: RootViewControllerType.ViewModelType
    private weak var rootViewController: RootViewControllerType?
    
    init(rootViewModel: RootViewControllerType.ViewModelType, dependencies: () -> RootCoordinatorDependencies) {
        self.dependencies = dependencies()
        self.rootViewModel = rootViewModel
        super.init()
        bindRootViewModel()
    }
    
    override func start() {
        configure(in: dependencies.windowFactory())
    }
    
    private func bindRootViewModel() {
        rootViewModel.output.setInitialScreen
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.navigateToMeasurementListScreen()
            }).disposed(by: disposeBag)
    }
    
    private func configure(in window: UIWindow) {
        window.rootViewController = {
            let rootVC = dependencies.rootViewControllerFactory(rootViewModel)
            rootViewController = rootVC
            return rootVC.getUIViewController()
        }()
        window.makeKeyAndVisible()
    }
}

// MARK: - Navigation methods
extension RootCoordinator {
    private func navigateToMeasurementListScreen() {
        let coordinator = dependencies.measurementListCoordinatorFactory()
        start(coordinator: coordinator)
        rootViewController?.update(childVC: coordinator.navigationController)
    }
}
