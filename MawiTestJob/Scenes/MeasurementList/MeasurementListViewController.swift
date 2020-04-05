//
//  MeasurementListViewController.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol MeasurementListViewControllerType: UIViewControllerGettable {
    typealias ViewModelType = MeasurementListViewModelType
    func inject(viewModel: ViewModelType)
}

class MeasurementListViewController: UIViewController, MeasurementListViewControllerType {
    
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModelType?
    
    /// MARK: - UI outlets and variables
    private lazy var addNewMeasureButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
        bindViewModel()
        viewModel?.input.viewDidLoad.onNext(())
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = addNewMeasureButton
    }
    
    private func bindViewModel() {

        // Subscription for testing purposes
        viewModel?.output.bkgColor
            .subscribe(onNext: { [weak self] color in
                self?.view.backgroundColor = color
            }).disposed(by: disposeBag)
        
        // Notify when 'Add new measurement' button was pressed
        addNewMeasureButton.rx.tap
            .map({ .endless })
            .bind(to: viewModel!.input.didPressAddNewMeasurement)
            .disposed(by: disposeBag)
    }
}

extension MeasurementListViewController {
    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}
