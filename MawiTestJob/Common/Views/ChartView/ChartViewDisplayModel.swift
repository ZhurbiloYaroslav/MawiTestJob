//
//  ChartViewDisplayModel.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 06.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Charts

protocol ChartViewDisplayModelType {
    var dataEntries: [ChartDataEntry] { get }
}

struct ChartViewDisplayModel: ChartViewDisplayModelType {
    let dataEntries: [ChartDataEntry]
}
