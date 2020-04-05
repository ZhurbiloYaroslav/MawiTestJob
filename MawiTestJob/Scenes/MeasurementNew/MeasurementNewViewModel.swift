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
protocol MeasurementNewViewModelInputsType: BaseViewModelInputs {}

protocol MeasurementNewViewModelOutputsType: BaseViewModelOutputs {
    /// Variable for testing purposes
    var values: Observable<[MeasurementType]> { get }
    var embedChartView: Observable<Void> { get }
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
    // Inputs
    private let viewDidLoad = PublishSubject<Void>()
    private let viewWillDeinit = PublishSubject<Void>()
    // Outputs
    private let listWithValues = PublishSubject<[MeasurementType]>()
    private let didFinishCoordinator = PublishSubject<Void>()
    private let embedChartView = PublishSubject<Void>()
    
    init() {
        input = Input(viewDidLoad: viewDidLoad.asObserver(),
                      viewWillDeinit: viewWillDeinit.asObserver())
        output = Output(values: listWithValues.asObserver(),
                        didFinishCoordinator: didFinishCoordinator.asObserver(),
                        embedChartView: embedChartView.asObserver())
        configure()
    }
    
    func configure() {
        //
        viewDidLoad.subscribe(onNext: { [weak self] in
            self?.embedChartView.onNext(())
        }).disposed(by: disposeBag)
        //
        viewWillDeinit.subscribe(onNext: { [weak self] in
            self?.didFinishCoordinator.onNext(())
        }).disposed(by: disposeBag)
    }
}

extension MeasurementNewViewModel {
    struct Input: MeasurementNewViewModelInputsType {
        let viewDidLoad: AnyObserver<Void>
        let viewWillDeinit: AnyObserver<Void>
    }
    struct Output: MeasurementNewViewModelOutputsType {
        let values: Observable<[MeasurementType]>
        let didFinishCoordinator: Observable<Void>
        let embedChartView: Observable<Void>
    }
}
