//
//  ChartViewModel.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface
protocol ChartViewModelInputsType: BaseViewModelInputs {
    
}

protocol ChartViewModelOutputsType {
    
}

protocol ChartViewModelType {
    var input: ChartViewModelInputsType { get }
    var output: ChartViewModelOutputsType { get }
}

// MARK: - Implementation

class ChartViewModel: ChartViewModelType {
    
    let input: ChartViewModelInputsType
    let output: ChartViewModelOutputsType
    
    private let disposeBag = DisposeBag()
    // Inputs
    private let viewDidLoad = PublishSubject<Void>()
    private let viewWillDeinit = PublishSubject<Void>()
    
    init() {
        input = Input(viewDidLoad: viewDidLoad.asObserver(),
                      viewWillDeinit: viewWillDeinit.asObserver())
        output = Output()
        configure()
    }
    
    func configure() {
        viewDidLoad.subscribe(onNext: { [weak self] in
            
        }).disposed(by: disposeBag)
        viewWillDeinit.subscribe(onNext: { [weak self] in
            
        }).disposed(by: disposeBag)
    }
}

// MARK: - Inputs and Outputs
extension ChartViewModel {
    struct Input: ChartViewModelInputsType {
        let viewDidLoad: AnyObserver<Void>
        let viewWillDeinit: AnyObserver<Void>
    }
    struct Output: ChartViewModelOutputsType {
        
    }
}
