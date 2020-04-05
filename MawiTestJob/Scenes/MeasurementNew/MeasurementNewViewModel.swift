//
//  MeasurementNewViewModel.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface
protocol MeasurementNewViewModelInputsType {
    /// Notifies when View did load
    var viewDidLoad: AnyObserver<Void> { get }
}

protocol MeasurementNewViewModelOutputsType {
    /// Variable for testing purposes
    var bkgColor: Observable<UIColor> { get }
    /// Variable for testing purposes
    var values: Observable<[MeasurementType]> { get }
}

protocol MeasurementNewViewModelType {
    var input: MeasurementNewViewModelInputsType { get }
    var output: MeasurementNewViewModelOutputsType { get }
}

// MARK: - Implementation
class MeasurementNewViewModel: MeasurementNewViewModelType {
    let input: MeasurementNewViewModelInputsType
    let output: MeasurementNewViewModelOutputsType

    private let disposeBag = DisposeBag()
    private let viewDidLoad = PublishSubject<Void>()
    private let bkgColor = PublishSubject<UIColor>()
    private let listWithValues = PublishSubject<[MeasurementType]>()
    
    init() {
        input = Input(viewDidLoad: viewDidLoad.asObserver())
        output = Output(bkgColor: bkgColor.asObserver(),
                        values: listWithValues.asObserver())
        configure()
    }
    
    func configure() {
        viewDidLoad.subscribe(onNext: { [weak self] in
            self?.bkgColor.onNext(.blue)
        }).disposed(by: disposeBag)
    }
}

extension MeasurementNewViewModel {
    struct Input: MeasurementNewViewModelInputsType {
        let viewDidLoad: AnyObserver<Void>
    }
    struct Output: MeasurementNewViewModelOutputsType {
        let bkgColor: Observable<UIColor>
        let values: Observable<[MeasurementType]>
    }
}
