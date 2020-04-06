//
//  MeasurementPoint.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 06.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

protocol MeasurementPointType {
    var value: Int { get }
}

struct MeasurementPoint: MeasurementPointType {
    let value: Int
}
