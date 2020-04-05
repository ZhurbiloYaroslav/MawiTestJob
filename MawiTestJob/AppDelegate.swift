//
//  AppDelegate.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let appDependencyContainer = AppDependencyContainer()
    private var rootCoordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureRootScreenInWindow()
        return true
    }
    
    func configureRootScreenInWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        rootCoordinator = appDependencyContainer.makeRootCoordinator(window: window)
        rootCoordinator?.start()
    }
}

