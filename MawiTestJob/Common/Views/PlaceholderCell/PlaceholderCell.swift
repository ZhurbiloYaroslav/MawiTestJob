//
//  PlaceholderCell.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class PlaceholderCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    private var buttonAction: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        actionButton.setRoundCorners()
    }
    
    func configure(viewModel: PlaceholderCellViewModelling) {
        imageView.image = viewModel.image
        imageView.isHidden = viewModel.imageVisibility.isHidden
        titleLabel.attributedText = viewModel.title
        titleLabel.isHidden = viewModel.titleVisibility.isHidden
        messageLabel.attributedText = viewModel.message
        messageLabel.isHidden = viewModel.messageVisibility.isHidden
        actionButton.setAttributedTitle(viewModel.buttonModel?.title, for: .normal)
        actionButton.backgroundColor = viewModel.buttonModel?.backgroundColor
        buttonAction = viewModel.buttonModel?.buttonAction
    }

    @IBAction func didPressButton(_ sender: UIButton) {
        buttonAction?()
    }
}
