//
//  UIView+AddSubviews.swift
//  MVP
//
//  Created by alex on 09/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    func addSubviews(_ subViews: UIView...) -> UIView {
        return addSubviews(subViews)
    }
    
    @objc @discardableResult
    func addSubviews(_ subViews: [UIView]) -> UIView {
        for sv in subViews {
            addSubview(sv)
            sv.translatesAutoresizingMaskIntoConstraints = false
        }
        return self
    }
}
