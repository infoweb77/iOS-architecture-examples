//
//  UIFont+Size.swift
//  MVVM-Subjects-Observables
//
//  Created by alex on 14/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

enum FontSize {
    case extraSmall
    case small
    case middle
    case normal
    case normalMid
    case big
    case huge
    case extraHuge
    case custom(CGFloat)
}

enum FontType {
    case normal
    case bold
    case italic
}

extension UIFont {
    class func app(type: FontType, size: CGFloat) -> UIFont {
        switch type {
        case .normal:   return .systemFont(ofSize: size)
        case .bold:     return .boldSystemFont(ofSize: size)
        case .italic:   return .italicSystemFont(ofSize: size)
        }
    }
    
    class func app(type: FontType, size: FontSize) -> UIFont {
        var s: CGFloat!
        
        switch size {
        case .extraSmall: s = 10.0
        case .small: s = 12.0
        case .middle: s = 14.0
        case .normal: s = 16.0
        case .normalMid: s = 18.0
        case .big: s = 24.0
        case .huge: s = 28.0
        case .extraHuge: s = 36.0
        case .custom(let _s): s = _s
        }
        
        
        return self.app(type: type, size: s)
    }
}
