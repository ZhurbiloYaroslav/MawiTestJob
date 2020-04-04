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
    var viewDidLoad: AnyObserver<Void> { get }
}

protocol MeasurementListViewModelOutputsType {
    var bkgColor: Observable<UIColor> { get }
    var values: Observable<[MeasurementModelling]> { get }
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
    private let viewDidLoad = PublishSubject<Void>()
    private let bkgColor = PublishSubject<UIColor>()
    private let listWithValues = PublishSubject<[MeasurementModelling]>()
    
    init() {
        input = Input(viewDidLoad: viewDidLoad.asObserver())
        output = Output(bkgColor: bkgColor.asObserver(),
                        values: listWithValues.asObserver())
        configure()
    }
    
    func configure() {
        viewDidLoad.subscribe(onNext: { [weak self] in
            self?.bkgColor.onNext(.white)
        }).disposed(by: disposeBag)
    }
}

extension MeasurementListViewModel {
    struct Input: MeasurementListViewModelInputsType {
        let viewDidLoad: AnyObserver<Void>
    }
    struct Output: MeasurementListViewModelOutputsType {
        let bkgColor: Observable<UIColor>
        let values: Observable<[MeasurementModelling]>
    }
}
