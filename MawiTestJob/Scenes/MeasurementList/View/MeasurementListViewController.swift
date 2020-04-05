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
    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var addNewMeasureButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }()
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 3)
    }()
    private var sections: [ListDiffable] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
        configureAdapter()
        bindViewModel()
        viewModel?.input.viewDidLoad.onNext(())
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = addNewMeasureButton
    }
    
    private func configureAdapter() {
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    private func bindViewModel() {
        
        // Notify when 'Add new measurement' button was pressed
        addNewMeasureButton.rx.tap
            .map({ .endless })
            .bind(to: viewModel!.input.didPressAddNewMeasurement)
            .disposed(by: disposeBag)
        viewModel?.output.sections.subscribe(onNext: { [weak self] sections in
            self?.update(sections: sections)
        }).disposed(by: disposeBag)
    }
    
    func update(sections: [MeasurementListSection]) {
        self.sections = sections
        adapter.performUpdates(animated: true, completion: nil)
    }
}

extension MeasurementListViewController: MeasurementListViewControllerType {
    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}

extension MeasurementListViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        sections
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let section = object as? MeasurementListSection {
            switch section.id {
            case .empty:
                return PlaceholderSectionController(height: collectionView.bounds.height,
                                                    viewModel: PlaceholderCellEmptyViewModel(buttonModel: PlaceholderCellEmptyButtonModel(buttonAction: { [weak self] in
                                                        //self?.output?.reloadData()
                                                    })))
            case .error(let image, let title, let message):
                let buttonModel = PlaceholderCellEmptyButtonModel(buttonAction: { [weak self] in
                    //self?.output?.reloadData()
                })
                let viewModel = PlaceholderCellErrorViewModel(image: image,
                                                              title: title,
                                                              message: message,
                                                              buttonModel: buttonModel)
                return PlaceholderSectionController(height: collectionView.bounds.height, viewModel: viewModel)
            case .preload:
                return LoadingSectionController(height: collectionView.bounds.height)
            case .measurement(let measurement):
                return MeasurementListItemSectionController(measurement: measurement,
                                                             edges: .init(top: 5, left: 0, bottom: 0, right: 0))
            }
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
