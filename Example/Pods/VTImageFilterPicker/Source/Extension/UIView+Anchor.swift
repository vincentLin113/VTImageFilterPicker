//
//  UIView+Anchor.swift
//  ImageFilterPicker
//
//  Created by Lin Vincent on 2018/5/19.
//  Copyright © 2018 Lin Vincent. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func anchorWithConstansToTop(_ top:NSLayoutYAxisAnchor? = nil,
                                 left:NSLayoutXAxisAnchor? = nil,
                                 bottom: NSLayoutYAxisAnchor? = nil,
                                 right: NSLayoutXAxisAnchor? = nil,
                                 topConstant:CGFloat = 0,
                                 leftConstant:CGFloat = 0,
                                 rightConstant:CGFloat = 0,
                                 bottomConstant:CGFloat = 0) {
        _ = anchor(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
    }
    func anchor(_ top:NSLayoutYAxisAnchor? = nil,
                left:NSLayoutXAxisAnchor? = nil,
                bottom:NSLayoutYAxisAnchor? = nil,
                right:NSLayoutXAxisAnchor? = nil,
                topConstant:CGFloat = 0,
                leftConstant:CGFloat = 0,
                bottomConstant:CGFloat = 0,
                rightConstant:CGFloat = 0) -> [NSLayoutConstraint]? {
        translatesAutoresizingMaskIntoConstraints = false
        let anchors = [NSLayoutConstraint]()
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
        anchors.forEach({$0.isActive = true})
        return anchors
    }
}
