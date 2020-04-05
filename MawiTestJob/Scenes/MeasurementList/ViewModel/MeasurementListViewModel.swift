//
//  MeasurementListViewModel.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface
protocol MeasurementListViewModelInputsType {
    /// Notifies when View did load
    var viewDidLoad: AnyObserver<Void> { get }
    /// Notifies when User pressed 'Add new measurement' button with specific time period
    var didPressAddNewMeasurement: AnyObserver<MeasurementTime> { get }
}

protocol MeasurementListViewModelOutputsType {
    /// Variable for testing purposes
    var sections: Observable<[MeasurementListSection]> { get }
    /// Notifies coordinator when we need navigate to 'Start new measurement screen'
    var navigateToStartNewMeasurement: Observable<MeasurementTime> { get }
}

protocol MeasurementListViewModelType {
    var input: MeasurementListViewModelInputsType { get }
    var output: MeasurementListViewModelOutputsType { get }
}

// MARK: - Implementation
class MeasurementListViewModel: MeasurementListViewModelType {
    let input: MeasurementListViewModelInputsType
    let output: MeasurementListViewModelOutputsType
    
    private let disposeBag = DisposeBag()
    // Inputs
    private let viewDidLoad = PublishSubject<Void>()
    private let didPressAddNewMeasurement = PublishSubject<MeasurementTime>()
    // Outputs
    private let sections = PublishSubject<[MeasurementListSection]>()
    private let navigateToStartNewMeasurement = PublishSubject<MeasurementTime>()
    
    init() {
        input = Input(viewDidLoad: viewDidLoad.asObserver(),
                      didPressAddNewMeasurement: didPressAddNewMeasurement.asObserver())
        output = Output(sections: sections.asObserver(),
                        navigateToStartNewMeasurement: navigateToStartNewMeasurement.asObserver())
        configure()
    }
    
    func configure() {
        viewDidLoad.subscribe(onNext: { [weak self] in
            let some = [MeasurementListSection(id: .measurement(MeasurementDisplayModel()))]
            self?.sections.onNext(some)
        }).disposed(by: disposeBag)
        didPressAddNewMeasurement.subscribe(onNext: { [weak self] timePeriod in
            self?.navigateToStartNewMeasurement.onNext(timePeriod)
        }).disposed(by: disposeBag)
    }
}

// MARK: - Inputs and Outputs
extension MeasurementListViewModel {
    struct Input: MeasurementListViewModelInputsType {
        let viewDidLoad: AnyObserver<Void>
        let didPressAddNewMeasurement: AnyObserver<MeasurementTime>
    }
    struct Output: MeasurementListViewModelOutputsType {
        let sections: Observable<[MeasurementListSection]>
        var navigateToStartNewMeasurement: Observable<MeasurementTime>
    }
}
