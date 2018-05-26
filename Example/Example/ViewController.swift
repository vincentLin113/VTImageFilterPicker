//
//  ViewController.swift
//  Example
//
//  Created by Lin Vincent on 2018/5/26.
//  Copyright © 2018 Lin Vincent. All rights reserved.
//

import UIKit
import VTImageFilterPicker

class ViewController: UIViewController {
    
    let titles: [String] = [
        "Open Picker With Image",
        "Open Picker",
        "Customization"
    ]
    
    var images: [UIImage?] = [
    #imageLiteral(resourceName: "exampleImage1"),
    nil,
    #imageLiteral(resourceName: "exampleImage2")
    ]
    
    fileprivate var selectedIndex: Int = 0
    
    let tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        _tableView.tableFooterView = UIView()
        return _tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if titles.count > indexPath.row {
            cell.textLabel?.text = titles[indexPath.row]
        }
        
        if images.count > indexPath.row {
            cell.imageView?.image = images[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row > titles.count { return }
        
        selectedIndex = indexPath.row
        
        var picker: VTImageFilterPicker?
        VTImageFilterPickerCustom.Appearance.displayStatusBar = false
        VTImageFilterPickerCustom.Appearance.collectionViewItemSpace = 4.0
        VTImageFilterPickerCustom.Appearance.rightBarButtonText = "Next"
        VTImageFilterPickerCustom.Appearance.isDismissWithAnimate = true
        
        
        switch indexPath.row {
            
            case 0:
            
                if let image = images[indexPath.row] {
                    picker = VTImageFilterPicker(image: image)
                }
            
        case 1:
            
            picker = VTImageFilterPicker()

        case 2:
            
            if let image = images[indexPath.row] {
                VTImageFilterPickerCustom.Appearance.defaultImage = image
            }
            VTImageFilterPickerCustom.Appearance.displayStatusBar = true
            VTImageFilterPickerCustom.Appearance.collectionViewItemSpace = 10
            VTImageFilterPickerCustom.Appearance.rightBarButtonText = "Custom"
            VTImageFilterPickerCustom.Appearance.isDismissWithAnimate = false
            picker = VTImageFilterPicker()
            
        default:
            break;
            
        }
        
        
        assert(picker != nil, "error")
        picker?.delegate = self
        DispatchQueue.main.async {
            self.present(picker!, animated: true, completion: nil)
        }
    }
    
}


extension ViewController: VTImageFilterPickerDelegate {
    
    func pickerSelectedNextButton(pickViewController: VTImageFilterPicker, selectedButton: UIButton, selectedImage: UIImage) {
        images[selectedIndex] = selectedImage
        pickViewController.dismiss(animated: true) {
            self.tableView.reloadData()
        }
    }
    
}













