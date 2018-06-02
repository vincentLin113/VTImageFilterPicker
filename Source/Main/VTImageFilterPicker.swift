//
//  VTImageFilterPicker.swift
//  ImageFilterPicker
//
//  Created by Lin Vincent on 2018/5/19.
//  Copyright © 2018 Lin Vincent. All rights reserved.
//

import Foundation
import UIKit


@objc public protocol VTImageFilterPickerDelegate: NSObjectProtocol {
    
    /**
     Call the method when picker will dismiss
     
     ---
     
     - note:
     Chinese: 這畫面即將關閉時呼叫
     */
    @objc optional func pickerWillDismiss(pickViewController: VTImageFilterPicker,
                                          selectedButton: UIButton)
    
    /**
     Call the method when picker Did dismiss
     
     ---
     
     - note:
     Chinese: 這畫面已經關閉時呼叫
     */
    @objc optional func pickerDidDismiss(pickViewController: VTImageFilterPicker,
                                          selectedButton: UIButton)
    
    /**
     Call the method when picker selected **NextButton**
     
     ---
     
     - note:
     Chinese: 這畫面點選NextButton時呼叫
     */
    @objc optional func pickerSelectedNextButton(pickViewController: VTImageFilterPicker,
                                                 selectedButton: UIButton,
                                                 selectedImage: UIImage)
}


/**
 ```
 let picker = VTImageFilterPicker(image: yourImage)
 present(picker)
 ```
 */
open class VTImageFilterPicker: UIViewController {
    
    public weak var delegate: VTImageFilterPickerDelegate?
    
    public var receiveImage: UIImage? = nil
    fileprivate var currentIndexOfAppliedFilter: Int = 0
    
    fileprivate let filterNameList = [
        "No Filter",
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CILinearToSRGBToneCurve",
        "CISRGBToneCurveToLinear"
    ]
    
    fileprivate let filterDisplayNameList = [
        "Normal",
        "Chrome",
        "Fade",
        "Instant",
        "Mono",
        "Noir",
        "Process",
        "Tonal",
        "Transfer",
        "Tone",
        "Linear"
    ]
    
    fileprivate let context = CIContext(options: nil)
    fileprivate let collectionViewHeight: CGFloat = 140.0
    fileprivate var smallImage: UIImage? = nil
    fileprivate var swipeLeftGesture: UISwipeGestureRecognizer? = nil
    fileprivate var swipeRightGesture: UISwipeGestureRecognizer? = nil
    
    //MARK: UI Declaration
    
    fileprivate let imageView: UIImageView = {
       let _imageView = UIImageView()
        _imageView.isHidden = true
        _imageView.isUserInteractionEnabled = true
        return _imageView
    }()
    
    /// contains **dismissButton** and **nextButton**
    fileprivate let topView: UIView = {
       let _topView = UIView()
        _topView.isHidden = true
        return _topView
    }()
    
    /// left barButton
    fileprivate let dismissButton: UIButton = {
       let _dismissButton = UIButton()
        _dismissButton.isHidden = true
        _dismissButton.translatesAutoresizingMaskIntoConstraints = false
        return _dismissButton
    }()
    
    /// right barButton
    fileprivate let nextButton: UIButton = {
       let _nextButton = UIButton()
        _nextButton.isHidden = true
        _nextButton.translatesAutoresizingMaskIntoConstraints = false
        return _nextButton
    }()
    
    /// show filtered images
    fileprivate let filterImagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let _filterImagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        _filterImagesCollectionView.backgroundColor = .clear
        _filterImagesCollectionView.isHidden = true
        _filterImagesCollectionView.showsHorizontalScrollIndicator = false
        _filterImagesCollectionView.allowsMultipleSelection = false
        _filterImagesCollectionView.allowsSelection = true
        return _filterImagesCollectionView
    }()
    
    
    //MARK: - Initial
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configure()
    }
    
    public convenience init(image: UIImage) {
        self.init(nibName: nil, bundle: nil)
        self.receiveImage = image
        self.configure()
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.configure()
    }

}

//MARK: -

extension VTImageFilterPicker {
    
    //MARK: - View Methods
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        assert(filterNameList.count == filterDisplayNameList.count, "filterNameList count or filterDisplayNameList count wrong")
        setupCustomSetting()
        setupViews()
        setupCollectionView()
        setupGesture()
        if let image = receiveImage {
            smallImage = resizeImage(image)
        }
    }
    
    open override var prefersStatusBarHidden: Bool {
        return !VTImageFilterPickerCustom.Appearance.displayStatusBar
    }
}



//MARK: - Private

private extension VTImageFilterPicker {
    
    
    
    func configure() {
        
        imageView.image = nil
        if let image = receiveImage {
            imageView.image = image
        } else {
            receiveImage = VTImageFilterPickerCustom.Appearance.defaultImage
            imageView.image = VTImageFilterPickerCustom.Appearance.defaultImage
        }
        
    }
    
    /**
     style the view according **VTImageFilterPickerCustom**
     */
    func setupCustomSetting() {
        // custom setting
        
        
        // nextButton
        nextButton.setTitle(VTImageFilterPickerCustom.Appearance.rightBarButtonText, for: UIControlState())
        nextButton.setTitleColor(VTImageFilterPickerCustom.Appearance.rightBarButtonTextColor, for: UIControlState())
        
        
        // imageView
        imageView.contentMode = VTImageFilterPickerCustom.Appearance.imageViewContentMode
        
        view.backgroundColor = VTImageFilterPickerCustom.Appearance.backgroundColor
    }
    
    /**
     addSubView + set constraint + **isHidden = false**
     
     ---
     
     - note:
     viewDidLoad call the method
     */
    func setupViews() {
        
        view.addSubview(topView)
        topView.addSubview(dismissButton)
        topView.addSubview(nextButton)
        topView.backgroundColor = .clear
        view.addSubview(imageView)
        view.addSubview(filterImagesCollectionView)
        
        dismissButton.removeTarget(self, action: nil, for: .allEvents)
        dismissButton.addTarget(self, action: #selector(dismissAction(sender:)), for: .touchUpInside)
        dismissButton.setImage(VTImageFilterPickerCustom.Appearance.dismissButtonIcon, for: UIControlState())
        
        nextButton.removeTarget(self, action: nil, for: .allEvents)
        nextButton.addTarget(self, action: #selector(nextAction(sender:)), for: .touchUpInside)
        
        // topView
        let topViewHeight: CGFloat = 50.0
        topView.addUnderLine()
        topView.anchorWithConstansToTop(view.topAnchor,
                       left: view.leftAnchor,
                       bottom: nil,
                       right: view.rightAnchor,
                       topConstant: 0.0,
                       leftConstant: 0.0,
                       rightConstant: 0.0,
                       bottomConstant: 0.0)
        topView.heightAnchor.constraint(equalToConstant: topViewHeight).isActive = true
        
        // dismissButton
        dismissButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: topViewHeight - 6.0).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: topViewHeight - 6.0).isActive = true
        
        let toolButtonMargin: CGFloat = 10.0
        
        dismissButton.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: toolButtonMargin).isActive = true
        
        
        // nextButton
        let nextButtonWidth: CGFloat = nextButton.intrinsicContentSize.width + 10.0
        nextButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: topViewHeight - 10.0).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: nextButtonWidth).isActive = true
        
        nextButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -toolButtonMargin).isActive = true

        topView.isHidden = false
        dismissButton.isHidden = false
        nextButton.isHidden = false
        
        // imageView
        imageView.anchorWithConstansToTop(topView.bottomAnchor,
                                          left: view.leftAnchor,
                                          bottom: nil,
                                          right: view.rightAnchor,
                                          topConstant: 0.0,
                                          leftConstant: 0.0,
                                          rightConstant: 0.0,
                                          bottomConstant: 0.0)
        let viewHeight = view.frame.width * VTImageFilterPickerCustom.Appearance.imageViewRatio
        imageView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        
        imageView.isHidden = false
        
        // collectionView
        
        
        filterImagesCollectionView.anchorWithConstansToTop(nil,
                                                           left: view.leftAnchor,
                                                           bottom: view.bottomAnchor,
                                                           right: view.rightAnchor,
                                                           topConstant: 0.0,
                                                           leftConstant: 0.0,
                                                           rightConstant: 0.0,
                                                           bottomConstant: 60.0)
        filterImagesCollectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight).isActive = true
        filterImagesCollectionView.isHidden = false
    }
    
    func setupCollectionView() {
        filterImagesCollectionView.register(VTFilterImageCell.self, forCellWithReuseIdentifier: VTFilterImageCell.identifier)
        filterImagesCollectionView.delegate = self
        filterImagesCollectionView.dataSource = self
    }
    
    
    func setupGesture() {
        swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(_:)))

        swipeLeftGesture?.direction = .left
        swipeRightGesture?.direction = .right
        
        guard let swipeLeft = swipeLeftGesture, let swipeRight = swipeRightGesture else {
            return
        }
        imageView.addGestureRecognizer(swipeLeft)
        imageView.addGestureRecognizer(swipeRight)
    }
    

    

    func generateFilteredImage(_ filterName: String, image: UIImage) -> UIImage? {
        let sourceImage = CIImage(image: image)
        
        guard let filter = CIFilter(name: filterName) else {
            return nil
        }
        filter.setDefaults()
        
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        guard let filterImage = filter.outputImage,
            let filterImageFrom = filter.outputImage?.extent else {
                return nil
        }
        guard let outputCGImage = context.createCGImage(filterImage, from: filterImageFrom) else {
            return nil
        }
        
        let filteredImage = UIImage(cgImage: outputCGImage)
        
        return filteredImage
    }
    
    func resizeImage(_ image: UIImage) -> UIImage? {
        let ratio: CGFloat = 0.3
        let resizedSize = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
        UIGraphicsBeginImageContext(resizedSize)
        let drawRect = CGRect(x: 0.0,
                              y: 0.0,
                              width: resizedSize.width,
                              height: resizedSize.height)
        image.draw(in: drawRect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    
    func applyFilterAndUpdateImageView(_ filterName: String) {
            if let image = self.receiveImage {
                
                // if selected **Normal** filter
                if let noFilterName = self.filterNameList[safe: 0] {
                    if filterName == noFilterName {
                        self.imageView.image = image
                        return
                    }
                }
                
                let filteredImage = self.generateFilteredImage(filterName, image: image)
                self.imageView.image = filteredImage
            }
        
    }
    
    func scrollToTargetIndexPath(_ indexPath: IndexPath) {
        if indexPath.section != 0 { return }
        DispatchQueue.main.async {
            if indexPath.row <= self.filterImagesCollectionView.numberOfItems(inSection: indexPath.section) {
                self.filterImagesCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }

    
}

//MARK: - Gesture actions

extension VTImageFilterPicker {
    @objc func handleGesture(_ gesture: UISwipeGestureRecognizer) {
        
        var isAdd: Bool = false
        
        switch gesture.direction {
        case .left:
            // add
            if currentIndexOfAppliedFilter < 0 || currentIndexOfAppliedFilter + 1 > filterNameList.count { return }
            currentIndexOfAppliedFilter += 1
            isAdd = true
            
        case .right:
            // minus
            if currentIndexOfAppliedFilter < 0 || currentIndexOfAppliedFilter - 1 < 0 { return }
            currentIndexOfAppliedFilter -= 1
            
        default:
            break ;
        }
        
        if let filteredMethodName = filterNameList[safe: currentIndexOfAppliedFilter] {
            applyFilterAndUpdateImageView(filteredMethodName)
            let targetIndexPath = IndexPath(item: currentIndexOfAppliedFilter, section: 0)
            scrollToTargetIndexPath(targetIndexPath)
        } else {
            if isAdd {
                currentIndexOfAppliedFilter -= 1
            } else {
                currentIndexOfAppliedFilter += 1
            }
        }
        
    }

}


//MARK: - Button actions

extension VTImageFilterPicker {
    
    @objc func dismissAction(sender: UIButton) {
        delegate?.pickerWillDismiss?(pickViewController: self, selectedButton: sender)
        DispatchQueue.main.async {
            self.dismiss(animated: VTImageFilterPickerCustom.Appearance.isDismissWithAnimate, completion: {
                self.delegate?.pickerDidDismiss?(pickViewController: self, selectedButton: sender)
            })
        }
    }
    
    @objc func nextAction(sender: UIButton) {
        if let image = imageView.image {
            delegate?.pickerSelectedNextButton?(pickViewController: self,
                                                selectedButton: sender,
                                                selectedImage: image)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension VTImageFilterPicker: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterDisplayNameList.count == filterNameList.count
        ? filterDisplayNameList.count
        : 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VTFilterImageCell.identifier, for: indexPath) as? VTFilterImageCell else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = nil
        cell.imageView.image = nil
        if let filterDisplayName = filterDisplayNameList[safe: indexPath.row],
        let filteredMethodName = filterNameList[safe: indexPath.row],
        let image = smallImage
            {
                cell.titleLabel.text = filterDisplayName
                if let resizedImage = generateFilteredImage(filteredMethodName, image: image) {
                    cell.imageView.image = resizedImage
                } else {
                    cell.imageView.image = image
                }
        }
        
        cell.backgroundColor = .clear

        return cell
    }
    
}


//MARK: - UICollectionViewDelegate

extension VTImageFilterPicker: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return VTImageFilterPickerCustom.Appearance.collectionViewInset
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return VTImageFilterPickerCustom.Appearance.collectionViewItemSpace
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 { return }
        assert(indexPath.item < filterNameList.count, "error")
        if let selectedFilterName = filterNameList[safe: indexPath.row] {
            DispatchQueue.main.async {
                self.currentIndexOfAppliedFilter = indexPath.item
                self.applyFilterAndUpdateImageView(selectedFilterName)
                let cell = collectionView.cellForItem(at: indexPath)
                cell?.bounce()
                if indexPath.item < collectionView.numberOfItems(inSection: indexPath.section) {
                    self.scrollToTargetIndexPath(indexPath)
                }
            }
        }
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension VTImageFilterPicker: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 20.0
        let height: CGFloat = collectionViewHeight - space
        let width: CGFloat = height - ( (VTFilterImageCell.titleLabelHeight) )
        return CGSize(width: width, height: height)
    }
}

















