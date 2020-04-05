//
//  PlaceholderSectionController.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import IGListKit

final class PlaceholderSectionController: ListSectionController {
    
    private let height: CGFloat
    private let viewModel: PlaceholderCellViewModelling
    
    init(height: CGFloat = LoadingCell.height, viewModel: PlaceholderCellViewModelling) {
        self.height = height
        self.viewModel = viewModel
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
            .dequeueReusableCell(withNibName: R.nib.placeholderCell.name,
                                 bundle: nil,
                                 for: self, at: index) as? PlaceholderCell
            else { fatalError() }
        cell.configure(viewModel: viewModel)
        return cell
    }
}
