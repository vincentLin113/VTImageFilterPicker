//
//  ViewController.swift
//  ImageFilterPicker
//
//  Created by Lin Vincent on 2018/5/19.
//  Copyright © 2018 Lin Vincent. All rights reserved.
//

import UIKit
import VTImageFilterPicker

class ViewController: UIViewController {
    
    let sampleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "VTImageFilterPicker"
        view.backgroundColor = .white
        sampleButton.frame = CGRect(x: 100.0, y: 100.0, width: 100.0, height: 50.0)
        sampleButton.setTitle("Tap me", for: UIControlState())
        sampleButton.setTitleColor(.blue, for: UIControlState())
        sampleButton.addTarget(self, action: #selector(showSample(sender:)), for: .touchUpInside)
        view.addSubview(sampleButton)
        
    }

    @objc func showSample(sender: UIButton) {
        
        // customization
        
//        VTImageFilterPickerCustom.Appearance.backgroundColor = .brown
//        VTImageFilterPickerCustom.Appearance.displayStatusBar = true
//        VTImageFilterPickerCustom.Appearance.isDismissWithAnimate = false
        
        // instance
        let imageFilterPicker = VTImageFilterPicker(image: #imageLiteral(resourceName: "test"))
        imageFilterPicker.delegate = self
        self.present(imageFilterPicker, animated: true, completion: nil)
    }

}

//MARK: -
extension ViewController: VTImageFilterPickerDelegate {
    
    func pickerWillDismiss(pickViewController: VTImageFilterPicker, selectedButton: UIButton) {
        print("willDismiss")
    }
    
    func pickerDidDismiss(pickViewController: VTImageFilterPicker, selectedButton: UIButton) {
        print("didDismiss")
    }
    
    func pickerSelectedNextButton(pickViewController: VTImageFilterPicker, selectedButton: UIButton, selectedImage: UIImage) {
        pickViewController.dismiss(animated: true, completion: nil)
        sampleButton.setImage(selectedImage, for: UIControlState())
        print("selectedNextButton")
    }
    
    
}
