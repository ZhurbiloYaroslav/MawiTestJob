//
//  MeasurementDisplayModel.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import BonMot

protocol MeasurementDisplayModelType {
    var measurementId: NSAttributedString { get }
    var measurementDataTime: NSAttributedString { get }
}

struct MeasurementDisplayModel: MeasurementDisplayModelType {
    var measurementId: NSAttributedString
    var measurementDataTime: NSAttributedString
    
    init(model: MeasurementType) {
        self.measurementId = model.id.styled(with: Self.idStyle)
        self.measurementDataTime = model.date.description.styled(with: Self.dateTimeStyle)
    }
}

// MARK: - Styles
extension MeasurementDisplayModel {
    /// Styles for measurementId
    private static let idStyle: StringStyle = {
        StringStyle(.font(UIFont.defaultFont(.medium, size: 16)),
                    .color(.darkGray))
    }()
    /// Styles for measurementDataTime
    private static let dateTimeStyle: StringStyle = {
        StringStyle(.font(UIFont.defaultFont(.regular, size: 14)),
                    .color(.darkGray))
    }()
}
