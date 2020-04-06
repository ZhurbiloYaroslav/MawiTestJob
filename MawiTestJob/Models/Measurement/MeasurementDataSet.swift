//
//  MeasurementDataSet.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

protocol MeasurementDataSetType {
    var id: String { get }
    var date: Date { get }
    var data: [MeasurementPointType] { get }
}

struct MeasurementDataSet: MeasurementDataSetType {
    let id: String
    let date: Date
    let data: [MeasurementPointType]
}
