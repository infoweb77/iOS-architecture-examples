//
//  ComponentLabel.swift
//  MVVM-Closures
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class ComponentLabel: UILabel {
    
    convenience init(props: ComponentLabelProperty...) {
        self.init(frame: .zero)
        self.textColor = .black
        self.font = .app(type: .normal, size: .normal)
        propertiesArray(props)
    }
    
    func propertiesArray(_ properties: [ComponentLabelProperty]) {
        
        properties.forEach { property in
            switch property {
            case .font(let t, let s):
                font = .app(type: t, size: s)
            case .multiLine:
                numberOfLines = 0
                lineBreakMode = .byWordWrapping
            case .color(let c):
                textColor = c
            case .text(let t):
                text = t
            case .center:
                textAlignment = .center
            case .right:
                textAlignment = .right
            case .left:
                textAlignment = .left
            case .userEnabled(let s):
                isUserInteractionEnabled = s
            case .lines(let l):
                numberOfLines = l
                lineBreakMode = .byWordWrapping
            case .background(let c):
                backgroundColor = c
            case .cb(let cb):
                cb(self)
            case .adjusts(let b):
                adjustsFontSizeToFitWidth = b
            case .frame(let x, let y, let width, let height):
                frame = CGRect(x: x, y: y, width: width, height: height)
            case .lineBreak(let b):
                lineBreakMode = b
            case .cornerRadius(let r):
                layer.cornerRadius = r ?? 5.0
                layer.masksToBounds = true
            }
        }
    }
    
    func properties(_ properties: ComponentLabelProperty...) {
        propertiesArray(properties)
    }
    
    func lines() -> Int {
        let textSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(sizeThatFits(textSize).height))
        let charSize = lroundf(Float(font.lineHeight))
        return rHeight / charSize
    }
}

enum ComponentLabelProperty {
    case font(FontType, FontSize)
    case multiLine
    case color(UIColor)
    case text(String)
    case center
    case right
    case left
    case userEnabled(Bool)
    case lines(Int)
    case background(UIColor)
    case cb((UILabel) -> Void)
    case adjusts(Bool)
    case frame(CGFloat, CGFloat, CGFloat, CGFloat)
    case lineBreak(NSLineBreakMode)
    case cornerRadius(CGFloat?)
}


