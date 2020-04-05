//
//  UIFont+defaultFont.swift
//  MawiTestJob
//
//  Created by Yaroslav Zhurbilo on 05.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

extension UIFont {
    struct DefaultFont {
        enum Weight {
            case regular
            case medium
            case italic
            case bold
        }
        
        let weight: Weight
        
        init(_ weight: Weight) {
            self.weight = weight
        }
        
        func ofSize(_ size: CGFloat) -> UIFont {
            let fontName: String = {
                switch weight {
                case .regular: return R.font.robotoRegular.fontName
                case .medium: return R.font.robotoMedium.fontName
                case .italic: return R.font.robotoItalic.fontName
                case .bold: return R.font.robotoBold.fontName
                }
            }()
            
            guard let font = UIFont(name: fontName, size: size) else {
                fatalError("Font instantiation failed")
            }
            
            return font
        }
    }
    
    static func defaultFont(_ weight: DefaultFont.Weight, size: CGFloat) -> UIFont {
        return DefaultFont(weight).ofSize(size)
    }
}
