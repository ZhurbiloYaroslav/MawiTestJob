//
//  MeasurementListDataSource.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import IGListKit

protocol MeasurementListDataSourceType: NSObject, ListAdapterDataSource {}

class MeasurementListDataSource: NSObject, MeasurementListDataSourceType {
    
    private var sections: [ListDiffable] = []
    
    override init() {
        self.sections = [
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "1", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "2", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "3", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "4", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "5", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "6", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "7", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "8", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "9", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "10", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "11", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "12", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "13", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "14", date: Date(), value: 145)))),
            MeasurementListSection(id: .measurement(MeasurementDisplayModel(model: Measurement(id: "15", date: Date(), value: 145))))
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
                        
                }))
                return PlaceholderSectionController(height: collectionViewHeight,
                                                    viewModel: viewModel)
            case .error(let image, let title, let message):
                let buttonModel = PlaceholderCellEmptyButtonModel(buttonAction: { [weak self] in
                    //self?.output?.reloadData()
                })
                let viewModel = PlaceholderCellErrorViewModel(image: image,
                                                              title: title,
                                                              message: message,
                                                              buttonModel: buttonModel)
                return PlaceholderSectionController(height: collectionViewHeight, viewModel: viewModel)
                
            case .preload:
                return LoadingSectionController(height: collectionViewHeight)
                
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
