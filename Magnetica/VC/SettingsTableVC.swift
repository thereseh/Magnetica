//
//  SettingsTableVC.swift
//  Magnetica
//
//  Created by Therese Henriksson (RIT Student) on 3/3/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit

class SettingsTableVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // ivar
    let familyNames = UIFont.familyNames
    let fontColors = [(name: "Black", value: UIColor.black), (name: "Blue", value: UIColor.blue),
                      (name: "Red", value: UIColor.red), (name: "Green", value: UIColor.green)]
    private var kvoContext = 0
    
    // outlets
    @IBOutlet weak var fontStylePicker: UIPickerView!
    @IBOutlet weak var fontColorPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fontStylePicker.delegate = self
        self.fontStylePicker.dataSource = self
        
        self.fontColorPicker.delegate = self
        self.fontColorPicker.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver(self, forKeyPath: #keyPath(tableView.contentSize), options: .new, context: &kvoContext)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &kvoContext, keyPath == #keyPath(tableView.contentSize),
            let contentSize = change?[NSKeyValueChangeKey.newKey] as? CGSize  {
            self.popoverPresentationController?.presentedViewController.preferredContentSize = contentSize
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeObserver(self, forKeyPath: #keyPath(tableView.contentSize))
        super.viewDidDisappear(animated)
    }
    
    // Functions
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return familyNames.count
        } else {
            return fontColors.count
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return familyNames[row]
        } else {
            return fontColors[row].name
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedWordTheme = wordThemes[indexPath.row]
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneTapped(sender: AnyObject) {
        //let nCenter = NotificationCenter.default
        
//        for wordTheme in wordManager.wordBank {
//
//            if (wordTheme.name == selectedWordTheme) {
//                let data = ["Theme": wordTheme.value]
//                nCenter.post(name: myWordThemeChangedNotification, object: self, userInfo: data)
//            }
//        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

/*extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return colors.count
        } else if component == 1 {
            return pets.count
        }
        return 0
    }
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return colors[row]
        } else if component == 1 {
            return pets[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currentColor = colors[row]
        } else if component == 1 {
            currentPet = pets[row]
        }
        
        label.text = "\(currentColor) \(currentPet)"
    }
}*/



