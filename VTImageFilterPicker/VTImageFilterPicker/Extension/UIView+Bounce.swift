//
//  UIView+Bounce.swift
//  ImageFilterPicker
//
//  Created by Lin Vincent on 2018/5/19.
//  Copyright © 2018 Lin Vincent. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func bounce(_ duration: Double = 0.6, delay: Double = 0.0) {
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [.curveEaseIn], animations: {
            self.transform = .identity
        }, completion: nil)
    }
}
