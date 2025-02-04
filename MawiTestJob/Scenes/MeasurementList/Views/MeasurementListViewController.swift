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
import IGListKit

protocol MeasurementListViewControllerType: UIViewControllerGettable {
    typealias ViewModelType = MeasurementListViewModelType
    func inject(viewModel: ViewModelType)
}

class MeasurementListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModelType?
    
    /// MARK: - UI outlets and variables
    @IBOutlet private weak var collectionView: UICollectionView!
    private lazy var addNewMeasureButton: UIBarButtonItem = {
        UIBarButtonItem(title: "Start new measurement", style: .plain, target: nil, action: nil)
    }()
    private lazy var adapter: ListAdapter = {
        ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 3)
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureAdapter()
        bindViewModel()
        viewModel?.input.viewDidLoad.onNext(())
    }
    
    deinit {
        viewModel?.input.viewWillDeinit.onNext(())
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = addNewMeasureButton
    }
    
    private func configureAdapter() {
        adapter.collectionView = collectionView
        adapter.dataSource = viewModel?.dataSource
        viewModel?.dataSource.attach(delegate: self)
    }
    
    private func bindViewModel() {
        
        // Notify when 'Add new measurement' button was pressed
        addNewMeasureButton.rx.tap
            .map({ .endless })
            .bind(to: viewModel!.input.didPressAddNewMeasurement)
            .disposed(by: disposeBag)
        // Notify that the data should be updated
        viewModel?.output.updateData.subscribe(onNext: { [weak self] in
            self?.updateData()
        }).disposed(by: disposeBag)
    }
    
    func updateData() {
        adapter.performUpdates(animated: true, completion: nil)
    }
}

extension MeasurementListViewController: MeasurementListViewControllerType {
    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}

extension MeasurementListViewController: MeasurementListDataSourceDelegate {
    func reloadData() {
        
    }
    
    func didSelectCell(measurement: IDContainable) {
        viewModel?.input.didSelectMeasurement.onNext(measurement)
    }
}
