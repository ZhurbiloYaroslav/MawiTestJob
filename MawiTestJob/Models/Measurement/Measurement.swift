//
//  Measurement.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 04.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

protocol MeasurementModelling {
    var id: String { get }
    var date: Date { get }
    var value: Int { get }
}

struct Measurement: MeasurementModelling {
    let id: String
    let date: Date
    let value: Int
}
