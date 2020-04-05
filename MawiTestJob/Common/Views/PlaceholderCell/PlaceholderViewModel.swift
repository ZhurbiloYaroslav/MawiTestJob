//
//  PlaceholderViewModel.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import BonMot

protocol PlaceholderCellViewModelling {
    var image: UIImage? { get }
    var title: NSAttributedString? { get }
    var message: NSAttributedString? { get }
    var buttonModel: PlaceholderCellButtonModelling? { get }
    var imageVisibility: Visibility { get }
    var titleVisibility: Visibility { get }
    var messageVisibility: Visibility { get }
    var buttonVisibility: Visibility { get }
}

extension PlaceholderCellViewModelling {
    static var titleStyle: StringStyle {
        StringStyle(.font(UIFont.defaultFont(.medium, size: 16)),
                    .color(.black))
    }
    static var messageStyle: StringStyle {
        StringStyle(.font(UIFont.defaultFont(.regular, size: 14)),
                    .color(.black))
    }
}

struct PlaceholderCellErrorViewModel: PlaceholderCellViewModelling {
    
    var image: UIImage?
    var title: NSAttributedString?
    var message: NSAttributedString?
    var buttonModel: PlaceholderCellButtonModelling?
    
    var imageVisibility: Visibility { .visible }
    var titleVisibility: Visibility { .visible }
    var messageVisibility: Visibility { .visible }
    var buttonVisibility: Visibility { .visible }
    
    init(image: UIImage?, title: String, message: String, buttonModel: PlaceholderCellButtonModelling) {
        self.image = image
        self.title = title.styled(with: Self.titleStyle)
        self.message =  message.styled(with: Self.messageStyle)
        self.buttonModel = buttonModel
    }
}

struct PlaceholderCellEmptyViewModel: PlaceholderCellViewModelling {
    
    var buttonModel: PlaceholderCellButtonModelling?
    
    var image: UIImage? {
        R.image.data_loading_empty()
    }
    
    var title: NSAttributedString? {
        "There is no data".styled(with: Self.titleStyle)
    }
    
    var message: NSAttributedString? {
        var message = "This is a view for handling empty state."
        message += "\n" + "Please press 'Reload' button to load data."
        return message.styled(with: Self.messageStyle)
    }
    
    var imageVisibility: Visibility { .visible }
    var titleVisibility: Visibility { .visible }
    var messageVisibility: Visibility { .visible }
    var buttonVisibility: Visibility { .visible }
}
