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
protocol MeasurementListViewModelInputsType: BaseViewModelInputs {
    /// Notifies when User pressed 'Add new measurement' button with specific time period
    var didPressAddNewMeasurement: AnyObserver<MeasurementTime> { get }
    /// Write comment here
    var didSelectMeasurement: AnyObserver<IDContainable> { get }
}

protocol MeasurementListViewModelOutputsType: BaseViewModelOutputs {
    /// Variable for testing purposes
    var updateData: Observable<Void> { get }
    /// Notifies coordinator when we need navigate to 'Start new measurement screen'
    var navigateToStartNewMeasurement: Observable<MeasurementTime> { get }
    /// Notifies coordinator when we need navigate to show 'Measurement info screen'
    var navigateToShowMeasurementInfo: Observable<MeasurementDataSet> { get }
}

protocol MeasurementListViewModelType {
    var input: MeasurementListViewModelInputsType { get }
    var output: MeasurementListViewModelOutputsType { get }
    var dataSource: MeasurementListDataSourceType { get }
}

// MARK: - Implementation
class MeasurementListViewModel: MeasurementListViewModelType {
    
    let input: MeasurementListViewModelInputsType
    let output: MeasurementListViewModelOutputsType
    let dataSource: MeasurementListDataSourceType
    
    private let disposeBag = DisposeBag()
    // Inputs
    private let viewDidLoad = PublishSubject<Void>()
    private let viewWillDeinit = PublishSubject<Void>()
    private let didPressAddNewMeasurement = PublishSubject<MeasurementTime>()
    private let didSelectMeasurement = PublishSubject<IDContainable>()
    // Outputs
    private let updateData = PublishSubject<Void>()
    private let navigateToStartNewMeasurement = PublishSubject<MeasurementTime>()
    private let navigateToShowMeasurementInfo = PublishSubject<MeasurementDataSet>()
    private let didFinishCoordinator = PublishSubject<Void>()
    
    init(dataSource: MeasurementListDataSourceType) {
        self.dataSource = dataSource
        input = Input(viewDidLoad: viewDidLoad.asObserver(),
                      viewWillDeinit: viewWillDeinit.asObserver(),
                      didPressAddNewMeasurement: didPressAddNewMeasurement.asObserver(),
                      didSelectMeasurement: didSelectMeasurement.asObserver())
        output = Output(updateData: updateData.asObserver(),
                        navigateToStartNewMeasurement: navigateToStartNewMeasurement.asObserver(),
                        navigateToShowMeasurementInfo: navigateToShowMeasurementInfo.asObserver(),
                        didFinishCoordinator: didFinishCoordinator.asObserver())
        configure()
    }
    
    private func configure() {
        commonLifecycleInputs()
        didPressAddNewMeasurement.subscribe(onNext: { [weak self] timePeriod in
            self?.navigateToStartNewMeasurement.onNext(timePeriod)
        }).disposed(by: disposeBag)
        didSelectMeasurement.flatMap({ [weak self] measurement in
            return self?.dataSource.getMeasurementWith(id: measurement) ?? Observable.empty()
        }).subscribe(onNext: { [weak self] measurementDataSet in
            self?.navigateToShowMeasurementInfo.onNext(measurementDataSet)
        })
    }
    
    private func commonLifecycleInputs() {
        viewDidLoad.subscribe(onNext: { [weak self] in
            self?.updateData.onNext(())
        }).disposed(by: disposeBag)
        viewWillDeinit.subscribe(onNext: { [weak self] in
            self?.didFinishCoordinator.onNext(())
        }).disposed(by: disposeBag)
    }
}

// MARK: - Inputs and Outputs
extension MeasurementListViewModel {
    struct Input: MeasurementListViewModelInputsType {
        let viewDidLoad: AnyObserver<Void>
        let viewWillDeinit: AnyObserver<Void>
        let didPressAddNewMeasurement: AnyObserver<MeasurementTime>
        let didSelectMeasurement: AnyObserver<IDContainable>
    }
    struct Output: MeasurementListViewModelOutputsType {
        let updateData: Observable<Void>
        let navigateToStartNewMeasurement: Observable<MeasurementTime>
        let navigateToShowMeasurementInfo: Observable<MeasurementDataSet>
        let didFinishCoordinator: Observable<Void>
    }
}
