//
//  FilterImageCell.swift
//  ImageFilterPicker
//
//  Created by Lin Vincent on 2018/5/19.
//  Copyright © 2018 Lin Vincent. All rights reserved.
//

import Foundation
import UIKit

public class VTFilterImageCell: UICollectionViewCell {
    
    static let identifier: String = "FilterImageCell"
    static let titleLabelHeight: CGFloat = 30.0
    
    let imageView: UIImageView = {
        let _imageView = UIImageView()
        _imageView.contentMode = .scaleAspectFill
        _imageView.isHidden = true
        return _imageView
    }()
    
    let titleLabel: PaddingLabel = {
        let _titleLabel = PaddingLabel()
        _titleLabel.backgroundColor = .clear
        _titleLabel.textAlignment = .center
        _titleLabel.isHidden = true
        _titleLabel.bottomInset = 10.0
        return _titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCustomSetting()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupCustomSetting()
    }
    
    public override var isSelected: Bool {
        didSet {
            self.titleLabel.textColor = (isSelected)
            ? VTImageFilterPickerCustom.Appearance.cellTitleTextSelectedColor
            : VTImageFilterPickerCustom.Appearance.cellTitleTextNormalColor
        }
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        clipsToBounds = true
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        setupShadow()
    }
    
}

//MARK: - Private

private extension VTFilterImageCell {
    
    func setupCustomSetting() {
        titleLabel.font = VTImageFilterPickerCustom.Appearance.cellTitleFont
        titleLabel.textColor = VTImageFilterPickerCustom.Appearance.cellTitleTextNormalColor
    }
    
    func setupConstraints() {
        // titleLabel
//        let titleLabelMaxHeight: CGFloat = 50.0
//        let titleLabelIntrinsicHeight: CGFloat = titleLabel.intrinsicContentSize.height
//        let titleLabelHeight: CGFloat = (titleLabelIntrinsicHeight > titleLabelMaxHeight)
//            ? titleLabelMaxHeight
//            : titleLabelIntrinsicHeight
        titleLabel.heightAnchor.constraint(equalToConstant: VTFilterImageCell.titleLabelHeight)
        titleLabel.anchorWithConstansToTop(topAnchor,
                                           left: leftAnchor,
                                           bottom: nil,
                                           right: rightAnchor,
                                           topConstant: 0.0,
                                           leftConstant: 0.0,
                                           rightConstant: 0.0,
                                           bottomConstant: 0.0)
        
        titleLabel.isHidden = false
        
        // imageView
        
        imageView.anchorWithConstansToTop(titleLabel.bottomAnchor,
                                          left: leftAnchor,
                                          bottom: bottomAnchor,
                                          right: rightAnchor,
                                          topConstant: 0.0,
                                          leftConstant: 0.0,
                                          rightConstant: 0.0,
                                          bottomConstant: 0.0)
        
        imageView.isHidden = false
    }
    
    
    func setupShadow() {
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.3
        layer.shadowColor = VTImageFilterPickerCustom.Appearance.collectionViewCellShadowColor.cgColor
    }
}

