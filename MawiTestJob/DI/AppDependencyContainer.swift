//
//  AppDependencyContainer.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Swinject

class AppDependencyContainer {
    private lazy var appDIContainer: Container = {
        Container { container in
            container.register(RootDIContainer.self) { resolver -> RootDIContainer in
                RootDIContainer(parentContainer: container)
            }
        }
    }()
    
    func makeRootCoordinator() -> RootCoordinator {
        appDIContainer.resolve(RootDIContainer.self)!.makeRootCoordinator()
    }
}
