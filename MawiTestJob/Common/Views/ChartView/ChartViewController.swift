//
//  ChartViewController.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Charts

protocol ChartViewControllerType: UIViewControllerGettable {
    typealias ViewModelType = ChartViewModelType
    func inject(viewModel: ViewModelType)
}

class ChartViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModelType?
    
    @IBOutlet private weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel?.input.viewDidLoad.onNext(())
    }
    
    deinit {
        viewModel?.input.viewWillDeinit.onNext(())
    }
    
    private func bindViewModel() {
        
        mockForTesting()
    }
    
    /// Mock of the data for testing purposes
    private func mockForTesting() {
        let value1 = ChartDataEntry(x: 1, y: 10)
        let value2 = ChartDataEntry(x: 2, y: 50)
        let value3 = ChartDataEntry(x: 3, y: -10)
        let value4 = ChartDataEntry(x: 4, y: -50)
        let dataSet = LineChartDataSet(entries: [value1, value2, value3, value4], label: "Measurement data")
        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
    }
    
}

extension ChartViewController: ChartViewControllerType {
    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}
