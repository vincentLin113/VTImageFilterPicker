//
//  Array+Safe.swift
//  ImageFilterPicker
//
//  Created by Lin Vincent on 2018/5/19.
//  Copyright © 2018 Lin Vincent. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return (0 <= index && index < self.count) ? self[index] : nil
    }
}
