//
//  MeasurementListItemCell.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class MeasurementListItemCell: UICollectionViewCell {
    private static let minHeight: CGFloat = 60
    
    @IBOutlet private weak var measurementIdLabel: UILabel!
    @IBOutlet private weak var measurementDateTimeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        measurementIdLabel.attributedText = nil
        measurementDateTimeLabel.attributedText = nil
    }
    
    func configure(with displayModel: MeasurementDisplayModelType) {
        measurementIdLabel.attributedText = displayModel.measurementId
        measurementDateTimeLabel.attributedText = displayModel.measurementDataTime
    }
    
    static func height(for width: CGFloat, title: NSAttributedString?, subtitle: NSAttributedString?) -> CGFloat {
        return Self.minHeight
    }

}
