//
//  VTImageFilterPickerCustom.swift
//  ImageFilterPicker
//
//  Created by Lin Vincent on 2018/5/19.
//  Copyright © 2018 Lin Vincent. All rights reserved.
//

import Foundation
import UIKit

let bundle = Bundle(for: VTImageFilterPicker.self)

public struct VTImageFilterPickerCustom {
    
    public struct Appearance {
        
        public static var backgroundColor: UIColor = UIColor.white
        
        public static var rightBarButtonText: String = "Next"
        
        public static var dismissButtonIcon: UIImage = {
                return UIImage(named: "VTAssets.bundle/images/back", in: bundle, compatibleWith: nil)
                ?? UIImage()
        }()
        
        public static var rightBarButtonTextColor: UIColor = UIColor(red: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 1.0)
        
        public static var cellTitleTextSelectedColor: UIColor = .darkGray
        
        public static var cellTitleTextNormalColor: UIColor = .lightGray
        
        public static var cellTitleFont: UIFont = UIFont.systemFont(ofSize: 13.0)
        
        public static var imageViewContentMode = UIViewContentMode.scaleAspectFill
        
        public static var defaultImage: UIImage = {
                return UIImage(named: "VTAssets.bundle/images/defaultImageVT.jpg", in: bundle, compatibleWith: nil)
                    ?? UIImage()
            
        }()
        
        public static var displayStatusBar: Bool = false
        
        public static var collectionViewInset: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        
        public static var collectionViewItemSpace: CGFloat = 4.0
        
        public static var collectionViewCellShadowColor: UIColor = .gray
        
        public static var imageViewRatio: CGFloat = 1.0
        
        public static var isDismissWithAnimate: Bool = true
    }
    
}

