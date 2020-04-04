//
//  RootViewModel.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface
protocol RootViewModelInputsType {
    var viewDidLoad: AnyObserver<Void> { get }
}

protocol RootViewModelOutputsType {
    var setInitialScreen: Observable<Void> { get }
}

protocol RootViewModelType {
    var input: RootViewModelInputsType { get }
    var output: RootViewModelOutputsType { get }
}

// MARK: - Implementation
class RootViewModel: RootViewModelType {
    let input: RootViewModelInputsType
    let output: RootViewModelOutputsType

    private let disposeBag = DisposeBag()
    private let viewDidLoad = PublishSubject<Void>()
    private let setInitialScreen = PublishSubject<Void>()
    
    init() {
        input = Input(viewDidLoad: viewDidLoad.asObserver())
        output = Output(setInitialScreen: setInitialScreen.asObserver())
            configure()
        }
        
        func configure() {
            viewDidLoad.subscribe(onNext: { [weak self] in
                self?.setInitialScreen.onNext(())
            }).disposed(by: disposeBag)
        }
}

extension RootViewModel {
    struct Input: RootViewModelInputsType {
        let viewDidLoad: AnyObserver<Void>
    }
    struct Output: RootViewModelOutputsType {
        let setInitialScreen: Observable<Void>
    }
}
