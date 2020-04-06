//
//  MeasurementListDataSource.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import IGListKit
import RxSwift

protocol MeasurementListDataSourceDelegate: class {
    func reloadData()
    func didSelectCell(measurement: IDContainable)
}
protocol MeasurementListDataSourceType: NSObject, ListAdapterDataSource {
    func attach(delegate: MeasurementListDataSourceDelegate)
    func getMeasurementWith(id: IDContainable) -> Observable<MeasurementDataSet>
}

class MeasurementListDataSource: NSObject {
    
    private weak var delegate: MeasurementListDataSourceDelegate?
    private var sections: [ListDiffable] = []
    
    override init() {
        self.sections = [
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: MeasurementDataSet(id: "1", date: Date(), data: [MeasurementPoint(value: 5)])))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: MeasurementDataSet(id: "2", date: Date(), data: [MeasurementPoint(value: 5)])))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: MeasurementDataSet(id: "3", date: Date(), data: [MeasurementPoint(value: 5)])))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: MeasurementDataSet(id: "4", date: Date(), data: [MeasurementPoint(value: 5)])))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: MeasurementDataSet(id: "5", date: Date(), data: [MeasurementPoint(value: 5)])))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: MeasurementDataSet(id: "6", date: Date(), data: [MeasurementPoint(value: 5)])))),
        ]
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return sections
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let collectionViewHeight: CGFloat = listAdapter.collectionView?.bounds.height
            else { return ListSectionController() }
        
        if let section = object as? MeasurementListSection {
            switch section.id {
                
            case .empty:
                let viewModel = PlaceholderCellEmptyViewModel(buttonModel:
                    PlaceholderCellEmptyButtonModel(buttonAction: { [weak self] in
                    self?.delegate?.reloadData()
                }))
                return PlaceholderSectionController(height: collectionViewHeight,
                                                    viewModel: viewModel)
            case .error(let image, let title, let message):
                let buttonModel = PlaceholderCellEmptyButtonModel(buttonAction: { [weak self] in
                    self?.delegate?.reloadData()
                })
                let viewModel = PlaceholderCellErrorViewModel(image: image,
                                                              title: title,
                                                              message: message,
                                                              buttonModel: buttonModel)
                return PlaceholderSectionController(height: collectionViewHeight, viewModel: viewModel)
                
            case .preload:
                return LoadingSectionController(height: collectionViewHeight)
                
            case .measurement(let measurement):
                let selectionAction: MeasurementListItemSectionController.SelectionAction = { [weak self] measurement in
                    self?.delegate?.didSelectCell(measurement: measurement)
                }
                let sectionController = MeasurementListItemSectionController(measurement: measurement,
                                                                             edges: .init(top: 5, left: 0, bottom: 0, right: 0),
                                                                             selectionAction: selectionAction)
                return sectionController
            }
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension MeasurementListDataSource: MeasurementListDataSourceType {
    func attach(delegate: MeasurementListDataSourceDelegate) {
        self.delegate = delegate
    }
    
    func getMeasurementWith(id: IDContainable) -> Observable<MeasurementDataSet> {
        // Mocked data for testing
        return Observable.create { observer in
            let values: [MeasurementPoint] = [
                MeasurementPoint(value: 5),
                MeasurementPoint(value: 15),
                MeasurementPoint(value: -5),
                MeasurementPoint(value: -15),
            ]
            observer.onNext(MeasurementDataSet(id: "1", date: Date(), data: values))
            return Disposables.create()
        }
    }
}
