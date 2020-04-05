//
//  LoadingSectionController.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import IGListKit

final class LoadingSectionController: ListSectionController {
    
    private let height: CGFloat
    
    init(height: CGFloat = LoadingCell.height) {
        self.height = height
        super.init()
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let containerSize = collectionContext?.containerSize
            else { return .zero }
        let width = containerSize.width - inset.left - inset.right
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?
            .dequeueReusableCell(withNibName: R.nib.loadingCell.name,
                                 bundle: nil,
                                 for: self, at: index) as? LoadingCell
            else { fatalError() }
            cell.startActivityIndicatorAnimation()
        return cell
    }
}
