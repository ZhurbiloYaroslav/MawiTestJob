//
//  MeasurementListItemSectionController.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import IGListKit

final class MeasurementListItemSectionController: ListSectionController {
    
    private let measurement: MeasurementDisplayModelType
    
    init(measurement: MeasurementDisplayModelType, edges: UIEdgeInsets) {
        self.measurement = measurement
        super.init()
        inset = edges
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let containerSize = collectionContext?.containerSize
            else { return .zero }
        let size: CGSize = {
            let width = containerSize.width - inset.left - inset.right
            let height = MeasurementListItemCell.height(for: width,
                                                        title: measurement.measurementId,
                                                        subtitle: measurement.measurementDataTime)
            return .init(width: width, height: height)
        }()
        return CGSize(width: size.width, height: size.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?
            .dequeueReusableCell(withNibName: R.nib.measurementListItemCell.name,
                                 bundle: nil,
                                 for: self, at: index) as? MeasurementListItemCell
            else { fatalError() }
        cell.configure(with: measurement)
        return cell
    }
}
