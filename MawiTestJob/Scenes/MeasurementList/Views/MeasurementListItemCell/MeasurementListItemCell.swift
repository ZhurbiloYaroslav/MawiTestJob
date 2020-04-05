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
    
    @IBOutlet weak var some1: UILabel!
    @IBOutlet weak var some2: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        some1.attributedText = nil
        some2.attributedText = nil
    }
    
    func configure(with displayModel: MeasurementDisplayModelType) {
        some1.attributedText = displayModel.measurementId
        some2.attributedText = displayModel.measurementDataTime
    }
    
    static func height(for width: CGFloat, title: NSAttributedString?, subtitle: NSAttributedString?) -> CGFloat {
        return Self.minHeight
    }

}
