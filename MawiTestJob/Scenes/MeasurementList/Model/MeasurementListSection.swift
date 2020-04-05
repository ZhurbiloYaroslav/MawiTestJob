//
//  MeasurementListSection.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import IGListKit

class MeasurementListSection {
    enum Identifier {
        case empty
        case preload
        case error(image: UIImage?, title: String, message: String)
        case measurement(_ measurement: MeasurementDisplayModelType)
        
        var name: NSString {
            switch self {
            case .empty: return "empty"
            case .preload: return "preload"
            case .error(_, let title, let message): return "error_\(title)_\(message)" as NSString
            case .measurement(let model): return "measurement_\(model.measurementId)" as NSString
            }
        }
    }
    
    let id: Identifier
    var items: [ListDiffable] = []
    
    init(id: Identifier) {
        self.id = id
    }
}

extension MeasurementListSection: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id.name
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self
            else { return false }
        return object.id.name == id.name
    }
}
