//
//  UIView+UnderLine.swift
//  ImageFilterPicker
//
//  Created by Lin Vincent on 2018/5/19.
//  Copyright © 2018 Lin Vincent. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    func addUnderLine(_ height: CGFloat = 1.0, lineColor: UIColor = .gray) {
        let lineView: UIView = UIView()
        addSubview(lineView)
        lineView.backgroundColor = lineColor
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.heightAnchor.constraint(equalToConstant: height).isActive = true
        lineView.anchorWithConstansToTop(nil,
                                         left: leftAnchor,
                                         bottom: bottomAnchor,
                                         right: rightAnchor,
                                         topConstant: 0.0,
                                         leftConstant: 0.0,
                                         rightConstant: 0.0,
                                         bottomConstant: 0.0)
    }
}
